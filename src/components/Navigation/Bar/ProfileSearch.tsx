import { MaterialIcons } from "@expo/vector-icons";
import { navigate } from "@utils/navigator";
import { TouchableOpacity } from "react-native";

export default function FriendsGo() {
	return (
		<TouchableOpacity accessibilityLabel="Friends" onPress={() => navigate("Friends")}>
			<MaterialIcons name={"group"} size={26} color="white" style={{ marginTop: 3 }} />
		</TouchableOpacity>
	);
}
