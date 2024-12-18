import { StyleSheet } from "react-native";

export const styles = StyleSheet.create({
	card: {
		display: "flex",
		flexDirection: "column",
		width: "100%",
	},
	formControl: {
		display: "flex",
		flexDirection: "row",
		marginTop: 10,
		marginBottom: 10,
		justifyContent: "space-between",
	},
	input: {
		flex: 1,
		margin: 2,
	},
});
