import { Spinner } from "@ui-kitten/components";
import { StyleSheet, View } from "react-native";

export default (props: { style?: any; status?: string; children: React.ReactElement }) => (
	<View style={[props.style, styles.indicator]}>{props.children}</View>
);

const styles = StyleSheet.create({
	indicator: {
		justifyContent: "center",
		alignItems: "center",
	},
});
