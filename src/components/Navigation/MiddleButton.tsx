import { Ionicons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import { Platform, Pressable, StyleSheet, TouchableOpacity } from "react-native";

export default function MiddleButton({ onPress }: { onPress: () => void }) {
	const colors = useColors();

	if (Platform.OS === "ios")
		return (
			<TouchableOpacity
				onPress={onPress}
				activeOpacity={0.8}
				style={[styles.FAB, { backgroundColor: colors.primary, shadowColor: colors.primary }]}
			>
				<Ionicons name="map-outline" size={24} color="white" />
			</TouchableOpacity>
		);
	else
		return (
			<Pressable
				onPress={onPress}
				style={[styles.FAB, { backgroundColor: colors.primary, shadowColor: colors.primary }]}
				android_ripple={{ color: "white", radius: 25 }}
			>
				<Ionicons name="map-outline" size={24} color="white" />
			</Pressable>
		);
}

const styles = StyleSheet.create({
	FAB: {
		position: "relative",
		bottom: 15,
		alignItems: "center",
		justifyContent: "center",
		width: 50,
		height: 50,
		borderRadius: 25,
		shadowColor: "#000",
		shadowOffset: {
			width: 0,
			height: 2,
		},
		shadowOpacity: 0.25,
		shadowRadius: 3.84,
		elevation: 5,
	},
});
