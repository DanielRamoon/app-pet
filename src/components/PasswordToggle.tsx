import { StyleSheet, TouchableOpacity, View } from "react-native";
import { Ionicons } from "@expo/vector-icons";

export default (props: { show?: boolean; onPress?: () => void }) => (
	<TouchableOpacity onPress={props.onPress}>
		<Ionicons name={props.show ? "eye-off" : "eye"} size={24} color="gray" />
	</TouchableOpacity>
);
