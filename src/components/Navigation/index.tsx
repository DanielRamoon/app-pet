import pawOutline from "@assets/icons/paw-outline.png";
import pawFilled from "@assets/icons/paw-filled.png";
import { Ionicons, Octicons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import { BottomTabBarProps } from "@react-navigation/bottom-tabs";
import { getRoute } from "@utils/navigator";
import { Text } from "native-base";
import { useEffect, useState } from "react";
import { Image, Keyboard, StyleSheet, TouchableOpacity, View } from "react-native";
import MiddleButton from "./MiddleButton";
import * as Animatable from "react-native-animatable";
import useNotifications from "@hooks/useNotifications";

const toHideTabBar = ["FirstAccess", "Login", "Register"];

export default function TabBar(props: BottomTabBarProps & { hidden?: boolean }) {
	const route = getRoute();
	const colors = useColors();
	const { notifications } = useNotifications();

	const [notificationCount, setNotificationCount] = useState(0);

	const IconsMap: any = {
		Home: (isFocused: boolean) => (
			<Ionicons
				name={isFocused ? "home" : "home-outline"}
				size={24}
				color={isFocused ? colors.lightGreen : colors.text}
			/>
		),
		Posts: (isFocused: boolean) => (
			<Ionicons
				name={isFocused ? "newspaper" : "newspaper-outline"}
				size={24}
				color={isFocused ? colors.lightGreen : colors.text}
			/>
		),
		Pets: (isFocused: boolean) => (
			<Image
				source={isFocused ? pawFilled : pawOutline}
				style={{ width: 27, height: 24, tintColor: isFocused ? colors.lightGreen : colors.text }}
				resizeMode="stretch"
			/>
		),
		Map: (isFocused: boolean) => (
			<Ionicons
				name={isFocused ? "map" : "map-outline"}
				size={24}
				color={isFocused ? colors.lightGreen : colors.text}
			/>
		),
		Places: (isFocused: boolean) => (
			<Ionicons
				name={isFocused ? "location-sharp" : "md-location-outline"}
				size={24}
				color={isFocused ? colors.lightGreen : colors.text}
			/>
		),
		Profile: (isFocused: boolean) => (
			<Ionicons
				name={isFocused ? "person-circle" : "person-circle-outline"}
				size={24}
				color={isFocused ? colors.lightGreen : colors.text}
			/>
		),
	};

	const [hideTabBar, setHideTabBar] = useState(props.hidden ?? false);

	useEffect(() => {
		const keyboardShown = Keyboard.addListener("keyboardDidShow", () => setHideTabBar(true));
		const keyboardHid = Keyboard.addListener("keyboardDidHide", () => setHideTabBar(false));

		return () => {
			keyboardShown.remove();
			keyboardHid.remove();
		};
	}, []);

	useEffect(() => {
		if (route)
			if (toHideTabBar.includes(route.name)) !hideTabBar && setHideTabBar(true);
			else hideTabBar && setHideTabBar(false);
	}, [route]);

	useEffect(() => {
		setNotificationCount(notifications?.follows ?? 0);
	}, [notifications]);

	if (props.hidden) return null;
	if (hideTabBar) return null;

	return (
		<Animatable.View
			animation="fadeInUp"
			style={[styles.tabContainer, { backgroundColor: colors.bottomTab }]}
			// animation={hideTabBar ? "fadeOutDown" : "fadeInUp"}
		>
			{props.state.routes.map((route, index) => {
				const isFocused = props.state.index === index;

				const onPress = () => {
					const event = props.navigation.emit({
						type: "tabPress",
						target: route.key,
						canPreventDefault: true,
					});

					if (!isFocused && !event.defaultPrevented) {
						props.navigation.navigate(route.name);
					}
				};

				const { options } = props.descriptors[route.key as any];
				if (options.title === "MiddleButton") return <MiddleButton key={index} onPress={onPress} />;
				else {
					if (options.tabBarButton) return options.tabBarButton({ key: route.key } as any);

					const label =
						options.tabBarLabel !== undefined
							? options.tabBarLabel
							: options.title !== undefined
							? options.title
							: route.name;

					const title = options.title;

					if (title === "Map" && isFocused) {
						setHideTabBar(true);
					}

					return (
						<TouchableOpacity key={route.key} onPress={onPress} style={styles.tabItem}>
							{notificationCount > 0 && title === "Profile" && (
								<View
									style={{
										position: "absolute",
										top: isFocused ? 8 : 17,
										right: 21,
										width: 10,
										height: 10,
										backgroundColor: colors.danger,
										borderRadius: 20,
										justifyContent: "center",
										alignItems: "center",
										zIndex: 9999,
									}}
								/>
							)}

							{IconsMap[title as any](isFocused)}
							{isFocused && (
								<Text
									style={{
										fontFamily: "Inter-Medium",
										fontWeight: "600",
										color: isFocused ? colors.primary : colors.text,
									}}
								>
									{String(label)}
								</Text>
							)}
						</TouchableOpacity>
					);
				}
			})}
		</Animatable.View>
	);
}

const styles = StyleSheet.create({
	tabContainer: {
		position: "absolute",
		bottom: 0,
		left: 0,
		right: 0,

		flexDirection: "row",
		height: 60,
		elevation: 2,
		borderTopColor: "transparent",
		borderTopWidth: 1,
		margin: 12,
		borderRadius: 18,
	},
	tabItem: {
		flex: 1,
		alignItems: "center",
		justifyContent: "center",
	},
});
