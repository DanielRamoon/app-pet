import { MaterialCommunityIcons, MaterialIcons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import { navigate } from "@utils/navigator";
import { Button } from "native-base";
import { useEffect, useState } from "react";
import { DeviceEventEmitter, StyleSheet, TouchableOpacity } from "react-native";
import * as Notifications from "expo-notifications";
import AsyncStorage from "@react-native-async-storage/async-storage";

export default function NotificationsIcon() {
	const [notificationsLength, setNotificationsLength] = useState(0);

	useEffect(() => {
		async function startup() {
			const notifications = await AsyncStorage.getItem("@petvidade:notifications");

			if (notifications) {
				const parsedNotifications = JSON.parse(notifications);

				setNotificationsLength(parsedNotifications.length);
			}
		}

		startup();
	}, []);

	useEffect(() => {
		DeviceEventEmitter.addListener(
			"notificationReceived",
			async (notificationReceived: Notifications.NotificationResponse) => {
				const notifications = await AsyncStorage.getItem("@petvidade:notifications");

				if (notifications) {
					const parsedNotifications = JSON.parse(notifications);

					parsedNotifications.push(notificationReceived);

					await AsyncStorage.setItem("@petvidade:notifications", JSON.stringify(parsedNotifications));

					//
				} else {
					await AsyncStorage.setItem("@petvidade:notifications", JSON.stringify([notificationReceived]));
				}

				setNotificationsLength((prev) => prev + 1);
			}
		);

		DeviceEventEmitter.addListener("clearNotifications", async () => {
			setNotificationsLength(0);
			await AsyncStorage.setItem("@petvidade:notifications", "[]");
		});
	}, []);

	return (
		<TouchableOpacity accessibilityLabel="Notifications" onPress={() => navigate("NotificationList")}>
			{notificationsLength > 0 ? (
				<MaterialIcons name={"notifications-active"} size={24} color="white" style={{ marginTop: 3 }} />
			) : (
				<MaterialIcons name={"notifications"} size={24} color="white" style={{ marginTop: 3 }} />
			)}
		</TouchableOpacity>
	);
}
