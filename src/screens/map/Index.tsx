import React, { useEffect, useRef, useState } from "react";
import {
	Alert,
	BackHandler,
	DeviceEventEmitter,
	Platform,
	StyleSheet,
	View,
	AppState,
	AppStateStatus,
} from "react-native";
import { TouchableOpacity } from "react-native";
import MapView, { MAP_TYPES, PROVIDER_GOOGLE, Polyline } from "react-native-maps";
import { Button, Text } from "native-base";
import LottieView from "lottie-react-native";
import AsyncStorage from "@react-native-async-storage/async-storage";
import * as Location from "expo-location";
import * as TaskManager from "expo-task-manager";
import axios from "axios";

import { useDispatch, useSelector } from "react-redux";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import { LocationObject } from "expo-location";

import Loader from "@components/Loader";
import MapActionsOverlay from "@components/Map/MapActionsOverlay";
import CountdownModal from "@components/Modals/CountdownModal";
import WalkInfoModal, { WalkInfoActions } from "@components/Modals/Fullscreen/WalkInfoModal";
import PetList from "@components/Map/PetList";
import ThemedView from "@components/utils/ThemedView";

import useAppTheme from "@hooks/useAppTheme";
import useColors from "@hooks/useColors";

import i18n from "@utils/i18n";
import walkService from "@utils/supabase/services/walk/walk.service";
import userService, { IUser } from "@utils/supabase/services/user.service";
import { supabase } from "@utils/supabase/client";
import { mapThemes } from "@utils/theme";

import { RootState } from "src/store/store";
import {
	finishWalk,
	pauseWalk,
	resetWalk,
	resumeWalk,
	startWalk,
	updateDurationByOneSecond,
	updateWalkDataDistance,
} from "src/store/features/walkSlice";

import { ILineProps } from "types/pets";
import { IOSMGeocodeResponse } from "types/geocoding";
import { UserResponse } from "@supabase/supabase-js";

const LOCATION_TASK_NAME = "ptvd-background-location-task";
const WALK_TIME_KEY = "@petvidade:currentWalkTime";
const LAST_UPDATE_TIME_KEY = "@petvidade:lastUpdateTime";

export function convertLocationToILineProps(location: Location.LocationObject): ILineProps {
	// Verifica se coords está presente e contém latitude e longitude válidos
	if (
		!location.coords ||
		typeof location.coords.latitude !== "number" ||
		typeof location.coords.longitude !== "number"
	) {
		console.error("Coordenadas inválidas:", location.coords);
		throw new Error("Coordenadas inválidas");
	}

	// Verifica se timestamp é um número válido
	if (typeof location.timestamp !== "number" || isNaN(location.timestamp)) {
		console.error("Timestamp inválido:", location.timestamp);
		throw new Error("Timestamp inválido");
	}

	return {
		latitude: location.coords.latitude,
		longitude: location.coords.longitude,
		timestamp: new Date(location.timestamp).toISOString(),
	};
}

async function checkPermission(): Promise<boolean> {
	try {
		// Solicita permissão de localização em primeiro plano
		const { status: statusFore } = await Location.requestForegroundPermissionsAsync();

		if (statusFore !== "granted") {
			// Permissão em primeiro plano não concedida
			Alert.alert(i18n.get("permissionAlertTitle"), i18n.get("permissionAlert"));
			return false;
		}

		// Verifica se a permissão de localização em segundo plano já foi concedida
		const { status: statusBack } = await Location.getBackgroundPermissionsAsync();

		if (statusBack === "granted") {
			// Permissão em segundo plano já concedida
			return true;
		}

		// Permissão em segundo plano não concedida, solicita permissão ao usuário
		const { status: newStatusBack } = await Location.requestBackgroundPermissionsAsync();

		if (newStatusBack === "granted") {
			// Permissão em segundo plano concedida após a solicitação
			return true;
		} else {
			// Permissão em segundo plano não concedida após a solicitação
			Alert.alert(i18n.get("permissionAlertTitle"), i18n.get("permissionAlert"));
			return false;
		}
	} catch (error) {
		// Tratamento de erros
		console.error("Erro ao solicitar permissões:", error);
		Alert.alert(i18n.get("permissionAlertTitle"), i18n.get("permissionAlert"));
		return false;
	}
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
	const [polylineCoordinates, setPolylineCoordinates] = useState<ILineProps[]>([]);

	const [currentWalkTime, setCurrentWalkTime] = useState(0); // Tempo de caminhada em milissegundos
	const [lastUpdateTime, setLastUpdateTime] = useState(Date.now());
	const [lastTime, setLastTime] = useState(Date.now());

	//types
	type LocationCoords = {
		latitude: number;
		longitude: number;
	};

	// Defina um tipo para lastKnownLocation
	interface LocationCoordinates {
		latitude: number;
		longitude: number;
	}

	// Functions

	const calculateElapsedTime = async () => {
		const currentTime = Date.now(); // Tempo atual
		const storedLastUpdateTime = await AsyncStorage.getItem(LAST_UPDATE_TIME_KEY);
		const prevWalkTime = storedLastUpdateTime ? JSON.parse(storedLastUpdateTime) : 0;

		// Calcula o tempo decorrido
		const elapsedTime = currentTime - lastTime; // Calcula o tempo desde a última atualização
		const updatedWalkTime = prevWalkTime + elapsedTime;

		// Atualiza o estado e armazena os novos valores
		setLastTime(currentTime); // Atualiza lastTime para o tempo atual
		await AsyncStorage.setItem(LAST_UPDATE_TIME_KEY, JSON.stringify(updatedWalkTime));
		console.log("Tempo de caminhada atualizado:", updatedWalkTime);
	};
	async function saveLocation(location: LocationCoords) {
		try {
			const locationString = JSON.stringify(location);
			await AsyncStorage.setItem("@lastLocation", locationString);
			console.log("Location saved:", locationString);
		} catch (error) {
			console.error("Failed to save location:", error);
		}
	}

	async function getSavedLocation() {
		try {
			const locationString = await AsyncStorage.getItem("@lastLocation");
			if (locationString !== null) {
				const location = JSON.parse(locationString);
				console.log("Retrieved location:", location); // Adicione este log
				return location;
			} else {
				console.log("No location found.");
				return null;
			}
		} catch (error) {
			console.error("Failed to retrieve location:", error);
			return null;
		}
	}

	const getDistance = (lat1: number, lon1: number, lat2: number, lon2: number): number => {
		const R = 6371e3;
		const φ1 = (lat1 * Math.PI) / 180;
		const φ2 = (lat2 * Math.PI) / 180;
		const Δφ = ((lat2 - lat1) * Math.PI) / 180;
		const Δλ = ((lon2 - lon1) * Math.PI) / 180;

		const a = Math.sin(Δφ / 2) * Math.sin(Δφ / 2) + Math.cos(φ1) * Math.cos(φ2) * Math.sin(Δλ / 2) * Math.sin(Δλ / 2);
		const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

		return R * c;
	};

	const focusCamera = (location: LocationCoords) => {
		mapViewRef.current?.animateCamera(
			{
				center: {
					latitude: location.latitude - 0.00009, // Ajuste o valor delta aqui
					longitude: location.longitude,
				},
				zoom: 19,
				pitch: 17,
			},
			{ duration: 2000 }
		);
	};

	const handlePetSelectionChange = (petIds: string[]) => {
		setSelectedPets(petIds);
	};

	const initializeWalk = async () => {
		dispatch(
			startWalk({
				pets: selectedPets.map((petId) => ({ id: petId, name: "QUERY" })),
				user: { id: profile?.id!, name: profile?.user_name!, image: profile?.avatar_url! },
			})
		);

		// Resetando o intervalo de atualização de distância
		clearInterval(updateDistanceInterval!);
		setUpdateDistanceInterval(setInterval(() => dispatch(updateDurationByOneSecond()), 1000));
	};

	const retrieveLocations = async () => {
		try {
			const storedLocations = await AsyncStorage.getItem("@ptvd:backgroundLocations");
			if (storedLocations) {
				const parsedLocations = JSON.parse(storedLocations);
				// Use parsedLocations para desenhar o Polyline
				setPolylineCoordinates(parsedLocations);
			}
		} catch (error) {
			console.error("Erro ao recuperar as localizações armazenadas:", error);
		}
	};

	TaskManager.defineTask(
		LOCATION_TASK_NAME,
		async ({
			data,
			error,
		}: {
			data?: { locations: Location.LocationObject[] };
			error?: TaskManager.TaskManagerError | null;
		}) => {
			if (error) {
				console.error("Erro na tarefa de segundo plano:", error);
				return;
			}

			if (data && data.locations) {
				const { locations } = data; // Agora o 'locations' é corretamente inferido como um array de 'LocationObject'

				try {
					const currentTime = new Date().getTime();

					// Pegue o último tempo salvo quando a localização foi atualizada pela última vez
					const lastUpdateTime = await AsyncStorage.getItem("@petvidade:lastUpdateTime");
					const lastStoredTime = await AsyncStorage.getItem("@petvidade:currentWalkTime");

					const prevWalkTime = lastStoredTime ? JSON.parse(lastStoredTime) : 0;
					const lastTime = lastUpdateTime ? JSON.parse(lastUpdateTime) : currentTime;

					// Calcule o tempo decorrido desde a última atualização
					const elapsedTime = currentTime - lastTime;

					// Atualize o tempo total de caminhada
					const updatedWalkTime = prevWalkTime + elapsedTime;

					// Armazene o novo tempo de caminhada
					await AsyncStorage.setItem("@petvidade:currentWalkTime", JSON.stringify(updatedWalkTime));
					await AsyncStorage.setItem("@petvidade:lastUpdateTime", JSON.stringify(currentTime));

					// Adicione as coordenadas à lista de localizações
					const storedLocations = await AsyncStorage.getItem("@petvidade:backgroundLocations");
					const previousLocations = storedLocations ? JSON.parse(storedLocations) : [];
					const validLocations = locations.filter((location) => location.coords);
					const allLocations = previousLocations.concat(validLocations);

					await AsyncStorage.setItem("@petvidade:backgroundLocations", JSON.stringify(allLocations));

					console.log("Tempo de caminhada atualizado em segundo plano:", updatedWalkTime);
				} catch (error) {
					console.error("Erro ao atualizar o tempo de caminhada em segundo plano:", error);
				}
			}
		}
	);

	// TaskManager.defineTask(LOCATION_TASK_NAME, async ({ error }) => {
	// 	if (error) {r
	// 		console.error("Erro na tarefa de segundo plano:", error);
	// 		return;
	// 	}

	// 	try {
	// 		await calculateElapsedTime(); // Atualiza o tempo enquanto o app está no background
	// 	} catch (err) {
	// 		console.error("Erro ao calcular tempo no background:", err);
	// 	}
	// });

	const checkRegisteredTasks = async () => {
		try {
			const tasks = await TaskManager.getRegisteredTasksAsync();
		} catch (error) {
			console.error("Erro ao obter tarefas registradas:", error);
		}
	};

	checkRegisteredTasks();

	const requestPermissions = async () => {
		const { status: foregroundStatus } = await Location.requestForegroundPermissionsAsync();

		if (foregroundStatus === "granted") {
			const { status: backgroundStatus } = await Location.requestBackgroundPermissionsAsync();

			if (backgroundStatus === "granted") {
				const providerStatus = await Location.getProviderStatusAsync();
				let accuracy;

				if (providerStatus.gpsAvailable && providerStatus.networkAvailable) {
					accuracy = Location.Accuracy.Highest;
				} else if (providerStatus.networkAvailable) {
					accuracy = Location.Accuracy.High;
				} else {
					accuracy = Location.Accuracy.Balanced;
				}

				await Location.startLocationUpdatesAsync(LOCATION_TASK_NAME, {
					accuracy: accuracy,
					distanceInterval: 1,
					timeInterval: 1000,
					pausesUpdatesAutomatically: false,
					showsBackgroundLocationIndicator: true,
					foregroundService: {
						notificationTitle: "App ativo",
						notificationBody: "Rastreamento de localização em andamento",
						notificationColor: "#fff",
					},
				});
			}
		}
	};

	let lastKnownLocation: LocationCoordinates | null = null;

	const checkAndStartWalk = async () => {
		if (selectedPets.length === 0) return;

		try {
			setStarting(true);

			const location = await getCurrentLocation();
			if (!location) throw new Error("Unable to get current location.");

			await saveLocation(location);

			const savedLocation = await getSavedLocation();
			console.log("Saved location:", savedLocation);

			await initializeWalk();
			focusCamera(location);

			await Location.startLocationUpdatesAsync(LOCATION_TASK_NAME, {
				accuracy: Location.Accuracy.High,
				distanceInterval: 1,
				timeInterval: 1000,
				pausesUpdatesAutomatically: false,
				showsBackgroundLocationIndicator: true,
				foregroundService: {
					notificationTitle: "App ativo",
					notificationBody: "Rastreamento de localização em andamento",
					notificationColor: "#fff",
				},
			});

			return () => cleanupLocationTracking();
		} catch (error) {
			Alert.alert("Erro", String(error));
			dispatch(resetWalk());
		}
	};

	const cleanupLocationTracking = () => {
		clearInterval(updateDistanceInterval!);
		Location.stopLocationUpdatesAsync(LOCATION_TASK_NAME);
	};

	const handleAction = async (action: WalkInfoActions) => {
		switch (action) {
			case "stop":
				getCityCenterFromLocation().then((baseLocation) => {
					if (!baseLocation) return;
					if (!baseLocation[0]) return;

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

				// Verifica se a duração da caminhada é maior que 15 segundos
				if (currentWalk.value.duration < 15) {
					Alert.alert(i18n.get("walkCantFinished"), i18n.get("walkCantFinishedMessage"));
					dispatch(resetWalk());

					clearInterval(updateDistanceInterval!);

					break;
				}

				Alert.alert(i18n.get("finishWalkQuestion"), undefined, [
					{ text: i18n.get("cancel"), style: "cancel" },
					{
						text: i18n.get("confirm"),
						onPress: async () => {
							clearInterval(updateDistanceInterval!);

							setLoading(true);

							await Location.stopLocationUpdatesAsync(LOCATION_TASK_NAME);
							await new Promise((resolve) => setTimeout(resolve, 500));

							// Log do estado atual antes de finalizar a caminhada
							console.log("Estado atual antes de finalizar a caminhada:", currentWalk);

							// Finaliza a caminhada
							dispatch(finishWalk({ walkIds: [] }));
							await new Promise((resolve) => setTimeout(resolve, 500));

							const finishedWalkData = { ...currentWalk.value.walk };

							finishedWalkData.date_end = new Date().toISOString();
							finishedWalkData.updated_at = new Date().toISOString();

							// Adicionando logs para verificar os dados
							console.log("Finalizando caminhada com dados:", finishedWalkData);

							try {
								const result = await walkService.saveWalk({
									...finishedWalkData,
									duration: currentWalk.value.duration,
									total_distance: {
										km: currentWalk.value.distance.km,
										humanDistance: currentWalk.value.distance.humanDistance,
										animalDistance: currentWalk.value.distance.animalDistance,
									},
									petIds: currentWalk.value.petsData.map((p) => p.id),
								});

								console.log("Resultado da API:", result);

								if (result.status !== 200) {
									throw new Error("Erro ao salvar caminhada");
								}

								// Atualiza o id da caminhada
								dispatch(finishWalk({ walkIds: result.data?.map((walk) => walk.id)! }));
								setShowWalkInfoModal(true);
							} catch (error) {
								console.error("Erro ao finalizar a caminhada:", error);
								Alert.alert(i18n.get("error"), i18n.get("errorOccurred"));
							} finally {
								setLoading(false);
							}
						},
					},
				]);

				break;
			case "pause":
				dispatch(pauseWalk());
				clearInterval(updateDistanceInterval!);
				break;
			case "resume":
				dispatch(resumeWalk());
				setUpdateDistanceInterval(setInterval(() => dispatch(updateDurationByOneSecond()), 1000));
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
							} catch (error) {
								console.error("Erro ao parar atualizações de localização:", error);
							}

							try {
								for (const walkId of currentWalk.value.walkIds!) {
									const result = await walkService.deleteWalk(walkId);

									if (result.status !== 200) {
										throw new Error(`Failed to delete walk - ${JSON.stringify(result)}`);
									}
								}

								dispatch(resetWalk());
								setShowWalkInfoModal(false);
							} catch (error) {
								console.error("Erro ao deletar caminhada:", error);
								Alert.alert(i18n.get("error"), i18n.get("errorOccurred"));
							} finally {
								setLoading(false);
							}
						},
					},
				]);

				break;
		}
	};

	const handleLocationUpdate = (location: Location.LocationObject) => {
		const { latitude, longitude } = location.coords;

		if (lastKnownLocation) {
			const { latitude: lastLat, longitude: lastLon } = lastKnownLocation;
			const distance = getDistance(lastLat, lastLon, latitude, longitude);

			const MIN_DISTANCE = 5; // Distância mínima para considerar um movimento
			if (distance >= MIN_DISTANCE) {
				console.log("Movimento detectado:", { latitude, longitude, distance });
				lastKnownLocation = { latitude, longitude };

				const lineProps: ILineProps[] = [
					{ latitude: lastLat, longitude: lastLon, timestamp: new Date().toISOString() },
					{ latitude, longitude, timestamp: new Date().toISOString() },
				];

				// Atualiza a distância da caminhada
				dispatch(updateWalkDataDistance(lineProps));
			}
		} else {
			lastKnownLocation = { latitude, longitude };
		}
	};

	const getCurrentLocation = async (): Promise<LocationCoords | null> => {
		try {
			const { coords } = await Location.getCurrentPositionAsync({
				accuracy: Location.Accuracy.BestForNavigation,
			});
			return { latitude: coords.latitude, longitude: coords.longitude };
		} catch (error) {
			console.error("Failed to get current location:", error);
			return null;
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

	const startBackgroundLocation = async () => {
		const { status } = await Location.requestBackgroundPermissionsAsync();
		if (status === "granted") {
			await Location.startLocationUpdatesAsync(LOCATION_TASK_NAME, {
				accuracy: Location.Accuracy.Highest,
				timeInterval: 1000,
				distanceInterval: 1,
				pausesUpdatesAutomatically: false,
				showsBackgroundLocationIndicator: true,
				foregroundService: {
					notificationTitle: "App ativo",
					notificationBody: "Rastreamento de localização em andamento",
					notificationColor: "#fff",
				},
			});
		}
	};

	// useEffect

	// Inicializa o aplicativo
	useEffect(() => {
		const initialize = async () => {
			try {
				const permissionGranted = await checkPermission();
				setPermission(permissionGranted);

				if (permissionGranted) {
					await enableNetworkProvider();
					await startBackgroundLocation();
					await requestPermissions();
					await retrieveLocations();
					await Location.startLocationUpdatesAsync(LOCATION_TASK_NAME, {
						accuracy: Location.Accuracy.Highest,
						timeInterval: 1000,
						distanceInterval: 1,
						showsBackgroundLocationIndicator: true,
						pausesUpdatesAutomatically: false,
					});
				} else {
					console.error("Permissão de localização não concedida.");
				}

				setLoading(false);

				const location = await Location.getCurrentPositionAsync({ accuracy: Location.Accuracy.High });
				if (mapViewRef.current) {
					mapViewRef.current.setMapBoundaries(
						{
							latitude: location.coords.latitude + 0.05,
							longitude: location.coords.longitude + 0.05,
						},
						{
							latitude: location.coords.latitude - 0.05,
							longitude: location.coords.longitude - 0.05,
						}
					);
					mapViewRef.current.animateCamera(
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
				}

				const profileData = await userService.getLoggedUserProfile();
				setProfile(profileData.data as IUser);
			} catch (error) {
				console.error("Erro ao inicializar:", error);
				setLoading(false);
			}
		};

		initialize();
	}, []);

	// Atualiza a localização a cada 5 segundos
	useEffect(() => {
		const locationUpdateInterval = setInterval(async () => {
			try {
				const location = await Location.getCurrentPositionAsync({ accuracy: Location.Accuracy.High });
				handleLocationUpdate(location);
			} catch (error) {
				console.error("Erro ao atualizar a localização:", error);
			}
		}, 5000);

		return () => clearInterval(locationUpdateInterval);
	}, []);

	// Lida com eventos de navegação
	useEffect(() => {
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

		return () => {
			unsubscribeBlur();
			unsubscribeFocus();
			unsubscribeBack.remove();
		};
	}, [navigation]);

	useEffect(() => {
		const unsubscribeWalkData = DeviceEventEmitter.addListener(
			"foregroundBackgroundEvent",
			async (locations: LocationObject[]) => {
				try {
					// Atualiza a localização
					const storedLocations = await AsyncStorage.getItem("@petvidade:backgroundLocations");
					const previousLocations = storedLocations ? JSON.parse(storedLocations) : [];

					const validLocations = locations.filter(
						(location: LocationObject) =>
							location.coords &&
							typeof location.coords.latitude === "number" &&
							typeof location.coords.longitude === "number"
					);

					if (validLocations.length === 0) {
						// console.warn("Nenhuma localização válida encontrada.");
						return;
					}

					const allLocations = previousLocations.concat(validLocations);
					await AsyncStorage.setItem("@petvidade:backgroundLocations", JSON.stringify(allLocations));

					const lineProps = allLocations.map(convertLocationToILineProps);

					// Atualiza o tempo
					const currentTime = new Date().getTime();
					const lastUpdateTime = await AsyncStorage.getItem(LAST_UPDATE_TIME_KEY);
					const lastStoredTime = await AsyncStorage.getItem(WALK_TIME_KEY);

					const prevWalkTime = lastStoredTime ? JSON.parse(lastStoredTime) : 0;
					const lastTime = lastUpdateTime ? JSON.parse(lastUpdateTime) : currentTime;

					// Calcule o tempo decorrido desde a última atualização
					const elapsedTime = currentTime - lastTime;

					// Atualize o tempo total de caminhada
					const updatedWalkTime = prevWalkTime + elapsedTime;

					// Armazene o novo tempo de caminhada
					await AsyncStorage.setItem(WALK_TIME_KEY, JSON.stringify(updatedWalkTime));
					await AsyncStorage.setItem(LAST_UPDATE_TIME_KEY, JSON.stringify(currentTime));

					// Atualize o estado de caminhada com o novo tempo
					setCurrentWalkTime(updatedWalkTime);

					console.log("Tempo de caminhada e localizações atualizados em segundo plano.");
					dispatch(updateWalkDataDistance(lineProps));
				} catch (error) {
					console.error("Erro ao processar eventos de fundo:", error);
				}
			}
		);

		return () => unsubscribeWalkData.remove();
	}, [currentWalk.status]);

	useEffect(() => {
		const checkRegisteredTasks = async () => {
			try {
				const tasks = await TaskManager.getRegisteredTasksAsync();
			} catch (error) {
				console.error("Erro ao obter tarefas registradas:", error);
			}
		};

		checkRegisteredTasks();
	}, []);

	// Gerencia o estado do aplicativo (fundo/primeiro plano)
	// useEffect(() => {
	// 	const 	 = async (nextAppState: AppStateStatus) => {
	// 		if (nextAppState === "active") {
	// 			await calculateElapsedTime(); // Atualiza o tempo ao retornar ao foreground
	// 		} else {
	// 			setLastTime(Date.now()); // Atualiza lastTime quando o app sai do foreground
	// 		}
	// 	};

	// 	const subscription = AppState.addEventListener("change", handleAppStateChange);

	// 	return () => {
	// 		subscription.remove(); // Limpa o listener quando o componente é desmontado
	// 	};
	// }, []);

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
								showsUserLocation={true}
								loadingEnabled={false}
								showsBuildings={false}
								showsPointsOfInterest={false}
								customMapStyle={appTheme === "light" ? mapThemes.light : mapThemes.dark}
								showsIndoors={false}
								showsIndoorLevelPicker={false}
								onPanDrag={() => {}}
								onRegionChange={() => {}}
								onRegionChangeComplete={() => {}}
								followsUserLocation={true}
							>
								{((currentWalk.value.walk.distance as ILineProps[][]) ?? []).map((point, index) => (
									<Polyline
										coordinates={polylineCoordinates}
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
