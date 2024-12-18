import { MaterialCommunityIcons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import { navigate } from "@utils/navigator";
import { Button } from "native-base";
import { DeviceEventEmitter } from "react-native";

export default function SearchFriend() {
	const colors = useColors();

	return (
		<Button variant="unstyled" accessibilityLabel="FindUsers" onPress={() => navigate("FindUsers")}>
			<MaterialCommunityIcons name="magnify" size={24} style={{ color: colors.text }} />
		</Button>
	);
}
