import React, { useEffect, useState } from "react";
import { Pressable, ScrollView, Text, View } from "native-base";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { IPushNotification } from "types/pushNotification";
import ThemedView from "@components/utils/ThemedView";
import { DeviceEventEmitter, Dimensions, Image } from "react-native";
import useColors from "@hooks/useColors";
import * as Notifications from "expo-notifications";
import i18n from "@utils/i18n";
import { DateTime } from "luxon";

export default function () {
	const colors = useColors();
	const [notifications, setNotifications] = useState<IPushNotification[]>([]);
	const [notificationsReorder, setNotificationsReorder] = useState<IPushNotification[]>([]);

	const getLocalStorageNotifications = async () => {
		const notificationList = await AsyncStorage.getItem("@petvidade:notifications");

		if (!notificationList) return;

		try {
			setNotifications(JSON.parse(notificationList));
		} catch (error) {}
	};

	useEffect(() => {
		getLocalStorageNotifications();

		DeviceEventEmitter.addListener(
			"notificationReceived",
			async (notificationReceived: Notifications.NotificationResponse) => {
				const nots = [];

				for (const notification of notifications) {
					nots.push(notification);
				}

				nots.push(notificationReceived);

				setNotifications(nots as IPushNotification[]);
			}
		);
	}, []);

	useEffect(() => {
		DeviceEventEmitter.addListener("clearNotifications", async () => {
			setNotifications([]);
			await AsyncStorage.setItem("@petvidade:notifications", "[]");
		});
	}, []);

	useEffect(() => {
		// Filter notifications by date ordering by newest
		const notificationsFiltered = notifications.sort((a, b) => b.date - a.date);

		// Set notifications to state
		setNotificationsReorder(notificationsFiltered);

		// Save notifications to local storage
		AsyncStorage.setItem("@petvidade:notifications", JSON.stringify(notificationsFiltered));

		// Set badge number
		Notifications.setBadgeCountAsync(notificationsFiltered.length);

		//
	}, [notifications]);

	return (
		<ThemedView fadeIn>
			<ScrollView showsVerticalScrollIndicator alwaysBounceVertical bounces bouncesZoom>
				{notificationsReorder.length > 0 ? (
					notificationsReorder.map((notification, index) => (
						<Pressable
							rounded="8"
							overflow="hidden"
							borderWidth="0"
							flexDirection="row"
							maxW={Dimensions.get("window").width}
							shadow="3"
							bg={colors.cardColor}
							pl={0}
							style={{
								width: Dimensions.get("window").width - 20,
								marginBottom: index === notifications.length - 1 ? 85 : 10,
								marginRight: "auto",
								marginLeft: "auto",
							}}
							height={150}
							key={index}
						>
							<View
								flex={1}
								justifyContent="space-between"
								p={4}
								style={{
									height: "100%",
								}}
							>
								<View>
									<Text fontSize="lg" fontWeight="bold">
										{notification.request.content.title}
									</Text>
									<Text fontSize="sm">{notification.request.content.body}</Text>
								</View>
								<View>
									<Text fontSize="xs">{DateTime.fromMillis(notification.date).toFormat("dd/MM/yyyy HH:mm:ss")}</Text>
								</View>
							</View>
						</Pressable>
					))
				) : (
					<View
						style={{
							width: "100%",
							marginTop: 20,
							display: "flex",
							justifyContent: "center",
							alignItems: "center",
							flexDirection: "column",
						}}
					>
						<Image
							style={{
								width: 180,
								height: 130,
								marginTop: "auto",
							}}
							source={require("@assets/icons/catIcon.png")}
						/>
						<Text style={{ color: colors.text }}>{i18n.get("nothingToSee")}</Text>
					</View>
				)}
			</ScrollView>
		</ThemedView>
	);
}
