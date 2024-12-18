import Input from "@components/Wrappers/Input";
import useColors from "@hooks/useColors";
import i18n from "@utils/i18n";
import { useRef, useState } from "react";
import { StyleSheet, Text, TouchableOpacity, View, Modal } from "react-native";
import LottieView from "lottie-react-native";

export default function LoactionP(props: { confirm: () => void }) {
	const colors = useColors();

	return (
		<Modal animationType="fade" transparent={true}>
			<View
				style={{
					flex: 1,
					justifyContent: "center",
					alignItems: "center",
					backgroundColor: "rgba(0,0,0,0.5)",
				}}
			>
				<View
					style={{
						width: 300,
						height: 310,
						backgroundColor: colors.cardColor,
						display: "flex",
						justifyContent: "flex-end",
						padding: 20,
						borderRadius: 10,
						alignItems: "center",
					}}
				>
					<LottieView
						source={require("@assets/lottie/enableLocation.json")}
						autoPlay
						style={{ width: 200, height: 150 }}
						loop={true}
						resizeMode="contain"
					/>
					<View style={styles.containerSec}>
						<Text style={{ marginVertical: 10, color: colors.text, textAlign: "justify" }}>
							{i18n.get("permissionAlert")}
						</Text>
						<View
							style={{ display: "flex", justifyContent: "center", alignItems: "center", flexDirection: "row", gap: 20 }}
						>
							<TouchableOpacity onPress={props.confirm} style={styles.confirm}>
								<Text style={{ color: "white", fontSize: 16 }}>{i18n.get("confirm")}</Text>
							</TouchableOpacity>
						</View>
					</View>
				</View>
			</View>
		</Modal>
	);
}

const styles = StyleSheet.create({
	confirm: {
		padding: 10,
		width: 120,
		backgroundColor: "#f67f31",
		borderRadius: 15,
		display: "flex",
		justifyContent: "space-evenly",
		alignItems: "center",
	},
	containerSec: {
		display: "flex",
		flexDirection: "column",
		justifyContent: "center",
		alignItems: "center",
		gap: 30,
	},
});
