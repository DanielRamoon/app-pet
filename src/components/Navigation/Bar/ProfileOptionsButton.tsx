import { FontAwesome5, Ionicons, MaterialCommunityIcons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import useNotifications from "@hooks/useNotifications";
// import { Text } from "@ui-kitten/components";
import i18n from "@utils/i18n";
import { navigate } from "@utils/navigator";
import { logOut } from "@utils/supabase/client";
import { Button, Menu, Text, View } from "native-base";
import { useEffect, useState } from "react";
import { StyleSheet } from "react-native";

export default function ProfileOptionsButton() {
	const colors = useColors();
	const { notifications } = useNotifications();

	const [notificationCount, setNotificationCount] = useState(0);

	useEffect(() => {
		setNotificationCount(notifications?.follows ?? 0);
	}, [notifications]);

	return (
		<Menu
			minW="190"
			trigger={(triggerProps) => {
				return (
					<Button variant="unstyled" accessibilityLabel="More options menu" {...triggerProps}>
						<Ionicons name="menu" color={colors.text} size={24} />
					</Button>
				);
			}}
			style={{ right: 10 }}
		>
			<Menu.Item
				onPress={() => navigate("Notifications")}
				style={styles.menuItem}
				_pressed={{ backgroundColor: colors.cardColor }}
			>
				{notificationCount > 0 ? (
					<View
						style={{
							position: "absolute",
							top: 2,
							right: 132,
							width: 10,
							height: 10,
							backgroundColor: colors.danger,
							borderRadius: 20,
							justifyContent: "center",
							alignItems: "center",
							zIndex: 9999,
						}}
					/>
				) : (
					<View />
				)}
				<MaterialCommunityIcons
					name="bell"
					size={24}
					color={colors.text}
					style={[styles.menuIcon, { position: "relative", left: -16 }]}
				/>
				<Text style={{ position: "relative", left: -13 }}>{i18n.get("profile.notifications")}</Text>
			</Menu.Item>
			<Menu.Item
				onPress={() => navigate("Edit")}
				style={styles.menuItem}
				_pressed={{ backgroundColor: colors.cardColor }}
			>
				<FontAwesome5 name="pen" size={18} color={colors.text} style={[styles.menuIcon, { position: "relative" }]} />
				<Text>{i18n.get("profile.edit")}</Text>
			</Menu.Item>
			<Menu.Item
				onPress={() => navigate("Config")}
				style={styles.menuItem}
				_pressed={{ backgroundColor: colors.cardColor }}
			>
				<FontAwesome5 name="cog" size={18} color={colors.text} style={[styles.menuIcon, { position: "relative" }]} />
				<Text>{i18n.get("config")}</Text>
			</Menu.Item>
			<Menu.Item onPress={logOut} style={styles.menuItem} _pressed={{ backgroundColor: colors.background }}>
				<Ionicons name="log-out" size={24} color={colors.danger} style={styles.menuIcon} />
				<Text>{i18n.get("logout")}</Text>
			</Menu.Item>
		</Menu>
	);
}

const styles = StyleSheet.create({
	menuItem: {
		display: "flex",
		flexDirection: "row",
		alignItems: "center",
		justifyContent: "flex-start",
		width: "100%",
	},
	menuIcon: {
		display: "flex",
		alignItems: "center",
		justifyContent: "center",

		marginRight: 10,
		marginLeft: 0,
		width: 24,
	},
});
