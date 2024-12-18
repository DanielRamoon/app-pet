import { MaterialIcons } from "@expo/vector-icons";
import { navigate } from "@utils/navigator";
import { TouchableOpacity } from "react-native";

export default function OptionsButton() {
	return (
		<TouchableOpacity accessibilityLabel="Options" onPress={() => navigate("Config")}>
			<MaterialIcons name={"settings"} size={24} color="white" style={{ marginTop: 3 }} />
		</TouchableOpacity>
	);
}
