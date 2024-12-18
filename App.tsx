import { default as customTheme } from "@assets/config/custom-theme.json"; // <-- Import app theme
import { default as mapping } from "@assets/config/mapping.json";
import SplashScreen from "@components/SplashScreen";
import * as eva from "@eva-design/eva";
import { AppThemeProvider } from "@hooks/useAppTheme";
import { CurrentWalkProvider } from "@hooks/useCurrentWalk";
import { NotificationsProvider } from "@hooks/useNotifications";
import { UserProvider } from "@hooks/useUser";
import Navigation from "@navigation/index";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { ApplicationProvider } from "@ui-kitten/components";
import userService from "@utils/supabase/services/user.service";
import { Buffer } from "buffer";
import { Asset } from "expo-asset";
import Constants from "expo-constants";
import * as Device from "expo-device";
import * as Font from "expo-font";
import * as Notifications from "expo-notifications";
import { theme as NBDefaultTheme, NativeBaseProvider } from "native-base";
import React, { useEffect, useRef, useState } from "react";
import { AppState, DeviceEventEmitter, Linking, LogBox, Platform, View } from "react-native";
import "react-native-url-polyfill/auto";
import { Provider } from "react-redux";
import store from "./src/store/store";
import * as TaskManager from "expo-task-manager";
import * as Location from "expo-location";

// import * as SplashScreen from "expo-splash-screen";
import useColors from "@hooks/useColors";
import { LOCATION_TASK_NAME } from "@utils/requestLocationPermissions";

global.Buffer = Buffer;

// SplashScreen.preventAutoHideAsync();

Notifications.setNotificationHandler({
	handleNotification: async () => ({
		shouldShowAlert: true,
		shouldPlaySound: true,
		shouldSetBadge: true,
	}),
});

// Task para capturar a localização do usuário em background
TaskManager.defineTask(LOCATION_TASK_NAME, async ({ data, error }) => {
	if (error) {
		console.log(error);
		return;
	}
	if (data) {
		const { locations }: { locations?: Location.LocationObject[] } = data;

		if (AppState.currentState === "active") {
			DeviceEventEmitter.emit("foregroundBackgroundEvent", locations);
			return;
		}

		const previousLocations = JSON.parse((await AsyncStorage.getItem("@petvidade:backgroundLocations")) ?? "[]");
		await AsyncStorage.setItem(
			"@petvidade:backgroundLocations",
			JSON.stringify([...previousLocations, ...(locations ?? [])])
		);
	}
});

async function registerForPushNotificationsAsync() {
	let token: Notifications.ExpoPushToken | null = null;

	if (Platform.OS === "android") {
		await Notifications.setNotificationChannelAsync("default", {
			name: "default",
			importance: Notifications.AndroidImportance.MAX,
			vibrationPattern: [0, 100, 0, 150, 0, 10],
			lightColor: "#FF231F7C",
		});
	}

	if (Device.isDevice) {
		try {
			const { status: existingStatus } = await Notifications.getPermissionsAsync();

			let finalStatus = existingStatus;

			if (existingStatus !== "granted") {
				const { status } = await Notifications.requestPermissionsAsync();
				finalStatus = status;
			}

			if (finalStatus !== "granted") {
				alert("Notificações não permitidas. Sua ativação é recomendada para o melhor uso da aplicação!");
				return;
			}

			token = await Notifications.getExpoPushTokenAsync({
				projectId: Constants.easConfig?.projectId || Constants?.expoConfig?.extra?.eas.projectId || null,
			});
		} catch (error) {
			console.log(error);
		}

		//
	} else {
		alert("Must use physical device for Push Notifications");
	}

	return token?.data;
}

Linking.addEventListener("url", async (event: any) => {
	const params = event.url.split("?")[1];

	if (!params) return;

	AsyncStorage.setItem("params", params);
	DeviceEventEmitter.emit("onUrlOpen", params);
});

export default function App() {
	const [loaded, setLoaded] = useState(false);
	const [fontLoaded, setFontLoaded] = useState(false);
	const [evaThemeConfig, setEvaThemeConfig] = useState(eva.light);

	const notificationListener = useRef<Notifications.Subscription>();
	const responseListener = useRef<Notifications.Subscription>();

	const notification = useRef<Notifications.Notification>();

	// const nativeBaseThemeConfig = extendTheme({ ...customTheme["native-base"] });
	const kittenUIThemeConfig = { ...evaThemeConfig, ...customTheme["kitten-ui"] };

	async function loadResourcesAsync() {
		await Asset.loadAsync([
			require("@assets/images/unsplash/auth/login.jpg"),
			require("@assets/images/unsplash/auth/register.jpg"),
			require("@assets/images/unsplash/auth/forgot.jpg"),
		]);

		await Font.loadAsync({
			"Inter-Black": require("@assets/fonts/Inter-Black.ttf"),
			"Inter-Bold": require("@assets/fonts/Inter-Bold.ttf"),
			"Inter-ExtraBold": require("@assets/fonts/Inter-ExtraBold.ttf"),
			"Inter-ExtraLight": require("@assets/fonts/Inter-ExtraLight.ttf"),
			"Inter-Light": require("@assets/fonts/Inter-Light.ttf"),
			"Inter-Medium": require("@assets/fonts/Inter-Medium.ttf"),
			Inter: require("@assets/fonts/Inter-Regular.ttf"),
			"Inter-SemiBold": require("@assets/fonts/Inter-SemiBold.ttf"),
			"Inter-Thin": require("@assets/fonts/Inter-Thin.ttf"),
			ionicons: require("@expo/vector-icons/build/vendor/react-native-vector-icons/Fonts/Ionicons.ttf"),
			octicons: require("@expo/vector-icons/build/vendor/react-native-vector-icons/Fonts/Octicons.ttf"),
			foundation: require("@expo/vector-icons/build/vendor/react-native-vector-icons/Fonts/Foundation.ttf"),
			fontisto: require("@expo/vector-icons/build/vendor/react-native-vector-icons/Fonts/Fontisto.ttf"),
			materialicons: require("@expo/vector-icons/build/vendor/react-native-vector-icons/Fonts/MaterialIcons.ttf"),
			materialcommunityicons: require("@expo/vector-icons/build/vendor/react-native-vector-icons/Fonts/MaterialCommunityIcons.ttf"),
			feather: require("@expo/vector-icons/build/vendor/react-native-vector-icons/Fonts/Feather.ttf"),
		});

		setFontLoaded(true);
	}

	async function startupAppAsync() {
		const storageKeys = await AsyncStorage.getAllKeys();

		// Limpa tudo que não é crítico para o funcionamento do app da memória do dispositivo
		storageKeys.forEach(async (key) => {
			if (key.includes("@petvidade:")) return;
			if (key.includes("auth") || key.includes("token")) return; // sessão supabase

			await AsyncStorage.removeItem(key);
		});
	}

	useEffect(() => {
		loadResourcesAsync();
		startupAppAsync();

		/**
		 * Altera o tema da aplicação
		 * @param {string} theme - Tema a ser aplicado
		 */
		const changeTheme = (theme?: string) => {
			if (theme) {
				setEvaThemeConfig(theme === "light" ? eva.light : eva.dark);
			}
		};

		const changeLocale = () => {
			setLoaded(false);

			setTimeout(() => {
				setLoaded(true);
			}, 1000);
		};

		// Cria um listener para o evento "changeTheme", para alterar o tema da aplicação de qualquer lugar do app sem a necessiade de importar mais de um hook
		const themeEvent = DeviceEventEmitter.addListener("changeTheme", changeTheme);
		const localeEvent = DeviceEventEmitter.addListener("localeEvent", changeLocale);
		const loaded = DeviceEventEmitter.addListener("loaded", () => {
			setLoaded(true);
		});

		// Evento que detecta o estado do aplicativo (foreground, background, etc)
		const backgroundEvent = AppState.addEventListener("change", async (state) => {
			// Quer dizer que o aplicativo voltou do background
			if (state === "active") {
				const storageLocations = JSON.parse((await AsyncStorage.getItem("@petvidade:backgroundLocations")) ?? "[]");
				DeviceEventEmitter.emit("foregroundBackgroundEvent", storageLocations);
			}
		});

		return () => {
			themeEvent.remove();
			localeEvent.remove();
			loaded.remove();
			backgroundEvent.remove(); // Talvez não seja necessário
		};
	}, []);

	const registerNotificationsAndExpoToken = async () =>
		await registerForPushNotificationsAsync().then(async (token: string) => {
			if (!token) return;

			console.log("Token: ", token);

			const result = await userService.setUserExpoPushToken(token);

			if (result.status !== 200) {
				console.log("Erro ao atualizar o token no banco de dados");
				return;
			}
		});

	useEffect(() => {
		const onAuthListener = DeviceEventEmitter.addListener(
			"onAuth",
			async () => await registerNotificationsAndExpoToken()
		);

		notificationListener.current = Notifications.addNotificationReceivedListener((receivedNotification) => {
			notification.current = receivedNotification;
			DeviceEventEmitter.emit("notificationReceived", receivedNotification);
		});

		responseListener.current = Notifications.addNotificationResponseReceivedListener((response) => {
			DeviceEventEmitter.emit("notificationTap", response);
		});

		return () => {
			if (notificationListener.current) Notifications.removeNotificationSubscription(notificationListener.current);
			if (responseListener.current) Notifications.removeNotificationSubscription(responseListener.current);
			onAuthListener.remove();
		};
	}, []);

	useEffect(() => {
		LogBox.ignoreLogs(["In React 18, SSRProvider is not necessary and is a noop. You can remove it from your app."]);
	}, []);

	const colors = useColors();

	if (!fontLoaded) return <SplashScreen />;
	return (
		<View style={{ height: "100%", width: "100%", backgroundColor: colors.background }}>
			{!loaded && <SplashScreen loop />}
			<NativeBaseProvider
				config={{
					theme: {
						...NBDefaultTheme,
						fonts: {
							heading: "Inter",
							body: "Inter",
							mono: "Inter",
						} as any,
						config: {
							accessibleColors: false,
							useSystemColorMode: true,
							initialColorMode: "dark",
						} as any,
					},
				}}
			>
				<AppThemeProvider>
					{/* <NativeBaseProvider theme={nativeBaseThemeConfig}> */}
					<ApplicationProvider {...eva} theme={kittenUIThemeConfig} customMapping={mapping as any}>
						<UserProvider>
							<NotificationsProvider>
								<Provider store={store}>
									<Navigation />
								</Provider>
								{/* <CurrentWalkProvider></CurrentWalkProvider> */}
							</NotificationsProvider>
						</UserProvider>
					</ApplicationProvider>
				</AppThemeProvider>
			</NativeBaseProvider>
		</View>
	);
}
