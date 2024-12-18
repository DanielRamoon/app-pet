import Loader from "@components/Loader";
import MapActionsOverlay from "@components/Map/MapActionsOverlay";
import CountdownModal from "@components/Modals/CountdownModal";
import ThemedView from "@components/utils/ThemedView";
import useAppTheme from "@hooks/useAppTheme";
import useColors from "@hooks/useColors";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import i18n from "@utils/i18n";
import { LOCATION_TASK_NAME } from "@utils/requestLocationPermissions";
import walkService from "@utils/supabase/services/walk/walk.service";
import { mapThemes } from "@utils/theme";
import * as Location from "expo-location";
import LottieView from "lottie-react-native";
import { Button, Text } from "native-base";
import React, { useEffect, useRef, useState } from "react";
import { Alert, BackHandler, DeviceEventEmitter, Platform, StyleSheet, View } from "react-native";
import MapView, { MAP_TYPES, PROVIDER_GOOGLE, Polyline } from "react-native-maps";
import { useDispatch, useSelector } from "react-redux";
import {
	finishWalk,
	pauseWalk,
	resetWalk,
	resumeWalk,
	startWalk,
	updateDurationByOneSecond,
	// updateWalkData,
	updateWalkDataDistance,
} from "src/store/features/walkSlice";
import { RootState } from "src/store/store";
import { ILineProps } from "types/pets";
import PetList from "../../components/Map/PetList";
import WalkInfoModal, { WalkInfoActions } from "@components/Modals/Fullscreen/WalkInfoModal";
import userService, { IUser } from "@utils/supabase/services/user.service";
import { supabase } from "@utils/supabase/client";
import { UserResponse } from "@supabase/supabase-js";
import axios from "axios";
import { IOSMGeocodeResponse } from "types/geocoding";
import { TouchableOpacity } from "react-native";

export function convertLocationToILineProps(location: Location.LocationObject): ILineProps {
	return {
		latitude: location.coords.latitude,
		longitude: location.coords.longitude,
		timestamp: String(location.timestamp),
	};
}

async function checkPermission(): Promise<boolean> {
	return new Promise(async (resolve) => {
		const { status: statusFore } = await Location.requestForegroundPermissionsAsync();
		if (statusFore !== "granted") {
			Alert.alert(i18n.get("permissionAlertTitle"), i18n.get("permissionAlert"));

			return resolve(false);
		}

		const hasPermission = await Location.getBackgroundPermissionsAsync();

		if (hasPermission.status === "granted") {
			return resolve(true);
		}

		Alert.alert(
			i18n.get("permissionAlertTitle"),
			i18n.get("permissionAlert"),
			[
				{
					text: i18n.get("confirm"),
					onPress: async () => {
						const { status: statusBack } = await Location.requestBackgroundPermissionsAsync();
						if (statusBack !== "granted") {
							Alert.alert(i18n.get("permissionAlertTitle"), i18n.get("permissionAlert"));

							return resolve(false);
						}

						return resolve(true);
					},
				},
			],
			{ cancelable: false }
		);
	});
}

async function enableNetworkProvider() {
	if (Platform.OS === "ios") return true;

	const providerStatus = await Location.getProviderStatusAsync();
	if (!providerStatus.networkAvailable) {
		Alert.alert(i18n.get("permissionAlertTitle"), i18n.get("enableNetworkProvider"));

		await Location.enableNetworkProviderAsync();
	}

	return true;
}

export default function ({ navigation }: NativeStackScreenProps<any, "MainTabs">) {
	// Redux
	const currentWalk = useSelector((state: RootState) => state.currentWalk);
	const dispatch = useDispatch();

	// Hooks
	const colors = useColors();
	const [appTheme] = useAppTheme();

	// Refs
	const mapViewRef = useRef<MapView>(null);
	const isFocused = useRef(false);

	// Local state
	const [loading, setLoading] = useState<boolean>(true);
	const [permission, setPermission] = useState<boolean>(false);
	const [selectedPets, setSelectedPets] = useState<string[]>([] as string[]);
	const [starting, setStarting] = useState<boolean>(false);
	const [showWalkInfoModal, setShowWalkInfoModal] = useState<boolean>(false);
	const [profile, setProfile] = useState<IUser | null>(null);
	const [updateDistanceInterval, setUpdateDistanceInterval] = useState<NodeJS.Timeout | null>(null);
	const [locationUpdatesEnabled, setLocationUpdatesEnabled] = useState<boolean>(false);

	// Functions
	const handlePetSelectionChange = (petIds: string[]) => {
		setSelectedPets(petIds);
	};

	const handleAction = async (action: WalkInfoActions) => {
		switch (action) {
			case "stop":
				// Obtém o centro da cidade a partir da localização
				getCityCenterFromLocation().then((baseLocation) => {
					if (!baseLocation || !baseLocation[0]) return;

					// Atualiza o mapa para mostrar o centro da cidade
					mapViewRef.current?.animateCamera(
						{
							center: {
								latitude: baseLocation[0] < 0 ? baseLocation[0] - 0.032 : baseLocation[0] + 0.032,
								longitude: baseLocation[1],
							},
							pitch: 25,
							zoom: 13,
						},
						{ duration: 2000 }
					);

					mapViewRef.current?.setMapBoundaries(
						{
							latitude: baseLocation[0] + 0.05,
							longitude: baseLocation[1] + 0.05,
						},
						{
							latitude: baseLocation[0] - 0.05,
							longitude: baseLocation[1] - 0.05,
						}
					);
				});

				// Verifica se a duração da caminhada é menor que 15 segundos
				if (currentWalk.value.duration < 15) {
					Alert.alert(i18n.get("walkCantFinished"), i18n.get("walkCantFinishedMessage"));
					dispatch(resetWalk());

					clearInterval(updateDistanceInterval!);
					setLocationUpdatesEnabled(false); // Adiciona isso para garantir que o rastreamento é parado
					await Location.stopLocationUpdatesAsync(LOCATION_TASK_NAME);

					break;
				}

				Alert.alert(i18n.get("finishWalkQuestion"), undefined, [
					{ text: i18n.get("cancel"), style: "cancel" },
					{
						text: i18n.get("confirm"),
						onPress: async () => {
							clearInterval(updateDistanceInterval!);
							setLocationUpdatesEnabled(false); // Adiciona isso para garantir que o rastreamento é parado

							setLoading(true);

							await Location.stopLocationUpdatesAsync(LOCATION_TASK_NAME);
							await new Promise((resolve) => setTimeout(resolve, 500));

							// Finaliza a caminhada
							dispatch(finishWalk({ walkIds: [] }));
							await new Promise((resolve) => setTimeout(resolve, 500));

							const finishedWalkData = { ...currentWalk.value.walk };

							finishedWalkData.date_end = new Date().toISOString();
							finishedWalkData.updated_at = new Date().toISOString();

							const result = await walkService.saveWalk({
								...finishedWalkData,
								duration: currentWalk.value.duration,
								total_distance: currentWalk.value.distance,
								petIds: currentWalk.value.petsData.map((p) => p.id),
							});

							// Atualiza o id da caminhada
							dispatch(finishWalk({ walkIds: result.data?.map((walk) => walk.id)! }));
							await new Promise((resolve) => setTimeout(resolve, 500));

							setLoading(false);

							if (result.status !== 200) Alert.alert(i18n.get("error"), i18n.get("errorOccurred"));

							setShowWalkInfoModal(true);
						},
					},
				]);

				break;

			case "pause":
				dispatch(pauseWalk());
				clearInterval(updateDistanceInterval!);
				setLocationUpdatesEnabled(false); // Adicione esta linha
				await Location.stopLocationUpdatesAsync(LOCATION_TASK_NAME);
				break;
			case "resume":
				dispatch(resumeWalk());
				setUpdateDistanceInterval(setInterval(() => dispatch(updateDurationByOneSecond()), 1000));
				setLocationUpdatesEnabled(true);
				await Location.startLocationUpdatesAsync(LOCATION_TASK_NAME, {
					accuracy: Location.Accuracy.BestForNavigation,
					pausesUpdatesAutomatically: true,
					activityType: Location.ActivityType.Fitness,
					showsBackgroundLocationIndicator: true,
					foregroundService: {
						notificationTitle: i18n.get("walkInProgress"),
						notificationBody: "Petvidade",
						notificationColor: colors.primary,
					},
				});
				break;
			case "details":
				setShowWalkInfoModal(true);
				break;
			case "delete":
				Alert.alert(i18n.get("deleteWalkQuestion"), undefined, [
					{ text: i18n.get("cancel"), style: "cancel" },
					{
						text: i18n.get("confirm"),
						onPress: async () => {
							setLoading(true);

							try {
								await Location.stopLocationUpdatesAsync(LOCATION_TASK_NAME);
							} catch (error) {}

							for (const walkId of currentWalk.value.walkIds!) {
								const result = await walkService.deleteWalk(walkId);

								if (result.status !== 200) throw new Error(`Failed to delete walk - ${JSON.stringify(result)}`);
							}

							dispatch(resetWalk());
							setShowWalkInfoModal(false);
							setLoading(false);
						},
					},
				]);

				break;
		}
	};

	const checkAndStartWalk = async () => {
		if (selectedPets.length === 0) return;

		try {
			setStarting(true);

			// Obtém a localização atual do usuário
			const location = await Location.getCurrentPositionAsync({ accuracy: Location.Accuracy.BestForNavigation });

			await new Promise((resolve) =>
				setTimeout(() => {
					// Inicia a caminhada
					dispatch(
						startWalk({
							pets: selectedPets.map((petId) => ({ id: petId, name: "QUERY" })),
							user: { id: profile?.id!, name: profile?.user_name!, image: profile?.avatar_url! },
						})
					);

					clearInterval(updateDistanceInterval!);
					setUpdateDistanceInterval(setInterval(() => dispatch(updateDurationByOneSecond()), 1000));

					resolve(true);
				}, 1500)
			);

			// Foca a câmera no usuário, um pouco abaixo do centro da tela
			mapViewRef.current?.animateCamera(
				{
					center: {
						latitude: location.coords.latitude - -0.0000009,
						longitude: location.coords.longitude,
					},
					zoom: 19,
					pitch: 17,
				},
				{ duration: 2000 }
			);

			// Ativa o tracking da localização do usuário
			await Location.startLocationUpdatesAsync(LOCATION_TASK_NAME, {
				accuracy: Location.Accuracy.BestForNavigation,
				pausesUpdatesAutomatically: true,
				activityType: Location.ActivityType.Fitness,
				showsBackgroundLocationIndicator: true,
				foregroundService: {
					notificationTitle: i18n.get("walkInProgress"),
					notificationBody: "Petvidade",
					notificationColor: colors.primary,
				},
			});
		} catch (error) {
			Alert.alert("Err", String(error));
			dispatch(resetWalk());
		}
	};

	const getCityCenterFromLocation = async () => {
		const location = await Location.getCurrentPositionAsync({ accuracy: Location.Accuracy.High });
		const { latitude, longitude } = location.coords;

		try {
			const locationGeocodeRequest = await axios.get<IOSMGeocodeResponse>(
				`https://nominatim.openstreetmap.org/reverse?lat=${latitude}&lon=${longitude}&format=json`
			);

			if (!locationGeocodeRequest.data.address.city || !locationGeocodeRequest.data.address.state) return null;

			const cityLocation = `${locationGeocodeRequest.data.address.city}, ${locationGeocodeRequest.data.address.state}`;

			const cityLocationGeocodeRequest = await axios.get<IOSMGeocodeResponse[]>(
				`https://nominatim.openstreetmap.org/search?format=json&q=${cityLocation}`
			);

			if (cityLocationGeocodeRequest.data.length === 0) return null;

			const cityCenter = cityLocationGeocodeRequest.data[0];

			return [Number(cityCenter.lat), Number(cityCenter.lon)];

			//
		} catch (error) {
			console.log(error);
			return null;
		}
	};

	// Effects
	useEffect(() => {
		// Função para iniciar o rastreamento da localização e intervalo de distância
		const startLocationUpdates = async () => {
			await Location.startLocationUpdatesAsync(LOCATION_TASK_NAME, {
				accuracy: Location.Accuracy.BestForNavigation,
				pausesUpdatesAutomatically: true,
				activityType: Location.ActivityType.Fitness,
				showsBackgroundLocationIndicator: true,
				foregroundService: {
					notificationTitle: i18n.get("walkInProgress"),
					notificationBody: "Petvidade",
					notificationColor: colors.primary,
				},
			});
			setLocationUpdatesEnabled(true);
			setUpdateDistanceInterval(setInterval(() => dispatch(updateDurationByOneSecond()), 1000));
		};

		// Função para parar o rastreamento da localização e intervalo de distância
		const stopLocationUpdates = async () => {
			clearInterval(updateDistanceInterval!);
			setLocationUpdatesEnabled(false);
			await Location.stopLocationUpdatesAsync(LOCATION_TASK_NAME);
		};

		const permission = checkPermission();
		permission
			.then(async (result) => {
				setPermission(result);

				if (result) {
					await enableNetworkProvider();
					await startLocationUpdates();
				}
			})
			.finally(() => setLoading(false));

		const unsubscribeBlur = navigation.addListener("blur", () => {
			isFocused.current = false;
		});

		const unsubscribeFocus = navigation.addListener("focus", () => {
			isFocused.current = true;
		});

		const unsubscribeBack = BackHandler.addEventListener("hardwareBackPress", () => {
			if (!isFocused.current) return false;
			return true;
		});

		const unsubscribeWalkData = DeviceEventEmitter.addListener(
			"foregroundBackgroundEvent",
			async (locations: Location.LocationObject[]) => {
				// Limpa as localizações salvas do background (já que o usuário está usando o app)
				await AsyncStorage.setItem("@petvidade:backgroundLocations", "[]");

				// Converte as localizações para o formato do ILineProps
				const lineProps = locations.map(convertLocationToILineProps);

				try {
					dispatch(updateWalkDataDistance(lineProps));
				} catch (error) {
					console.log(locations);
					console.log("[foregroundBackgroundEvent]", error);
				}
			},
			[currentWalk.status]
		);

		// Obtém o usuário logado
		(async () => {
			const profileData = await userService.getLoggedUserProfile();
			setProfile(profileData.data as IUser);
		})();

		// Obtém a localização do usuário e centraliza o mapa nela
		Location.getCurrentPositionAsync({ accuracy: Location.Accuracy.High }).then((location) => {
			mapViewRef.current?.setMapBoundaries(
				{
					latitude: location.coords.latitude + 0.05,
					longitude: location.coords.longitude + 0.05,
				},
				{
					latitude: location.coords.latitude - 0.05,
					longitude: location.coords.longitude - 0.05,
				}
			);

			mapViewRef.current?.animateCamera(
				{
					center: {
						latitude: location.coords.latitude,
						longitude: location.coords.longitude,
					},
					zoom: 19,
					pitch: 35,
					heading: location.coords.heading ?? 0,
				},
				{ duration: 2000 }
			);
		});

		return () => {
			stopLocationUpdates();
			unsubscribeWalkData.remove();
			unsubscribeBack.remove();
			unsubscribeBlur();
			unsubscribeFocus();
		};
	}, []);

	if (loading) return <Loader absolute bgColor={colors.background} />;
	else if (!permission) {
		return (
			<ThemedView>
				<View style={{ display: "flex", alignItems: "center", justifyContent: "center", height: "100%" }}>
					<LottieView
						source={require("@assets/lottie/enableLocation.json")}
						autoPlay
						style={{ width: 300, height: 280, top: -45 }}
						loop={true}
						resizeMode="contain"
					/>
					<Text style={{ width: "80%", textAlign: "center", fontSize: 16 }}>{i18n.get("permissionAlert")}</Text>
				</View>
			</ThemedView>
		);
	} else
		return (
			<>
				{/* #region MODAIS */}
				{starting && <CountdownModal onAnimationFinish={() => setStarting(false)} />}
				{/* #endregion MODAIS */}

				<ThemedView fadeIn>
					{showWalkInfoModal && (
						<WalkInfoModal
							// petData={selectedPets.map((petId) => ({ id: petId, name: "QUERY" }))}
							onAction={(action) => handleAction(action)}
							onClose={() => setShowWalkInfoModal(false)}
						/>
					)}

					{currentWalk.status === "idle" && !starting ? (
						<View
							style={{
								position: "absolute",
								height: 305,
								width: "100%",
								zIndex: 100,
								bottom: 30,
								display: "flex",
								gap: 0,
							}}
						>
							<PetList onChangePetSelection={handlePetSelectionChange} forceUpdate={currentWalk.status === "idle"} />
							<View>
								<Button
									onPress={checkAndStartWalk}
									style={{
										marginHorizontal: 26,
										backgroundColor: selectedPets.length === 0 ? "#666" : colors.primary,
									}}
									disabled={selectedPets.length === 0}
								>
									<Text style={{ color: "white" }}>
										{selectedPets.length === 0 ? i18n.get("selectPetBeforeWalk") : i18n.get("startWalk")}
									</Text>
								</Button>
							</View>
						</View>
					) : (
						<MapActionsOverlay onAction={handleAction} />
					)}

					{/* MAP */}
					{permission && (
						<View style={styles.container}>
							<MapView
								ref={mapViewRef}
								provider={PROVIDER_GOOGLE}
								mapType={MAP_TYPES.STANDARD}
								style={styles.map}
								// initialCamera={{
								// 	center: {
								// 		latitude: -21.16, // Incrementar em 0.03 para a lista de pet não ficar sobreposta com a localização do usuário
								// 		longitude: -48.973928984917706,
								// 	},
								// 	heading: 0,
								// 	pitch: 25,
								// 	zoom: 13,
								// }}
								showsMyLocationButton
								showsUserLocation
								showsBuildings={false}
								showsPointsOfInterest={false}
								customMapStyle={appTheme === "light" ? mapThemes.light : mapThemes.dark}
								showsIndoors={false}
								showsIndoorLevelPicker={false}
								onPanDrag={() => {}}
								onRegionChange={() => {}}
								onRegionChangeComplete={() => {}}
								followsUserLocation
							>
								{((currentWalk.value.walk.distance as ILineProps[][]) ?? []).map((point, index) => (
									<Polyline
										coordinates={point}
										strokeColor={appTheme === "light" ? colors.primary : colors.white}
										strokeWidth={5}
										zIndex={1}
										key={index}
									/>
								))}
							</MapView>
						</View>
					)}
				</ThemedView>
			</>
		);
}

const styles = StyleSheet.create({
	infoScreenToggleSection: {
		position: "absolute",
		display: "flex",
		flexDirection: "row",
		justifyContent: "space-between",
		bottom: 0,
		left: 0,
		right: 0,
		height: 100,
		width: "100%",
		backgroundColor: "transparent",
		zIndex: 100,
	},
	infoScreenToggle: {
		width: 50,
		height: 50,
		borderRadius: 50,
		backgroundColor: "white",
		alignSelf: "center",
		marginLeft: "auto",
		marginRight: "auto",
		marginBottom: "auto",
		padding: 0,
	},
	container: {
		flex: 1,
	},
	map: {
		width: "100%",
		height: "100%",
	},
});
