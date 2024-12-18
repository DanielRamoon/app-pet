import Input from "@components/Wrappers/Input";
import PlatformButton from "@components/Wrappers/PlatformButton";
import TextArea from "@components/Wrappers/TextArea";
import { Ionicons } from "@expo/vector-icons";
import useAppTheme from "@hooks/useAppTheme";
import useColors from "@hooks/useColors";
import i18n from "@utils/i18n";
import { AlertDialog, Button, Checkbox, Radio, Stack, Text, View } from "native-base";
import { useRef, useState } from "react";
import { StyleSheet } from "react-native";

export default function ShareModal(props: {
	cancel: () => void;
	confirm: (val: { mode: "compact" | "full" | "internal"; showMap: boolean; text?: string }) => void;
}) {
	const [theme] = useAppTheme();
	const colors = useColors();

	const [mode, setMode] = useState<"uncertain" | "internal" | "external">("external");
	const [shareText, setShareText] = useState<string>("");

	const [returningValue, setReturningValue] = useState<{ mode: "compact" | "full"; showMap: boolean }>({
		mode: "compact",
		showMap: false,
	});

	const cancelRef = useRef(null);
	return (
		<AlertDialog
			isOpen={true}
			onClose={() => 0}
			leastDestructiveRef={cancelRef}
			closeOnOverlayClick={true}
			safeArea={true}
			avoidKeyboard={false}
		>
			<AlertDialog.Content>
				<AlertDialog.CloseButton onPress={props.cancel} />
				<AlertDialog.Header>{i18n.get("share")}</AlertDialog.Header>
				<AlertDialog.Body
					style={{
						display: "flex",
						flexDirection: "column",
						width: "100%",
					}}
				>
					{mode === "uncertain" ? (
						<View>
							<Button
								mb={5}
								height={46}
								onPress={() => setMode("internal")}
								style={{ marginTop: "auto" }}
								bgColor={colors.primary}
								leftIcon={<Ionicons name="share" size={24} style={{ marginRight: 5 }} color="white" />}
							>
								Publicação Interna
							</Button>

							<Button
								height={46}
								onPress={() => setMode("external")}
								style={{ marginTop: "auto" }}
								bgColor={colors.primary}
								leftIcon={<Ionicons name="share-social" size={24} style={{ marginRight: 5 }} color="white" />}
							>
								Publicação Externa
							</Button>
						</View>
					) : mode === "internal" ? (
						<View>
							<TextArea
								value={shareText}
								onChangeText={setShareText}
								accessibilityLabel="shareText"
								aria-label="shareText"
								numberOfLines={4}
								h={20}
								placeholder={i18n.get("tellWalk")}
								w="100%"
							/>
						</View>
					) : (
						<>
							<Text fontSize={16} fontWeight="black" mb={5}>
								{i18n.get("format")}
							</Text>

							<Radio.Group
								name="ShareGroup"
								defaultValue={returningValue.mode}
								onChange={(value) => setReturningValue((val) => ({ ...val, mode: value as any }))}
								aria-label={i18n.get("share")}
								style={{
									display: "flex",
									flexDirection: "row",
									width: "100%",
									justifyContent: "center",
									alignItems: "center",
								}}
							>
								<Stack direction="row" alignItems="flex-end" justifyContent="center" space={4} w="100%">
									<View
										style={{ display: "flex", flexDirection: "column", justifyContent: "center", alignItems: "center" }}
									>
										{/* <View style={{ height: 50, width: 50 }}>
											<Ionicons name="image" color={theme === "dark" ? "white" : "black"} size={50} />
										</View> */}
										<Radio
											value="compact"
											colorScheme="primary"
											size="sm"
											my={5}
											aria-label={i18n.get("compact")}
											accessibilityLabel={i18n.get("compact")}
										>
											{i18n.get("compact")}
										</Radio>
									</View>
									<View
										style={{ display: "flex", flexDirection: "column", justifyContent: "center", alignItems: "center" }}
									>
										{/* <View style={{ height: 80, width: 50 }}>
											<Ionicons
												name="image"
												color={theme === "dark" ? "white" : "black"}
												size={50}
												style={{ transform: [{ translateY: 13 }, { scaleY: 2 }, { scaleX: 1.3 }] }}
											/>
										</View> */}
										<Radio
											value="full"
											colorScheme="primary"
											size="sm"
											my={5}
											aria-label={i18n.get("full")}
											accessibilityLabel={i18n.get("full")}
										>
											{i18n.get("full")}
										</Radio>
									</View>
								</Stack>
							</Radio.Group>

							<Text fontSize={16} fontWeight="black" mb={5} mt={5}>
								{i18n.get("showMap")}
							</Text>

							<Checkbox
								accessibilityLabel="showMap"
								aria-label="showMap"
								value="showMap"
								isChecked={returningValue.showMap ?? false}
								onChange={(value) => setReturningValue((val) => ({ ...val, showMap: value }))}
							>
								{returningValue.showMap ? i18n.get("yes") : i18n.get("no")}
							</Checkbox>
						</>
					)}
				</AlertDialog.Body>
				<AlertDialog.Footer>
					<Button.Group space={2} opacity={mode === "uncertain" ? 0.35 : 1}>
						<PlatformButton
							onPress={mode === "uncertain" ? () => {} : props.cancel}
							style={{ backgroundColor: colors.danger }}
							useDefaultStyle={true}
						>
							{i18n.get("cancel")}
						</PlatformButton>

						<PlatformButton
							onPress={() => (mode === "uncertain" ? null : props.confirm(returningValue))}
							style={{ backgroundColor: colors.primary }}
							useDefaultStyle={true}
						>
							{i18n.get("confirm")}
						</PlatformButton>
					</Button.Group>
				</AlertDialog.Footer>
			</AlertDialog.Content>
		</AlertDialog>
	);
}

const styles = StyleSheet.create({});
