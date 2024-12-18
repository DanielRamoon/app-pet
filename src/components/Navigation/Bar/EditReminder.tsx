import { MaterialCommunityIcons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import { Button } from "native-base";
import { DeviceEventEmitter, StyleSheet } from "react-native";

export default function EditReminder() {
	const colors = useColors();

	return (
		<Button
			variant="unstyled"
			accessibilityLabel="More options menu"
			onPress={() => DeviceEventEmitter.emit("editReminder")}
		>
			<MaterialCommunityIcons name="pencil" size={24} style={{ color: colors.text }} />
		</Button>
	);
}
