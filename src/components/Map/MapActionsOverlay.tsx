import { Ionicons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import { StyleSheet, Text, TouchableWithoutFeedback, View } from "react-native";
import { useSelector } from "react-redux";
import { RootState } from "src/store/store";

type MapActions = "stop" | "pause" | "resume" | "details";

const RoundedButton = ({
	children,
	bgColor,
	onPress,
}: {
	children: React.ReactNode;
	bgColor: string;
	onPress: () => void;
}) => {
	return (
		<TouchableWithoutFeedback style={[styles.roundedButton, { backgroundColor: bgColor }]} onPress={onPress}>
			<View style={[styles.roundedButton, { backgroundColor: bgColor }]}>{children}</View>
		</TouchableWithoutFeedback>
	);
};

export default function MapActionsOverlay({ onAction }: { onAction: (action: MapActions) => void }) {
	const currentWalk = useSelector((state: RootState) => state.currentWalk);
	const colors = useColors();

	return (
		<View
			style={{
				width: "100%",
				display: "flex",
				flexDirection: "row",
				justifyContent: "space-around",
				paddingBottom: 50,
				...styles.overlay,
			}}
		>
			{/* <Text style={{ position: "absolute", bottom: 0, right: 0 }}>
				Duração Total: {currentWalk.value.duration}s | Iniciado em: {currentWalk.value.walk.date_start}
			</Text> */}

			<RoundedButton bgColor={colors.danger} onPress={() => onAction("stop")}>
				<Ionicons name={"stop"} size={30} style={{ marginLeft: 1 }} color="white" />
			</RoundedButton>
			<RoundedButton bgColor={colors.active} onPress={() => onAction("details")}>
				<Ionicons name={"chevron-up"} size={30} color="white" />
			</RoundedButton>
			<RoundedButton
				bgColor={colors.primary}
				onPress={() => onAction(currentWalk?.status === "paused" ? "resume" : "pause")}
			>
				<Ionicons
					name={currentWalk?.status === "paused" ? "play" : "pause"}
					size={30}
					style={{ marginLeft: currentWalk?.status === "paused" ? 5 : 1 }}
					color="white"
				/>
			</RoundedButton>
		</View>
	);
}

const styles = StyleSheet.create({
	overlay: {
		position: "absolute",
		bottom: 0,
		left: 0,
		right: 0,
		// backgroundColor: "rgba(0, 0, 0, 0.5)",
		zIndex: 100,
	},
	roundedButton: {
		width: 50,
		height: 50,
		borderRadius: 50,
		backgroundColor: "white",
		marginLeft: "auto",
		marginRight: "auto",
		marginBottom: "auto",
		padding: 0,

		display: "flex",
		justifyContent: "center",
		alignItems: "center",
	},
});
