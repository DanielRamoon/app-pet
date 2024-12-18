import Input from "@components/Wrappers/Input";
import useColors from "@hooks/useColors";
import i18n from "@utils/i18n";
import { AlertDialog } from "native-base";
import { useRef, useState } from "react";
import { StyleSheet, Text, TouchableOpacity, View } from "react-native";

export default function QuestionModal(props: {
	cancel: () => void;
	confirm: (returningValue: string) => void;
	title: string;
	inputMessage?: string;
	customBody?: JSX.Element;
	avoidKeyboard?: boolean;
	hideCancel?: boolean;
	customHeight?: number;
}) {
	const colors = useColors();

	const [returningValue, setReturningValue] = useState("");

	const cancelRef = useRef(null);
	return (
		<AlertDialog
			isOpen={true}
			onClose={() => 0}
			leastDestructiveRef={cancelRef}
			closeOnOverlayClick={true}
			safeArea={true}
			avoidKeyboard={props.avoidKeyboard ?? true}
			style={{ height: "100%", width: "100%" }}
		>
			<AlertDialog.Content style={{ display: "flex", flexDirection: "column", height: props.customHeight ?? "auto" }}>
				{!props.hideCancel && <AlertDialog.CloseButton onPress={props.cancel} />}

				<AlertDialog.Body style={{ height: "auto" }}>
					<Text style={{ width: "100%", color: colors.text, fontSize: 18 }}>{props.title}</Text>
					{props.customBody ? (
						props.customBody
					) : (
						<View
							style={{ width: "100%", height: "auto", display: "flex", justifyContent: "center", alignItems: "center" }}
						>
							<Input
								value={returningValue}
								onChangeText={setReturningValue}
								label={props.inputMessage}
								labelProps={{ color: colors.text }}
							/>
						</View>
					)}
				</AlertDialog.Body>
				<View
					style={{
						paddingBottom: 10,
						display: "flex",
						flexDirection: "row",
						gap: 10,
						justifyContent: "center",
						marginTop: "auto",
					}}
				>
					<TouchableOpacity onPress={props.cancel} style={{ ...styles.cancel, backgroundColor: colors.danger }}>
						<Text style={{ color: "white" }}>{i18n.get("cancel")}</Text>
					</TouchableOpacity>

					<TouchableOpacity onPress={() => props.confirm(returningValue)} style={styles.confirm}>
						<Text style={{ color: "white" }}>{i18n.get("confirm")}</Text>
					</TouchableOpacity>
				</View>
			</AlertDialog.Content>
		</AlertDialog>
	);
}

const styles = StyleSheet.create({
	cancel: {
		padding: 10,
		width: 120,
		borderRadius: 15,
		display: "flex",
		justifyContent: "space-evenly",
		alignItems: "center",
	},
	confirm: {
		padding: 10,
		width: 120,
		backgroundColor: "#f67f31",
		borderRadius: 15,
		display: "flex",
		justifyContent: "space-evenly",
		alignItems: "center",
	},
});
