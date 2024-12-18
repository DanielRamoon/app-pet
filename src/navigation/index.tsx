import useAppTheme from "@hooks/useAppTheme";
import useUser from "@hooks/useUser";
import { NavigationContainer } from "@react-navigation/native";
import { navigationRef } from "@utils/navigator";
import * as Linking from "expo-linking";
import React, { useEffect, useState } from "react";
import { DeviceEventEmitter } from "react-native";
import { useSelector } from "react-redux";
import { RootState } from "src/store/store";
import Main from "./AppRoutes";
import Auth from "./AuthRoutes";
import * as TaskManager from "expo-task-manager";

const authCallbackLinkingURL = Linking.createURL("/app");

export default () => {
	const currentWalk = useSelector((state: RootState) => state.currentWalk);
	const [loaded, setLoaded] = useState(false);
	const [currentNavigator, setCurrentNavigator] = useState<JSX.Element | null>(null);

	useUser();

	useEffect(() => {
		const event = DeviceEventEmitter.addListener("onAuthResult", (val) => {
			if (val) setCurrentNavigator(<Main />);
			else setCurrentNavigator(<Auth />);

			setLoaded(true);
		});

		// Verifica se está caminhando, se não estiver, limpa todas as tasks
		if (currentWalk.status !== "walking" && currentWalk.status !== "paused") {
			TaskManager.unregisterAllTasksAsync();
		}

		return () => {
			event.remove();
		};
	}, []);

	useEffect(() => {
		if (loaded) {
			DeviceEventEmitter.emit("loaded");
		}
	}, [loaded]);

	const linking = {
		prefixes: [authCallbackLinkingURL, "exp://127.0.0.1:19000/--/app"],
	};

	useAppTheme();

	return (
		<NavigationContainer linking={linking} ref={navigationRef}>
			{!loaded ? null : currentNavigator}
		</NavigationContainer>
	);
};
