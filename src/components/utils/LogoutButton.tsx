import { Ionicons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import { TouchableWithoutFeedback } from "@ui-kitten/components/devsupport";
import i18n from "@utils/i18n";
import { logOut } from "@utils/supabase/client";
import { AlertDialog, Button } from "native-base";
import { useRef, useState } from "react";

export default (props: { style?: Record<string, any> }) => {
	const colors = useColors();

	const [isModalVisible, setModalVisible] = useState(false);

	const close = () => setModalVisible(false);
	const cancelRef = useRef(null);

	return (
		<>
			<AlertDialog isOpen={isModalVisible} onClose={close} leastDestructiveRef={cancelRef}>
				<AlertDialog.Content>
					<AlertDialog.CloseButton />
					<AlertDialog.Header>{i18n.get("logout")}</AlertDialog.Header>
					<AlertDialog.Body>{i18n.get("logoutExplanation")}</AlertDialog.Body>
					<AlertDialog.Footer>
						<Button.Group space={2}>
							<Button variant="unstyled" onPress={close} ref={cancelRef}>
								{i18n.get("cancel")}
							</Button>
							<Button bgColor={colors.danger} onPress={logOut}>
								{i18n.get("confirm")}
							</Button>
						</Button.Group>
					</AlertDialog.Footer>
				</AlertDialog.Content>
			</AlertDialog>
			<TouchableWithoutFeedback
				style={{ display: "flex", justifyContent: "center", flex: 1, marginRight: 12, ...props.style }}
				onPress={() => setModalVisible(!isModalVisible)}
			>
				<Ionicons name="exit" color="white" size={24} />
			</TouchableWithoutFeedback>
		</>
	);
};
