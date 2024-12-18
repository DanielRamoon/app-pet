import PlatformButton from "@components/Wrappers/PlatformButton";
import useColors from "@hooks/useColors";
import i18n from "@utils/i18n";
import { AlertDialog, Button } from "native-base";
import { useRef } from "react";
import { StyleSheet } from "react-native";

export default function DeleteModal(props: {
	cancel: () => void;
	confirm: () => void;
	title: string;
	message: string;
}) {
	const colors = useColors();

	const cancelRef = useRef(null);
	return (
		<AlertDialog
			isOpen={true}
			onClose={() => 0}
			leastDestructiveRef={cancelRef}
			closeOnOverlayClick={true}
			safeArea={true}
			avoidKeyboard={true}
		>
			<AlertDialog.Content>
				<AlertDialog.CloseButton />
				<AlertDialog.Header>{props.title}</AlertDialog.Header>
				<AlertDialog.Body>{props.message}</AlertDialog.Body>
				<AlertDialog.Footer>
					<Button.Group space={2}>
						<PlatformButton onPress={props.cancel} style={{ backgroundColor: colors.danger }} useDefaultStyle={true}>
							{i18n.get("cancel")}
						</PlatformButton>

						<PlatformButton onPress={props.confirm} style={{ backgroundColor: colors.primary }} useDefaultStyle={true}>
							{i18n.get("confirm")}
						</PlatformButton>
					</Button.Group>
				</AlertDialog.Footer>
			</AlertDialog.Content>
		</AlertDialog>
	);
}

const styles = StyleSheet.create({});
