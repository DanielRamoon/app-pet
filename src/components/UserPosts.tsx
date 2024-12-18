import { View, Image, StyleSheet, Text, TouchableOpacity } from "react-native";
import AsyncStorage from "@react-native-async-storage/async-storage";
import ThemedView from "./utils/ThemedView";
import useColors from "@hooks/useColors";
import { Ionicons, MaterialCommunityIcons } from "@expo/vector-icons";
import i18n from "@utils/i18n";
export default function UserPost({ data }: any) {
	const colors = useColors();

	return (
		<ThemedView>
			<View style={{ paddingRight: 50 }}>
				<View style={{ ...styles.icon, backgroundColor: colors.background }}>
					<Image style={styles.image} source={{ uri: data }} />
				</View>
				<View
					style={{
						backgroundColor: colors.cardColorSelected,
						height: 200,
						borderRadius: 15,
						borderBottomRightRadius: 15,
					}}
				>
					<Text style={{ width: 250, color: colors.text, padding: 15, height: "100%", textAlignVertical: "center" }}>
						Gomão{i18n.get("walksWith")}Luka{i18n.get("for")}18km
					</Text>
					<Text
						style={{ width: 250, color: colors.text, padding: 15, height: "100%", textAlignVertical: "center" }}
					></Text>
				</View>
				<View style={{ width: "100%", display: "flex", flexDirection: "row", gap: 10, top: -25, zIndex: 99 }}>
					<View
						style={{
							width: "auto",
							padding: 5,
							height: 45,
							zIndex: 98,
							backgroundColor: "#229fdc",
							borderRadius: 15,
							display: "flex",
							flexDirection: "row",
							alignItems: "center",
							justifyContent: "center",
						}}
					>
						<MaterialCommunityIcons name="paw" size={24} color={"white"} />
						<Text style={{ color: "white" }}> +999</Text>
					</View>

					<View
						style={{
							width: "auto",
							padding: 5,
							height: 45,
							zIndex: 98,
							backgroundColor: "#b82256",
							borderRadius: 15,
							display: "flex",
							flexDirection: "row",
							alignItems: "center",
							justifyContent: "center",
						}}
					>
						<Ionicons name="heart" size={24} color={"white"} />
						<Text style={{ color: "white" }}> +999</Text>
					</View>

					<View
						style={{
							width: "auto",
							padding: 5,
							height: 45,
							zIndex: 98,
							backgroundColor: "#3b4270",
							borderRadius: 15,
							display: "flex",
							flexDirection: "row",
							alignItems: "center",
							justifyContent: "center",
							marginLeft: 20,
						}}
					>
						<Ionicons name="chatbox" size={24} color={"white"} />
						<Text style={{ color: "white" }}> +999</Text>
					</View>
				</View>
			</View>
		</ThemedView>
	);
}

const styles = StyleSheet.create({
	image: {
		width: 50,
		height: 50,
		borderRadius: 999,
	},
	imagemBody: {
		width: 250,
		height: 200,
		borderRadius: 15,
	},
	icon: {
		width: 70,
		height: 70,
		borderRadius: 999,
		display: "flex",
		alignItems: "center",
		justifyContent: "center",
		left: -10,
		top: -10,
		position: "absolute",
		zIndex: 99,
	},
	container: {},
	footer: {},
});
