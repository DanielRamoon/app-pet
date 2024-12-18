import Input from "@components/Wrappers/Input";
import { View, Text, TouchableOpacity, Platform, Dimensions, Alert, KeyboardAvoidingView } from "react-native";
import i18n from "@utils/i18n";
import useColors from "@hooks/useColors";
import { useRoute } from "@react-navigation/native";
import React, { useEffect, useRef, useState } from "react";
import petsHealthMedicinesService, {
	IPetHealthMedicines,
} from "@utils/supabase/services/pets/pets-health-medicines.service";
import { DateTimePickerAndroid } from "@react-native-community/datetimepicker";
import { AlertDialog, Button } from "native-base";
import ThemedView from "@components/utils/ThemedView";
import ContentLoader, { Rect } from "react-content-loader/native";
import { goBack } from "@utils/navigator";
import DateTimePicker from "@react-native-community/datetimepicker";
import pet_reminder from "@utils/supabase/services/pets/pet_reminder";
import { DateTime } from "luxon";
import PlatformButton from "@components/Wrappers/PlatformButton";

export default function EditMedicine() {
	const colors = useColors();
	const route = useRoute();

	const [medicine, setMedicine] = useState<IPetHealthMedicines>();

	const [modePicker, setModePicker] = useState<"start" | "end">("start");

	const [pickingDate, setPickingDate] = useState<boolean>(false);
	const [disable, setDisable] = useState<boolean>(false);
	const [loading, setLoading] = useState<boolean>(true);
	const [pickingStartDate, setPickingStartDate] = useState(false);
	const [pickingEndDate, setPickingEndDate] = useState(false);

	const params = route.params as { id: number };

	const cancelRef = useRef(null);

	useEffect(() => {
		(async () => {
			const res = await petsHealthMedicinesService.getPetHealthMedicine(params.id);
			if (res.data) {
				setMedicine(res.data);
				setLoading(false);
			}
		})();
	}, []);

	async function updateMedicine() {
		const res = await petsHealthMedicinesService.updatePetHealthMedicines(params.id, medicine!);

		if (medicine) {
			const resReminder = await pet_reminder.getPetReminderByMedicineId(medicine.id);
			if (resReminder.data) {
				await pet_reminder.updatePetReminder(resReminder.data.id, {
					remember_when: DateTime.fromJSDate(medicine.medication_start)
						.setZone("utc")
						.set({ hour: 0, minute: 0, second: 0, millisecond: 0 })
						.toISO()!,
					updated_at: DateTime.fromJSDate(new Date()).setZone("utc").toISO()!,
				});
			}
		}
		if (res.status === 200) {
			goBack();
			setDisable(false);
		} else {
			Alert.alert(
				i18n.get("error"),
				i18n.get("pets.medicine.updateError"),
				[{ text: "OK", onPress: () => setDisable(false) }],
				{ cancelable: false }
			);
		}
	}

	const onChangeStartDate = (event: any, selectedDate: any) => {
		if (Platform.OS === "android" && event.type === "dismissed") return setPickingDate(false);

		if (selectedDate && medicine) {
			if (new Date(selectedDate) > new Date(medicine.medication_end)) {
				setMedicine({ ...medicine, medication_start: selectedDate, medication_end: selectedDate });
			} else {
				setMedicine({ ...medicine, medication_start: selectedDate });
			}
		}

		if (Platform.OS === "android") {
			setPickingDate(false);
		}
	};

	const showStartDatepicker = () => {
		DateTimePickerAndroid.open({
			value: new Date(medicine!.medication_start),
			onChange: onChangeStartDate,
			mode: "date",
			is24Hour: true,
			minimumDate: new Date(),
		});
	};

	const onChangeEndDate = (event: any, selectedDate: any) => {
		if (Platform.OS === "android" && event.type === "dismissed") return setPickingDate(false);

		if (selectedDate && medicine) {
			setMedicine({
				...medicine,
				medication_end: selectedDate,
			});
		}

		if (Platform.OS === "android") {
			setPickingDate(false);
		}
	};

	const showEndDatepicker = () => {
		DateTimePickerAndroid.open({
			value: new Date(medicine!.medication_end),
			onChange: onChangeEndDate,
			mode: "date",
			is24Hour: true,
			minimumDate: new Date(medicine!.medication_start),
		});
	};

	if (loading && !medicine) {
		return (
			<ThemedView>
				<View style={{ flex: 1 }}>
					<ContentLoader
						viewBox={`0 0 ${Dimensions.get("window").width} ${Dimensions.get("window").height}`}
						backgroundColor={colors.loaderBackColor}
						foregroundColor={colors.loaderForeColor}
					>
						<Rect width={Dimensions.get("window").width * 0.9} height={45} x={20} y={80} rx={3} ry={3} />
						<Rect width={Dimensions.get("window").width * 0.9} height={45} x={20} y={160} rx={3} ry={3} />
						<Rect width={Dimensions.get("window").width * 0.9} height={45} x={20} y={240} rx={3} ry={3} />

						<Rect width={140} height={40} x={20} y={320} rx={8} ry={8} />
						<Rect width={140} height={40} x={20} y={400} rx={8} ry={8} />

						<Rect width={140} height={50} x={20} y={500} rx={5} ry={5} />
					</ContentLoader>
				</View>
			</ThemedView>
		);
	} else {
		return (
			<ThemedView>
				{/* <KeyboardAvoidingView behavior={Platform.OS === "ios" ? "padding" : "height"}>
					<AlertDialog
						isOpen={pickingStartDate && pickingDate}
						onClose={() => setPickingStartDate(false)}
						leastDestructiveRef={cancelRef}
						closeOnOverlayClick={true}
						overlayVisible={true}
						safeArea={true}
						avoidKeyboard={true}
						style={{ paddingBottom: 100 }}
					>
						<AlertDialog.Content>
							{Platform.OS === "ios" && (
								<>
									<AlertDialog.CloseButton />
									<AlertDialog.Header>{i18n.get("pets.profile.medicineStartTreatment")}</AlertDialog.Header>
								</>
							)}
							<AlertDialog.Body>
								<DateTimePicker
									value={new Date(medicine!.medication_start)}
									onChange={(e, date: Date) => {
										if (date) {
											setMedicine({ ...medicine!, medication_start: date });
										}

										onChangeStartDate(e, date);
									}}
									mode={"datetime"}
									// is24Hour={true}
									minimumDate={new Date()}
								/>
							</AlertDialog.Body>
							{Platform.OS === "ios" && (
								<AlertDialog.Footer>
									<Button.Group space={2}>
										<PlatformButton
											onPress={() => {
												// setShowIOSDate(false);
												setPickingStartDate(false);
											}}
											style={{ backgroundColor: colors.danger }}
											useDefaultStyle={true}
										>
											{i18n.get("cancel")}
										</PlatformButton>

										<PlatformButton
											onPress={() => setPickingStartDate(false)}
											style={{ backgroundColor: colors.primary }}
											useDefaultStyle={true}
										>
											{i18n.get("confirm")}
										</PlatformButton>
									</Button.Group>
								</AlertDialog.Footer>
							)}
						</AlertDialog.Content>
					</AlertDialog>
				</KeyboardAvoidingView> */}

				<KeyboardAvoidingView behavior={Platform.OS === "ios" ? "padding" : "height"}>
					<AlertDialog
						isOpen={pickingDate}
						onClose={() => setPickingDate(false)}
						leastDestructiveRef={cancelRef}
						closeOnOverlayClick={true}
						overlayVisible={true}
						safeArea={true}
						avoidKeyboard={true}
						style={{ paddingBottom: 100 }}
					>
						<AlertDialog.Content>
							{Platform.OS === "ios" && (
								<>
									<AlertDialog.CloseButton />
									<AlertDialog.Header>{i18n.get("pets.profile.medicineEndTreatment")}</AlertDialog.Header>
								</>
							)}
							<AlertDialog.Body>
								<DateTimePicker
									value={new Date(medicine!.medication_end)}
									onChange={(e, date: Date) => {
										if (date) {
											if (modePicker === "start") {
												if (date > new Date(medicine!.medication_end)) {
													setMedicine({ ...medicine!, medication_start: date, medication_end: date });
												} else {
													setMedicine({ ...medicine!, medication_start: date });
												}
											}
										}

										if (modePicker === "start") {
											onChangeStartDate(e, date);
										} else {
											onChangeEndDate(e, date);
										}
									}}
									mode={"datetime"}
									// is24Hour={true}
									minimumDate={new Date()}
								/>
							</AlertDialog.Body>
							{Platform.OS === "ios" && (
								<AlertDialog.Footer>
									<Button.Group space={2}>
										<PlatformButton
											onPress={() => {
												setPickingDate(false);
											}}
											style={{ backgroundColor: colors.danger }}
											useDefaultStyle={true}
										>
											{i18n.get("cancel")}
										</PlatformButton>

										<PlatformButton
											onPress={() => setPickingDate(false)}
											style={{ backgroundColor: colors.primary }}
											useDefaultStyle={true}
										>
											{i18n.get("confirm")}
										</PlatformButton>
									</Button.Group>
								</AlertDialog.Footer>
							)}
						</AlertDialog.Content>
					</AlertDialog>
				</KeyboardAvoidingView>

				<View
					style={{
						gap: 20,
						marginTop: 30,
						marginBottom: 30,
						padding: 20,
						width: "100%",
						display: "flex",
						alignItems: "flex-start",
						justifyContent: "flex-start",
					}}
				>
					<View
						style={{
							gap: 8,
							display: "flex",
							alignItems: "flex-start",
							justifyContent: "flex-start",
							width: "100%",
						}}
					>
						<Input
							value={medicine!.description}
							onChangeText={(value) => setMedicine({ ...medicine!, description: value })}
							label={i18n.get("pets.profile.medicineName")}
							labelProps={{ color: colors.text }}
						/>
						<Input
							value={medicine!.dose}
							onChangeText={(value) => setMedicine({ ...medicine!, dose: value })}
							label={i18n.get("pets.profile.medicineDose")}
							labelProps={{ color: colors.text }}
						/>
						<Input
							value={medicine!.amount}
							onChangeText={(value) => setMedicine({ ...medicine!, amount: value })}
							label={i18n.get("pets.profile.medicineAmount")}
							labelProps={{ color: colors.text }}
						/>
						<Text style={{ color: colors.text, marginTop: 20 }}>{i18n.get("pets.profile.medicineStartTreatment")}</Text>
						<TouchableOpacity
							style={{
								display: "flex",
								justifyContent: "center",
								alignItems: "center",
								backgroundColor: colors.background,
								borderWidth: 1,
								borderColor: colors.primary,
								padding: 10,
								flexDirection: "row",
								gap: 10,
								borderRadius: 15,
								width: 150,
							}}
							onPress={() => {
								if (Platform.OS === "ios") {
									setModePicker("start");
									setPickingDate(true);
								} else showStartDatepicker();
							}}
						>
							<Text style={{ color: colors.text }}>
								{new Date(medicine!.medication_start).toLocaleDateString(i18n.locale)}
							</Text>
						</TouchableOpacity>
					</View>

					<View
						style={{
							gap: 8,
							display: "flex",
							alignItems: "flex-start",
							justifyContent: "flex-start",
							width: "100%",
						}}
					>
						<Text style={{ color: colors.text }}>{i18n.get("pets.profile.medicineEndTreatment")}</Text>
						<TouchableOpacity
							style={{
								display: "flex",
								justifyContent: "center",
								alignItems: "center",
								backgroundColor: colors.background,
								borderWidth: 1,
								borderColor: colors.primary,
								padding: 10,
								flexDirection: "row",
								gap: 10,
								borderRadius: 15,
								width: 150,
							}}
							onPress={() => {
								if (Platform.OS === "ios") {
									setModePicker("end");
									setPickingDate(true);
								} else showEndDatepicker();
							}}
						>
							<Text style={{ color: colors.text }}>
								{new Date(medicine!.medication_end).toLocaleDateString(i18n.locale)}
							</Text>
						</TouchableOpacity>
					</View>
					<View
						style={{
							display: "flex",
							justifyContent: "center",
							alignItems: "center",
							width: "100%",
							marginTop: 20,
						}}
					>
						<TouchableOpacity
							disabled={disable}
							style={{ backgroundColor: colors.primary, padding: 10, borderRadius: 10 }}
							onPress={() => {
								setDisable(true);
								updateMedicine();
							}}
						>
							<Text style={{ color: "white", textAlign: "center" }}>{i18n.get("save")}</Text>
						</TouchableOpacity>
					</View>
				</View>
			</ThemedView>
		);
	}
}
