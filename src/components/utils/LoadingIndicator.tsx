import { Spinner } from "@ui-kitten/components";
import { StyleSheet, View } from "react-native";

export default (props: { style?: any; status?: string }) => (
	<View style={[props.style, styles.indicator]}>
		<Spinner size="small" status={props.status ?? "basic"} />
	</View>
);

const styles = StyleSheet.create({
	indicator: {
		justifyContent: "center",
		alignItems: "center",
	},
});
