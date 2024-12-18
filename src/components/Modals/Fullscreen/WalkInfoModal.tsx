import { FontAwesome5, Ionicons, MaterialCommunityIcons, MaterialIcons } from "@expo/vector-icons";
import useAppTheme from "@hooks/useAppTheme";
import useColors from "@hooks/useColors";
import flex from "@styles/flex";
import petBucket from "@utils/supabase/buckets/pets";
import petsService from "@utils/supabase/services/pets/pets.service";
import { IPetWalk } from "@utils/supabase/services/walk/walk.service";
import { mapThemes } from "@utils/theme";
import { formatTime } from "@utils/time";
import { calculateMapRegion } from "@utils/utilities";
import { activateKeepAwakeAsync, deactivateKeepAwake } from "expo-keep-awake";
import * as Location from "expo-location";
import * as Sharing from "expo-sharing";
import { DateTime } from "luxon";
import { Button, Text } from "native-base";
import React, { useCallback, useEffect, useRef, useState } from "react";
import { Alert, Animated, AppState, BackHandler, Dimensions, Image, StyleSheet, View } from "react-native";
import { TouchableOpacity } from "react-native-gesture-handler";
import MapView, { Circle, LatLng, MAP_TYPES, PROVIDER_GOOGLE, Polyline } from "react-native-maps";
import { captureRef } from "react-native-view-shot";
import { useDispatch, useSelector } from "react-redux";
import { pauseWalk, resetWalk, resumeWalk, toogleBar } from "src/store/features/walkSlice";
import { RootState } from "src/store/store";
import { ILineProps, petProps } from "types/pets";
import ShareModal from "../ShareModal";

export type WalkInfoActions = "delete" | "stop" | "pause" | "resume" | "share" | "details" | undefined;

function WalkInfoModal(props: {
	onClose: () => void;
	onAction: (action: WalkInfoActions) => void;
	initialLocation?: Location.LocationObject;
	fixedWalk?: IPetWalk & {
		user_id: string;
		user_image: string;
		user_name: string;
		pet_name?: string;
		pet_image?: string;
	};
	petData?: petProps[];
}) {
	const [theme] = useAppTheme();
	const colors = useColors();
	const dispatch = useDispatch();
	const currentWalk = useSelector((state: RootState) => state.currentWalk);

	const [loaded, setLoaded] = useState<boolean>(false);
	const [lockedScreen, setLockedScreen] = useState<boolean>(false);
	const [sharing, setSharing] = useState<"compact" | "full" | "internal" | undefined>();
	const [showShareModal, setShowShareModal] = useState<boolean>(false);

	const [overlayCoords, setOverlayCoords] = useState<{ latitude: number; longitude: number }>();
	const [showMap, setShowMap] = useState<boolean>(true);

	const [petData, setPetData] = useState({ name: "", image: null as string | null | undefined });
	const [petLength, setPetLength] = useState<number>(0);
	const [userData, setUserData] = useState({ name: "", image: "" });

	const screenShotRef = useRef<any>();
	const screenShotFullRef = useRef<any>();
	const translateY = useRef(new Animated.Value(1));
	const map = useRef<MapView>(null as any);

	// const [compactMode, setCompactMode] = useState(false);

	const [lastBackgroundTime, setLastBackgroundTime] = useState<number | null>(null);
	const [backgroundDuration, setBackgroundDuration] = useState(0);
	const appStateRef = useRef<"background" | "active" | "inactive" | "unknown" | "extension">(AppState.currentState);

	const [appState, setAppState] = useState(AppState.currentState);
	const [elapsedTime, setElapsedTime] = useState(0);
	const [isPaused, setIsPaused] = useState(false);
	const [pauseStartTime, setPauseStartTime] = useState<number | null>(null);
	const [lastResumeTime, setLastResumeTime] = useState<number | null>(null);

	useEffect(() => {
		const subscription = AppState.addEventListener("change", (nextAppState) => {
			if (appState.match(/inactive|background/) && nextAppState === "active") {
				// O aplicativo foi restaurado
				if (!isPaused) {
					const now = new Date().getTime();
					if (lastResumeTime !== null) {
						const resumedDuration = now - lastResumeTime;
						setElapsedTime((prevElapsedTime) => prevElapsedTime + resumedDuration);
					}
					setLastResumeTime(now);
				}
			}

			setAppState(nextAppState);
		});

		return () => {
			subscription.remove();
		};
	}, [appState]);

	const handlePauseResume = () => {
		const now = new Date().getTime();

		if (currentWalk?.status === "paused") {
			// Retomar a caminhada
			if (pauseStartTime !== null) {
				const pausedDuration = now - pauseStartTime;
				setElapsedTime((prevElapsedTime) => prevElapsedTime + pausedDuration);
			}
			setLastResumeTime(now);
			setPauseStartTime(null);
			setIsPaused(false);
			dispatch(resumeWalk());
		} else {
			// Pausar a caminhada
			setPauseStartTime(now);
			setIsPaused(true);
			dispatch(pauseWalk());
		}
	};

	useEffect(() => {
		const interval = setInterval(() => {
			if (!isPaused && currentWalk?.status !== "paused") {
				// Apenas atualize o tempo se não estiver pausado
				setElapsedTime((prevElapsedTime) => prevElapsedTime + 1000); // Incrementa 1 segundo
			}
		}, 1000); // Intervalo de 1 segundo

		return () => clearInterval(interval);
	}, [isPaused, currentWalk?.status]);

	useEffect(() => {
		const handleAppStateChange = (nextAppState: "active" | "background" | "inactive" | "unknown" | "extension") => {
			if (appStateRef.current.match(/inactive|background/) && nextAppState === "active") {
				// O app voltou para o primeiro plano
				if (isPaused || currentWalk?.status === "paused") {
					// Se o app estiver pausado, não atualize o tempo
					return;
				}
				if (lastBackgroundTime) {
					const now = new Date().getTime();
					const timeInBackground = Math.floor((now - lastBackgroundTime) / 1000); // tempo em segundos
					setBackgroundDuration((prevDuration) => prevDuration + timeInBackground);
				}
			} else if (nextAppState.match(/inactive|background/)) {
				// O app foi para segundo plano
				setLastBackgroundTime(new Date().getTime());
			}
			appStateRef.current = nextAppState;
			setAppState(nextAppState);
		};

		const subscription = AppState.addEventListener("change", handleAppStateChange);

		return () => {
			subscription.remove();
		};
	}, [lastBackgroundTime, isPaused, currentWalk?.status]);

	const totalDuration = (props.fixedWalk?.duration ?? currentWalk?.value.duration) + backgroundDuration;

	useEffect(() => {
		if (!props.fixedWalk)
			(async () => {
				if (props.petData != undefined || currentWalk?.value?.petsData[0]) {
					const petImage = petBucket.getPetPhoto(
						currentWalk?.value?.petsData[0]?.id ?? props.petData![0].id,
						currentWalk?.value.userData.id
					).data;

					const petName = await petsService.getPetName(currentWalk?.value?.petsData[0]?.id ?? props.petData![0].id);

					setPetData({
						name: (currentWalk?.value?.petsData ?? props.petData)[0].name.replace("QUERY", petName.data!),
						image: petImage,
					});

					setPetLength((currentWalk?.value?.petsData ?? props.petData).length);
				}
				const userImage = currentWalk.value?.userData?.image;

				if (userImage) setUserData({ name: String(currentWalk?.value.userData.name), image: userImage });
			})()
				.catch((e) => console.log(e))
				.finally(() => setLoaded(true));
		else {
			setPetData({
				name: props.fixedWalk.pet_name ?? "",
				image: props.fixedWalk.pet_image ?? "",
			});

			setLoaded(true);
			setTimeout(() => animateMap(), 550);
		}

		const unsubscribeBack = BackHandler.addEventListener("hardwareBackPress", () => {
			if (lockedScreen) return true;

			closeModal();

			return true;
		});

		return () => {
			unsubscribeBack.remove();

			console.log(currentWalk.hideAppBar, currentWalk.hideTabBar);
			console.log("UNMOUNTING");

			dispatch(toogleBar({ value: false }));
		};
	}, []);

	useEffect(() => {
		if (loaded) {
			animateIn();

			if (currentWalk.status === "finished") animateMap();
		}
	}, [loaded]);

	useEffect(() => {
		if (lockedScreen) {
			activateKeepAwakeAsync();
		} else {
			deactivateKeepAwake();
		}
	}, [lockedScreen]);

	function closeModal() {
		animateOut();

		if (currentWalk && currentWalk.status === "finished") dispatch(resetWalk());

		setTimeout(() => props.onClose(), 1000);
		setLoaded(false);
	}

	const animateMap = useCallback(() => {
		const correctedRegion = calculateMapRegion(
			(props?.fixedWalk?.distance as ILineProps[][]) ?? (currentWalk?.value.walk?.distance as ILineProps[][])
		);

		if (correctedRegion && map?.current) {
			try {
				map?.current.animateCamera(
					{
						center: {
							latitude: correctedRegion.latitude,
							longitude: correctedRegion.longitude,
						},
						zoom: Math.log2(360 / (correctedRegion.longitudeDelta * 1.5)), // Calculate zoom level based on longitude delta
					},
					{ duration: 1000 } // Set the desired animation duration
				);
			} catch (error) {
				console.log(error);
			}

			setOverlayCoords({ latitude: correctedRegion.latitude, longitude: correctedRegion.longitude });
		}
	}, [props?.fixedWalk, currentWalk?.value.walk?.distance, map]);

	const [open, setOpen] = useState(false);

	const animateIn = () => {
		if (open) return;

		setOpen(true);
		try {
			dispatch(toogleBar({}));

			Animated.timing(translateY.current, {
				toValue: 0,
				duration: 300,
				useNativeDriver: true,
			}).start();
		} catch (error: any) {
			Alert.alert("!!!", error);
		}
	};

	const animateOut = () => {
		setOpen(false);
		dispatch(toogleBar({}));

		Animated.timing(translateY.current, {
			toValue: 1,
			duration: 300,
			useNativeDriver: true,
		}).start();
	};

	const onShare = (options?: {
		completeShare: boolean;
		mode: "compact" | "full" | "internal";
		showMap: boolean;
		text?: string;
	}) => {
		if (options?.mode === "internal") {
			Alert.alert("INTERNAL", options.text);
			return;
		}

		if (!options?.completeShare) return setShowShareModal(true);

		setShowMap(options?.showMap);
		setSharing(options?.mode);
		setShowShareModal(false);

		setTimeout(async () => {
			try {
				const localUri = await captureRef(options?.mode === "compact" ? screenShotRef : screenShotFullRef, {
					// height: 1080,
					// width: 1080,
					format: "jpg",
					quality: 1,
				});

				if (localUri) {
					Sharing.shareAsync(localUri, {
						mimeType: "image/png",
						dialogTitle: `Share`,
						UTI: "walk?.png",
					});
				}

				return null;
			} catch (e) {
				console.log(e);
			} finally {
				setSharing(undefined);
			}
		}, 300);
	};

	const [petImageError, setPetImageError] = useState(false);
	const handlePetImageError = () => {
		setPetImageError(true);
	};

	const [totalDistance, setTotalDistance] = useState<string | number>(0);
	const [totalDistanceMeasure, setTotalDistanceMeasure] = useState<"km" | "m">("km");

	useEffect(() => {
		if (!(Number(totalDistance) > 0 && currentWalk.status === "finished")) {
			const distance = props?.fixedWalk?.total_distance ?? currentWalk?.value.distance;

			if (distance?.km > 1) setTotalDistance(distance?.km?.toFixed(1));
			else if (distance?.km > 0) setTotalDistance((distance?.km * 1000).toFixed(1));
			else setTotalDistance(distance?.km);

			setTotalDistanceMeasure(distance?.km > 1 ? "km" : "m");
		}
	}, [props?.fixedWalk, currentWalk?.value]);

	if (!loaded) return <View />;

	return (
		<Animated.View
			collapsable={false}
			ref={screenShotFullRef}
			style={[
				styles.overlay,
				{
					backgroundColor: colors.backgroundSecondary,
					transform: [
						{
							translateY: translateY.current.interpolate({
								inputRange: [0, 1],
								outputRange: [0, 1000],
							}),
						},
					],
				},
			]}
		>
			{showShareModal && (
				<ShareModal
					cancel={() => setShowShareModal(false)}
					confirm={(returning) =>
						onShare({ completeShare: true, mode: returning.mode, showMap: returning.showMap, text: returning.text })
					}
				/>
			)}

			<View
				ref={screenShotRef}
				collapsable={false}
				style={{ backgroundColor: colors.backgroundSecondary, paddingBottom: 10 }}
			>
				<View style={styles.topSection}>
					{!lockedScreen && (
						<View style={{ marginRight: "auto", opacity: sharing ? 0 : 1 }}>
							<TouchableOpacity
								onPress={closeModal}
								style={{ width: 50 }}
								// style={{ display: "flex", justifyContent: "center", width: 50, height: "100%", paddingLeft: 15 }}
							>
								<Ionicons name="chevron-back" size={24} color={colors.text} style={{ ...flex.mxAuto }} />
							</TouchableOpacity>
						</View>
					)}
					{sharing !== "compact" && (
						<Text style={styles.topSectionText}>
							{(props.fixedWalk?.date_start
								? DateTime.fromISO(props.fixedWalk?.date_start)
								: DateTime.now()
							).toLocaleString({
								day: "2-digit",
								month: "2-digit",
								year: "numeric",
								hour: "2-digit",
								minute: "2-digit",
								hour12: false,
							})}
						</Text>
					)}
					{!lockedScreen && (
						<View style={{ marginLeft: "auto", opacity: 0 }}>
							<TouchableOpacity
								onPress={() => {}}
								style={{ width: 50 }}
								// style={{ display: "flex", justifyContent: "center", width: 50, height: "100%", paddingLeft: 15 }}
							>
								<Ionicons name="chevron-back" size={24} color={colors.text} style={{ ...flex.mxAuto }} />
							</TouchableOpacity>
						</View>
					)}
				</View>

				<MapView
					collapsable={false}
					ref={map}
					provider={PROVIDER_GOOGLE}
					mapType={sharing && !showMap ? MAP_TYPES.NONE : MAP_TYPES.STANDARD}
					style={{
						width: "100%",
						height: 200,
						marginTop: 20,
					}}
					// region={{
					// 	latitude: props?.initialLocation?.coords.latitude ?? 0,
					// 	longitude: props?.initialLocation?.coords.longitude ?? 0,
					// 	latitudeDelta: 0.0027,
					// 	longitudeDelta: 0.0027,
					// }}
					// initialCamera={{
					// 	center: {
					// 		latitude: props?.initialLocation?.coords.latitude ?? 0,
					// 		longitude: props?.initialLocation?.coords.longitude ?? 0,
					// 	},
					// 	heading: props?.initialLocation?.coords.heading ?? 0,
					// 	pitch: 0,
					// }}
					showsUserLocation={!props?.fixedWalk && !sharing}
					followsUserLocation={!props?.fixedWalk}
					showsTraffic={false}
					showsBuildings={false}
					showsPointsOfInterest={false}
					showsMyLocationButton={false}
					pitchEnabled={false}
					pointerEvents="none"
					rotateEnabled={false}
					scrollDuringRotateOrZoomEnabled={false}
					scrollEnabled={false}
					showsCompass={false}
					showsIndoors={false}
					showsScale={false}
					showsIndoorLevelPicker={false}
					zoomTapEnabled={false}
					zoomControlEnabled={false}
					zoomEnabled={false}
					cacheEnabled={false}
					userLocationPriority="high"
					customMapStyle={theme === "dark" ? mapThemes.dark : mapThemes.light}
					onUserLocationChange={(location) => {
						if (props.fixedWalk) return;
						if (currentWalk?.status === "finished") return;
						try {
							map?.current.animateCamera({
								center: {
									latitude: location.nativeEvent.coordinate?.latitude || 0,
									longitude: location.nativeEvent.coordinate?.longitude || 0,
								},
								heading: 0,
								// pitch: isWalking ? 25 : 0,
								zoom: 17.3,
							});
						} catch (error) {
							console.log(error);
						}
					}}
					maxZoomLevel={20}
					minZoomLevel={15}
				>
					{overlayCoords && sharing && !showMap && (
						<Circle center={overlayCoords} radius={6371 * 100} fillColor={colors.background} />
					)}

					{((props.fixedWalk?.distance ?? (currentWalk.value.walk.distance as ILineProps[][])) as any[])?.map(
						(point: LatLng[], index: number) => (
							<Polyline
								coordinates={point}
								strokeColor={theme === "light" ? colors.primary : colors.white}
								strokeWidth={5}
								zIndex={1}
								key={index}
							/>
						)
					)}
				</MapView>

				<View
					style={[
						{
							display: "flex",
							flexDirection: "row",
							justifyContent: "space-between",
							marginTop: 10,
							marginLeft: 10,
							marginRight: 10,
							paddingBottom: 20,
							borderBottomColor: colors.text,
							borderBottomWidth: 1,
						},
						// Compartilhamento compacto
						sharing === "compact"
							? {
									position: "absolute",
									top: 0,
									width: Dimensions.get("screen").width,
									borderBottomColor: "transparent",
									borderBottomWidth: 0,
									marginTop: 0,
									marginLeft: 0,
									marginRight: 0,
									padding: 10,
									paddingRight: 9,
							  }
							: {},
					]}
				>
					{(props.fixedWalk?.user_image || userData.image) && (
						<View style={{ display: "flex", flexDirection: "row" }}>
							<Image
								style={{
									width: 50,
									borderRadius: 99,
									height: 50,
									marginRight: "auto",
									...flex.myAuto,
								}}
								// contentFit="fill"
								// contentFit="cover"
								source={{
									uri: props.fixedWalk?.user_image ?? userData?.image ?? undefined,
									headers: {
										Pragma: "no-cache",
									},
								}}
								alt="User image"
							/>
							<Text style={{ marginLeft: 5, fontWeight: "bold" }}>{userData.name || props.fixedWalk?.user_name}</Text>
						</View>
					)}

					<View style={{ display: "flex", flexDirection: "row" }}>
						<View style={{ marginRight: 5 }}>
							<Text style={{ fontWeight: "bold" }}>{petData.name}</Text>
							{petLength > 1 && <Text style={{ fontWeight: "bold" }}>e mais {petLength - 1}</Text>}
						</View>
						{props.petData === undefined ? (
							!petImageError ? (
								<Image
									style={{
										width: 50,
										borderRadius: 99,
										height: 50,
										marginRight: "auto",
										...flex.myAuto,
									}}
									onError={handlePetImageError}
									source={
										!props.fixedWalk?.pet_image && !petData?.image
											? {
													uri: petBucket.getPetPhoto().data,
											  }
											: {
													uri: props.fixedWalk?.pet_image ?? petData?.image ?? undefined,
													headers: {
														Pragma: "no-cache",
													},
											  }
									}
									alt="Pet image"
								/>
							) : (
								<Image
									style={{
										width: 50,
										height: 50,
										borderRadius: 99,
										marginRight: "auto",
										...flex.myAuto,
									}}
									source={{ uri: petBucket.getPetPhoto().data }}
									alt="Pet image"
								/>
							)
						) : (
							<View
								style={{
									borderRadius: 99,
									display: "flex",
									justifyContent: "center",
									alignItems: "center",
									marginRight: "auto",
								}}
							>
								{props.petData.length === 1 ? (
									petImageError ? (
										<Image
											style={{
												width: 50,
												height: 50,
												borderRadius: 99,
												marginRight: "auto",
												...flex.myAuto,
											}}
											source={{ uri: petBucket.getPetPhoto().data }}
											alt="Pet image"
										/>
									) : (
										<Image
											style={{
												width: 50,
												height: 50,
												marginRight: "auto",
												borderRadius: 99,
												...flex.myAuto,
											}}
											onError={handlePetImageError}
											source={
												!props.fixedWalk?.pet_image && !petData?.image
													? {
															uri: petBucket.getPetPhoto().data,
													  }
													: {
															uri: props.fixedWalk?.pet_image ?? petData?.image ?? undefined,
															headers: {
																Pragma: "no-cache",
															},
													  }
											}
											alt="Pet image"
										/>
									)
								) : (
									<>
										{petImageError ? (
											<Image
												style={{
													width: 50,
													height: 50,
													borderRadius: 99,
													marginRight: "auto",
													...flex.myAuto,
												}}
												source={{ uri: petBucket.getPetPhoto().data }}
												alt="Pet image"
											/>
										) : (
											<Image
												style={{
													width: 50,
													height: 50,
													marginRight: "auto",
													borderRadius: 99,
													...flex.myAuto,
												}}
												onError={handlePetImageError}
												source={
													!props.fixedWalk?.pet_image && !petData?.image
														? {
																uri: petBucket.getPetPhoto().data,
														  }
														: {
																uri: props.fixedWalk?.pet_image ?? petData?.image ?? undefined,
																headers: {
																	Pragma: "no-cache",
																},
														  }
												}
												alt="Pet image"
											/>
										)}
										<Text
											style={{
												fontSize: 22,
												fontWeight: "bold",
												textAlign: "center",
												textAlignVertical: "center",
												position: "absolute",
												backgroundColor: "gray",
												opacity: 0.6,
												width: 50,
												height: 50,
												borderRadius: 99,
											}}
										>
											{props.petData!.length > 9 ? "+9" : `+${props.petData!.length - 1}`}
										</Text>
									</>
								)}
							</View>
						)}
					</View>
				</View>

				<View style={styles.kmSection}>
					{sharing !== "compact" && (
						<View
							style={{
								display: "flex",
								flexDirection: "row",
								alignItems: "center",
							}}
						>
							<Text
								style={{
									color: colors.text,
									fontSize: 60,
									lineHeight: 100,
									fontWeight: "bold",
								}}
							>
								{totalDistance}
							</Text>
							<Text style={{ color: colors.text, marginTop: "auto", marginBottom: 25 }}>{totalDistanceMeasure}</Text>
						</View>
					)}

					<View
						style={{
							display: "flex",
							flexDirection: "row",
							justifyContent: "space-around",
							width: "100%",
							marginTop: sharing === "compact" ? 20 : 50,
						}}
					>
						{sharing === "compact" && (
							<View
								style={{
									display: "flex",
									flexDirection: "column",
									alignItems: "center",
									justifyContent: "center",
									width: 100,
								}}
							>
								{/* <FontAwesome5 name="walking" size={24} color={colors.text} /> */}
								<MaterialCommunityIcons name="map-marker-distance" size={24} color={colors.text} />
								<View
									style={{
										display: "flex",
										flexDirection: "row",
										alignItems: "center",
									}}
								>
									<Text style={{ color: colors.text }}>{totalDistance}</Text>
									<Text style={{ color: colors.text }}>{totalDistanceMeasure}</Text>
								</View>
							</View>
						)}

						<View
							style={{
								display: "flex",
								flexDirection: "column",
								alignItems: "center",
								justifyContent: "center",
								width: 100,
							}}
						>
							<FontAwesome5 name="walking" size={24} color={colors.text} />
							<Text style={{ color: colors.text }}>
								{props?.fixedWalk?.total_distance?.humanDistance ?? currentWalk?.value.distance.humanDistance}
							</Text>
						</View>

						<View
							style={{
								display: "flex",
								flexDirection: "column",
								alignItems: "center",
								justifyContent: "center",
								width: 100,
							}}
						>
							<MaterialIcons name="pets" size={24} color={colors.text} />
							<Text style={{ color: colors.text }}>
								{props?.fixedWalk?.total_distance?.animalDistance ?? currentWalk?.value.distance.animalDistance}
							</Text>
						</View>
						<View
							style={{
								display: "flex",
								flexDirection: "column",
								alignItems: "center",
								justifyContent: "center",
								width: 100,
							}}
						>
							<Ionicons name="time-outline" size={24} color={colors.text} />
							<Text style={{ color: colors.text }}>{formatTime(totalDuration)}</Text>
						</View>
					</View>
				</View>
			</View>
			{/* Problema acima */}

			{sharing ? (
				<View style={styles.bottomSection} />
			) : (
				<View style={styles.bottomSection}>
					{currentWalk?.status === "finished" || props?.fixedWalk ? (
						// || currentWalk.value.duration === 0 ||
						// currentWalk.value.distance.humanDistance === 0 ||
						// currentWalk.value.distance.animalDistance === 0
						<>
							<Button
								style={[styles.fabMap, { backgroundColor: colors.danger }]}
								shadow={2}
								size="sm"
								onPress={() => props.onAction("delete")}
							>
								<Ionicons style={{ left: 0, top: 1 }} name="trash" size={24} color="white" />
							</Button>
							<Button
								style={[styles.fabMap, { backgroundColor: colors.primary }]}
								shadow={2}
								size="sm"
								onPress={() => onShare()}
							>
								<Ionicons name="share-social" size={24} style={{ marginRight: 5 }} color="white" />
							</Button>
						</>
					) : (
						<>
							<Button
								style={[styles.fabMap, { backgroundColor: colors.danger }]}
								shadow={2}
								size="sm"
								onPress={() => (props.onAction("stop"), closeModal())}
							>
								<Ionicons style={{ left: 1, top: 1 }} name="stop" size={24} color="white" />
							</Button>
							<Button
								style={[styles.fabMap, { width: 100, height: 100, backgroundColor: colors.primary }]}
								shadow={2}
								size="sm"
								onPress={handlePauseResume}
							>
								<Ionicons
									name={isPaused ? "play" : "pause"}
									size={64}
									style={{ marginLeft: isPaused ? 10 : 5 }}
									color="white"
								/>
							</Button>
							<Button
								style={[styles.fabMap, { backgroundColor: colors.secondary }]}
								shadow={2}
								size="sm"
								onPress={() => setLockedScreen((value) => !value)}
							>
								<Ionicons name={lockedScreen ? "lock-closed" : "lock-open"} size={24} color="white" />
							</Button>
						</>
					)}
				</View>
			)}
		</Animated.View>
	);
}

const styles = StyleSheet.create({
	overlay: {
		position: "absolute",
		display: "flex",
		flexDirection: "column",
		left: 0,
		right: 0,
		bottom: 0,
		top: 0,
		justifyContent: "flex-start",
		zIndex: 1000,
	},
	topSection: {
		position: "relative",
		display: "flex",
		flexDirection: "row",
		justifyContent: "space-evenly",
		alignItems: "center",
		marginTop: 55,
		marginLeft: 10,
		marginRight: 10,
	},
	topSectionText: { marginLeft: "auto", marginRight: "auto", textAlign: "center", fontSize: 20 },
	fabMap: {
		position: undefined,
		borderRadius: 9999,
		height: 50,
		width: 50,
	},
	kmSection: {
		...flex.mAuto,
		display: "flex",
		flexDirection: "column",
		justifyContent: "center",
		alignItems: "center",
		marginTop: 0,
		height: "auto",
		width: "100%",
	},
	bottomSection: {
		position: "relative",
		display: "flex",
		flexDirection: "row",
		justifyContent: "space-evenly",
		alignItems: "center",
		marginTop: "auto",
		marginLeft: 10,
		marginRight: 10,
		marginBottom: 50,
	},
});

export default WalkInfoModal;
