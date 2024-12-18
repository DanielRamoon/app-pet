import { TouchableOpacity } from "react-native";
import i18n, { emojis, setLocale } from "@utils/i18n";
import { AlertDialog, Button, ScrollView, Text } from "native-base";
import useColors from "@hooks/useColors";
import { useRef, useState } from "react";
import PlatformButton from "@components/Wrappers/PlatformButton";

interface IProps {
	onPress: () => void;
	extended?: boolean;
	style?: any;
	bigger?: boolean;
	list?: boolean;
}

const textStyle = {
	fontSize: 20,
	fontWeight: "bold",
	fontFamily: "Inter",
};

export default (props: IProps) => {
	const colors = useColors();

	const [isModalVisible, setModalVisible] = useState(false);

	const close = () => setModalVisible(false);
	const cancelRef = useRef(null);

	return (
		<>
			<AlertDialog
				isOpen={isModalVisible}
				onClose={close}
				leastDestructiveRef={cancelRef}
				closeOnOverlayClick={true}
				overlayVisible={true}
				safeArea={true}
			>
				<AlertDialog.Content>
					<AlertDialog.CloseButton />
					<AlertDialog.Header>{i18n.get("changeLocale")}</AlertDialog.Header>
					<AlertDialog.Body>
						<ScrollView>
							{Object.keys(emojis).map((locale) => (
								<TouchableOpacity
									key={locale}
									onPress={() => {
										setLocale(locale);
										props.onPress();
										close();
									}}
									style={{ marginVertical: 5, alignItems: "flex-start", justifyContent: "flex-start" }}
								>
									<Text style={{ fontFamily: "Inter", fontWeight: "bold", fontSize: 14 }}>
										{(emojis as any)[locale] + " " + locale.toLocaleUpperCase()}
									</Text>
								</TouchableOpacity>
							))}
						</ScrollView>
					</AlertDialog.Body>
					<AlertDialog.Footer>
						<Button.Group space={2}>
							<PlatformButton
								onPress={() => setModalVisible(false)}
								style={{ backgroundColor: colors.danger }}
								useDefaultStyle={true}
							>
								{i18n.get("cancel")}
							</PlatformButton>
						</Button.Group>
					</AlertDialog.Footer>
				</AlertDialog.Content>
			</AlertDialog>

			<TouchableOpacity
				style={[{ marginLeft: props.list ? 0 : "auto", ...props.style }, props.list ? { flexDirection: "row" } : {}]}
				onPress={() => {
					// toggleLocale();
					// props.onPress();

					setModalVisible(!isModalVisible);
				}}
			>
				{props.list && <Text>{i18n.get("changeLocale")}</Text>}

				<Text
					style={{
						...(textStyle as any),
						fontSize: props.bigger ? 28 : textStyle.fontSize,
						marginLeft: props.list ? "auto" : 0,
					}}
				>
					{(emojis as any)[i18n.locale] + " "} {props.extended ? i18n.get("changeLocale") : ""}
				</Text>
			</TouchableOpacity>
		</>
	);
};
