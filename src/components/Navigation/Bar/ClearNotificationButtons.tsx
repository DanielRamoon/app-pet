import { MaterialCommunityIcons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import { Button } from "native-base";
import { DeviceEventEmitter } from "react-native";
import * as Notifications from "expo-notifications";
import AsyncStorage from "@react-native-async-storage/async-storage";

export default function ClearNotificationsIcon() {
	const colors = useColors();

	const clearNotifications = async () => {
		await AsyncStorage.setItem("@petvidade:notifications", "[]");

		DeviceEventEmitter.emit("clearNotifications");

		await Notifications.dismissAllNotificationsAsync();
	};

	return (
		<Button variant="unstyled" accessibilityLabel="More options menu" onPress={() => clearNotifications()}>
			<MaterialCommunityIcons name={"notification-clear-all"} size={24} color={colors.text} style={{ marginTop: 3 }} />
		</Button>
	);
}
