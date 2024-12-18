import ConfirmDel from "@components/Modals/ConfirmDelReminder";
import { MaterialCommunityIcons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import { useState } from "react";
import { DeviceEventEmitter, TouchableOpacity, View } from "react-native";
import i18n from "@utils/i18n";

export default function EditNDeleteAccount() {
	const colors = useColors();
	const [logOut, setLogOut] = useState<boolean>(false);

	return (
		<>
			{logOut && (
				<ConfirmDel
					message={i18n.get("confirmLogOut")}
					cancel={() => setLogOut(false)}
					confirm={() => DeviceEventEmitter.emit("logoutAccount")}
				/>
			)}
			<View style={{ display: "flex", flexDirection: "row", gap: 10 }}>
				<TouchableOpacity
					accessibilityLabel="Edit"
					onPress={() => DeviceEventEmitter.emit("shareProfile")}
					style={{ width: 30 }}
				>
					<MaterialCommunityIcons name="share-variant" size={24} style={{ color: colors.text }} />
				</TouchableOpacity>

				<TouchableOpacity
					accessibilityLabel="Edit"
					onPress={() => DeviceEventEmitter.emit("editAccount")}
					style={{ width: 30 }}
				>
					<MaterialCommunityIcons name="pencil" size={24} style={{ color: colors.text }} />
				</TouchableOpacity>

				<TouchableOpacity accessibilityLabel="Logout" onPress={() => setLogOut(true)} style={{ width: 32.5 }}>
					<MaterialCommunityIcons name="logout" size={24} style={{ color: colors.danger }} />
				</TouchableOpacity>
			</View>
		</>
	);
}
