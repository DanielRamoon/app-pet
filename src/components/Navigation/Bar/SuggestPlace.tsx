import { Ionicons, MaterialCommunityIcons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import i18n from "@utils/i18n";
import { navigate } from "@utils/navigator";
import { Text, TouchableOpacity, View } from "react-native";

export default function SuggestPlace() {
	const colors = useColors();

	return (
		<View
			style={{
				display: "flex",
				flexDirection: "column",
				justifyContent: "center",
				alignItems: "center",
				gap: 10,
			}}
		>
			<TouchableOpacity
				onPress={() => navigate("Suggest")}
				style={{
					width: 80,
					height: 45,
					padding: 10,
					display: "flex",
					flexDirection: "row",
					justifyContent: "space-evenly",
					alignItems: "center",
					borderRadius: 20,
					backgroundColor: colors.primary,
				}}
			>
				<View style={{ display: "flex", flexDirection: "row", gap: 10 }}>
					<MaterialCommunityIcons name="map-marker-plus" size={20} color={"white"} />
				</View>
			</TouchableOpacity>

			<Text style={{ color: colors.text }}>{i18n.get("home.suggest")}</Text>
		</View>
	);
}
