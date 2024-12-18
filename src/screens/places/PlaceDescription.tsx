import ThemedView from "@components/utils/ThemedView";
import { AntDesign, Feather, Ionicons, MaterialCommunityIcons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import { useRoute } from "@react-navigation/native";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import i18n from "@utils/i18n";
import { TouchableOpacity, View, Text, StyleSheet } from "react-native";

interface IParams {
	queryType: number;
}

export default function ({ navigation }: NativeStackScreenProps<any, "MainTabs">) {
	const colors = useColors();
	const { params } = useRoute() as { params: IParams };

	return (
		<ThemedView>
			<View
				style={{
					display: "flex",
					justifyContent: "flex-start",
					flexDirection: "column",
					gap: 40,
					marginTop: 50,
					alignItems: "center",
				}}
			>
				<Text style={{ color: colors.text, fontSize: 20 }}>Nome do lugar</Text>

				<Text style={{ color: colors.text, width: "60%" }}>
					Descrição do lugar Descrição do lugar Descrição do lugar Descrição do lugar Descrição do lugar Descrição do
					lugar Descrição do lugar Descrição do lugar Descrição do lugar Descrição do lugar
				</Text>
				<View
					style={{
						display: "flex",
						alignItems: "flex-start",
						width:"100%"
					}}
				>
					<Text style={{ color: colors.text, fontSize: 16, left: 20 }}>Horário: 00:00 às 01:00</Text>
				</View>

				<TouchableOpacity style={styles.actionBtnE} onPress={() => {}}>
						<Text style={{ color: "white" }}>{i18n.get("placeDescription.show")}</Text>
						<Ionicons name="map-outline" color={"white"} size={20} />
					</TouchableOpacity>
			</View>
		</ThemedView>
	);
}

const styles = StyleSheet.create({
	actionBtnE: {
		borderRadius: 14,
		width: 200,
		height: 50,
		backgroundColor: "#018689",
		display: "flex",
		flexDirection: "row",
		justifyContent: "space-evenly",
		alignItems: "center",
	},
});
