import Loader from "@components/Loader";
import SuccessModal from "@components/Modals/SuccessModal";
import WrongTime from "@components/Modals/WrongTime";
import WrappedSelect from "@components/Wrappers/Select";
import ThemedView from "@components/utils/ThemedView";
import { Ionicons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import { DateTimePickerAndroid } from "@react-native-community/datetimepicker";
import { useRoute } from "@react-navigation/native";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import i18n from "@utils/i18n";
import pet_reminder from "@utils/supabase/services/pets/pet_reminder";
import petsService, { IPet } from "@utils/supabase/services/pets/pets.service";
import { DateTime } from "luxon";
import { AlertDialog, Button, Input, Select, TextArea, View } from "native-base";
import { useEffect, useRef, useState } from "react";
import { Alert, Dimensions, KeyboardAvoidingView, Platform, ScrollView, Text, TouchableOpacity } from "react-native";
import DateTimePicker from "@react-native-community/datetimepicker";
import PlatformButton from "@components/Wrappers/PlatformButton";
import ContentLoader, { Rect } from "react-content-loader/native";
import petsHealthMedicinesService, {
	eMedicineType,
	IPetHealthMedicines,
} from "@utils/supabase/services/pets/pets-health-medicines.service";
import { goBack } from "@utils/navigator";
import petsHealthService, { IPetHealth } from "@utils/supabase/services/pets/pets-health.service";
import { IServiceResponse } from "types/general";

interface IParams {
	id_reminder: string;
	isMedicine: boolean;
	medicineId?: number;
}

export default function AddReminder({ navigation }: NativeStackScreenProps<any, "MainTabs">) {
	const colors = useColors();
	const [title, setTitle] = useState<string | null>(null);
	const [desc, setDesc] = useState<string | null>(null);
	const [select, setSelect] = useState<string>();
	const [pets, setPets] = useState<IPet[] | undefined>([]);
	const [medicine, setMedicine] = useState<IPetHealthMedicines>();
	const [pickingDate, setPickingDate] = useState(false);
	const [pickingStartDate, setPickingStartDate] = useState(false);
	const [pickingEndDate, setPickingEndDate] = useState(false);
	const [success, setSuccess] = useState(false);
	const [messageTime, setMessageTime] = useState<string>("");
	const [invalidS, setInvalidS] = useState<boolean>(false);
	const [invalidT, setInvalidT] = useState<boolean>(false);
	const [invalidA, setInvalidA] = useState<boolean>(false);
	const [wrongTime, setWrongTime] = useState<boolean>(false);
	const [loading, setLoading] = useState(true);
	const [selectedDate, setSelectedDate] = useState<Date>(new Date());
	const [selectedTime, setSelectedTime] = useState<Date>(new Date());

	const date = new Date();
	const { params } = useRoute() as { params: IParams };

	useEffect(() => {
		(async () => {
			if (params.isMedicine) {
				const res = await petsHealthMedicinesService.getPetHealthMedicine(params.medicineId!);
				if (res.data) {
					setMedicine(res.data);
				}
			}

			await petsService.getPets().then((result) => {
				const petsFilter = result.data?.map((val) => {
					return val;
				});

				setPets(petsFilter);
			});

			if (params?.id_reminder) {
				setLoading(true);
				await pet_reminder.getPetReminderById(params.id_reminder).then((val: any) => {
					if (val.data) {
						setTitle(val.data.text);
						setDesc(val.data.description);
						setSelect(val.data.pet_id);
						if (val.data.remember_when && !val.data.triggered) {
							setSelectedDate(new Date(val.data.remember_when));
							setSelectedTime(new Date(val.data.remember_when));
						}
						setLoading(false);
					}
				});

				setLoading(false);
			} else {
				setLoading(false);
			}
		})();
	}, []);

	function formatHoursAndMinutes(date_: Date) {
		const date = DateTime.fromJSDate(date_).setZone("local").toJSDate();

		const options = { hour: "2-digit", minute: "2-digit" } as const;
		return date.toLocaleTimeString(i18n.locale, options);
	}

	async function updateMedicine() {
		if (medicine && select) {
			const petHealth = await petsHealthService.getPetHealthId(select);
			const res = await petsHealthMedicinesService.updatePetHealthMedicines(
				params.medicineId!,
				medicine!,
				petHealth.data
			);
			await pet_reminder.updatePetReminder(params.id_reminder, {
				pet_id: select,
				description: desc,
				remember_when: DateTime.fromJSDate(new Date(medicine.medication_start))
					.setZone("utc")
					.set({ hour: 0, minute: 0, second: 0, millisecond: 0 })
					.toISO()!,
				updated_at: DateTime.fromJSDate(date).setZone("utc").toISO()!,
			});

			//const health = await petsHealthMedicinesService.getPetHealthMedicine();
			if (res.status == 200) {
				navigation.navigate("Reminders", {
					reload: Math.random(),
				});
			} else {
				Alert.alert(i18n.get("error"), i18n.get("pets.medicine.updateError"), [{ text: "OK" }], { cancelable: false });
			}
		}
	}

	async function saveReminder() {
		if (!title) {
			setInvalidT(true);
			return;
		} else if (!desc) {
			setInvalidA(true);
			return;
		} else if (!select) {
			setInvalidS(true);
		} else if (selectedDate && selectedTime) {
			const data = new Date();

			if (data.getFullYear() == selectedDate.getFullYear()) {
				if (data.getMonth() >= selectedDate.getMonth()) {
					if (data.getDate() == selectedDate.getDate()) {
						if (data.getHours() == selectedTime.getHours()) {
							if (data.getMinutes() > selectedTime.getMinutes()) {
								setWrongTime(true);
								setMessageTime(i18n.get("wrongTimeSelect"));
								return;
							}
						} else if (data.getHours() > selectedTime.getHours()) {
							setWrongTime(true);
							setMessageTime(i18n.get("wrongHour"));
							return;
						}
					}
				}
			}
		}

		if (select != null) {
			setSuccess(true);

			if (params?.id_reminder) {
				await pet_reminder.updatePetReminder(params.id_reminder, {
					pet_id: select,
					text: title,
					description: desc,
					remember_when: DateTime.fromJSDate(
						new Date(
							selectedDate.getFullYear(),
							selectedDate.getMonth(),
							selectedDate.getDate(),
							selectedTime.getHours(),
							selectedTime.getMinutes()
						)
					)
						.setZone("utc")
						.toISO()!,
					updated_at: DateTime.fromJSDate(date).setZone("utc").toISO()!,
				});
			} else {
				await pet_reminder.createPetReminder({
					pet_id: select,
					text: title,
					description: desc,
					remember_when: DateTime.fromJSDate(
						new Date(
							selectedDate.getFullYear(),
							selectedDate.getMonth(),
							selectedDate.getDate(),
							selectedTime.getHours(),
							selectedTime.getMinutes()
						)
					)
						.setZone("utc")
						.toISO()!,
					created_at: DateTime.fromJSDate(date).setZone("utc").toISO()!,
					updated_at: DateTime.fromJSDate(date).setZone("utc").toISO()!,
				});
			}
		}
	}

	const onChangeDate = (event: any, selectedDate: any) => {
		const currentDate = selectedDate;
		setSelectedDate(currentDate);
	};

	const onChangeStartDate = (event: any, selectedStartDate: any) => {
		if (Platform.OS === "android" && event.type === "dismissed") return setPickingDate(false);

		if (selectedDate && medicine) {
			if (new Date(selectedStartDate) > new Date(medicine.medication_end)) {
				setMedicine({ ...medicine, medication_start: selectedStartDate, medication_end: selectedStartDate });
			} else {
				setMedicine({ ...medicine, medication_start: selectedStartDate });
			}
		}

		if (Platform.OS === "android") {
			setPickingDate(false);
		}
	};

	const onChangeEndDate = (event: any, selectedEndDate: any) => {
		if (Platform.OS === "android" && event.type === "dismissed") return setPickingDate(false);

		if (selectedDate && medicine) {
			setMedicine({
				...medicine,
				medication_end: selectedEndDate,
			});
		}

		if (Platform.OS === "android") {
			setPickingDate(false);
		}
	};

	const onChangeTime = (event: any, selectedTime: any) => {
		const currentTime = selectedTime;
		setSelectedTime(currentTime);
	};

	const showDatepicker = () => {
		DateTimePickerAndroid.open({
			value: selectedDate,
			onChange: onChangeDate,
			mode: "date",
			is24Hour: true,
			minimumDate: date,
		});
	};

	const showStartDatepicker = () => {
		DateTimePickerAndroid.open({
			value: new Date(medicine!.medication_start),
			onChange: onChangeStartDate,
			mode: "date",
			is24Hour: true,
			minimumDate: date,
		});
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

	const showTimepicker = () => {
		DateTimePickerAndroid.open({
			value: selectedTime,
			onChange: onChangeTime,
			mode: "time",
			is24Hour: true,
			minimumDate: date,
		});
	};

	useEffect(() => {
		if (success) {
			setTimeout(() => {
				setSuccess(false);
			}, 3000);

			setTimeout(() => {
				navigation.navigate("Reminders", {
					reload: Math.random(),
				});
			}, 2000);
		}
	}, [success]);

	const cancelRef = useRef(null);

	if (loading) {
		return (
			<ThemedView isRoot fadeIn>
				<View
					style={{
						flex: 1,
					}}
				>
					<ContentLoader
						viewBox={`0 0 ${Dimensions.get("window").width} ${Dimensions.get("window").height}`}
						backgroundColor={colors.loaderBackColor}
						foregroundColor={colors.loaderForeColor}
					>
						<Rect width={Dimensions.get("window").width * 0.85} height={55} x={35} y={60} rx={6} ry={6} />
						<Rect width={Dimensions.get("window").width * 0.85} height={100} x={35} y={180} rx={6} ry={6} />
						<Rect width={150} height={50} x={30} y={340} rx={11} ry={11} />
						<Rect width={150} height={50} x={30} y={430} rx={11} ry={11} />
						<Rect width={Dimensions.get("window").width * 0.85} height={55} x={33} y={530} rx={6} ry={6} />
						<Rect width={150} height={50} x={155} y={630} rx={11} ry={11} />
					</ContentLoader>
				</View>
			</ThemedView>
		);
	} else
		return (
			<ThemedView>
				{success && <SuccessModal />}
				{wrongTime && <WrongTime cancel={() => setWrongTime(false)} message={messageTime} />}

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
									<AlertDialog.Header>{""}</AlertDialog.Header>
								</>
							)}
							<AlertDialog.Body>
								<DateTimePicker
									value={selectedDate}
									onChange={(e, date: Date) => {
										if (date) setSelectedDate(date);

										onChangeDate(e, date);
										onChangeTime(e, date);
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

				{medicine && (
					<>
						<KeyboardAvoidingView behavior={Platform.OS === "ios" ? "padding" : "height"}>
							<AlertDialog
								isOpen={pickingStartDate}
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
						</KeyboardAvoidingView>

						<KeyboardAvoidingView behavior={Platform.OS === "ios" ? "padding" : "height"}>
							<AlertDialog
								isOpen={pickingEndDate}
								onClose={() => setPickingEndDate(false)}
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
													setMedicine({ ...medicine!, medication_end: date });
												}

												onChangeEndDate(e, date);
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
														setPickingEndDate(false);
													}}
													style={{ backgroundColor: colors.danger }}
													useDefaultStyle={true}
												>
													{i18n.get("cancel")}
												</PlatformButton>

												<PlatformButton
													onPress={() => setPickingEndDate(false)}
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
					</>
				)}

				<ScrollView style={{ width: "100%" }} showsVerticalScrollIndicator={false}>
					<View style={{ display: "flex", justifyContent: "flex-start", alignItems: "center", marginTop: 30 }}>
						<View style={{ gap: 5 }}>
							<Text style={{ color: colors.text }}>{i18n.get("addReminder.addTitle")}</Text>
							<Input
								isDisabled={params.isMedicine}
								variant="outline"
								w={"75%"}
								maxW="300"
								placeholder={i18n.get("addReminder.addTitleInput")}
								placeholderTextColor={"#b2b2b2"}
								value={title ?? ""}
								onChange={(text) => {
									setTitle(text.nativeEvent.text);
									if (invalidT === true) setInvalidT(false);
								}}
								borderColor={"#b2b2b2"}
								isInvalid={invalidT}
							/>
						</View>

						<View style={{ gap: 5, marginTop: 30 }}>
							<Text style={{ color: colors.text }}>{i18n.get("addReminder.addDescription")}</Text>
							<TextArea
								h={20}
								w="75%"
								maxW="300"
								isInvalid={invalidA}
								value={desc ?? ""}
								onChange={(text) => {
									setDesc(text.nativeEvent.text);
									if (invalidA === true) setInvalidA(false);
								}}
								placeholder={i18n.get("addReminder.addDescriptionInput")}
								placeholderTextColor={"#b2b2b2"}
								borderColor={"#b2b2b2"}
								autoCompleteType={undefined}
							/>
						</View>

						<View
							style={{
								gap: 20,
								marginTop: 30,
								width: "75%",
								display: "flex",
								alignItems: "flex-start",
								justifyContent: "flex-start",
							}}
						>
							{params.isMedicine ? (
								<View
									style={{
										display: "flex",
										flexDirection: "column",
										justifyContent: "center",
										alignItems: "center",
										width: "100%",
										gap: 20,
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
										<Text style={{ color: colors.text }}>{i18n.get("pets.profile.medicineStartTreatment")}</Text>
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
													// setShowIOSDate(true);
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
													// setShowIOSDate(true);
													setPickingDate(true);
												} else showEndDatepicker();
											}}
										>
											<Text style={{ color: colors.text }}>
												{new Date(medicine!.medication_end).toLocaleDateString(i18n.locale)}
											</Text>
										</TouchableOpacity>
									</View>
								</View>
							) : (
								<View
									style={{
										gap: 8,
										display: "flex",
										alignItems: "flex-start",
										justifyContent: "flex-start",
										width: "100%",
									}}
								>
									<Text style={{ color: colors.text }}>{i18n.get("addReminder.addDate")}</Text>
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
												// setShowIOSDate(true);
												setPickingDate(true);
											} else showDatepicker();
										}}
									>
										<Text style={{ color: colors.text }}>{selectedDate.toLocaleDateString(i18n.locale)}</Text>
									</TouchableOpacity>
								</View>
							)}

							{params.isMedicine ? (
								<></>
							) : (
								<View
									style={{
										gap: 8,
										display: "flex",
										alignItems: "flex-start",
										justifyContent: "flex-start",
										width: "100%",
									}}
								>
									<Text style={{ color: colors.text }}>{i18n.get("addReminder.addTime")}</Text>
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
												setPickingDate(true);
											} else showTimepicker();
										}}
									>
										<Text style={{ color: colors.text }}>{formatHoursAndMinutes(selectedTime)}</Text>
									</TouchableOpacity>
								</View>
							)}
						</View>
					</View>
					<View style={{ marginTop: 20, width: "100%", justifyContent: "center", alignItems: "center" }}>
						<WrappedSelect
							w="75%"
							minWidth="full"
							placeholder={i18n.get("addReminder.pet")}
							accessibilityLabel={i18n.get("addReminder.pet")}
							placeholderTextColor={"#b2b2b2"}
							selectedValue={select ?? ""}
							onValueChange={(item) => {
								setSelect(item);
								setInvalidS(false);
							}}
							borderColor={invalidS ? "#ef4444" : "#b2b2b2"}
						>
							{pets?.map((value) => {
								return <Select.Item key={value.id} label={value.name} value={value.id} />;
							})}
						</WrappedSelect>
					</View>

					<View
						style={{ marginTop: 20, width: "100%", height: 300, justifyContent: "flex-start", alignItems: "center" }}
					>
						<TouchableOpacity
							style={{
								backgroundColor: colors.primary,
								display: "flex",
								width: 100,
								marginTop: 20,
								flexDirection: "row",
								borderRadius: 15,
								padding: 10,
								gap: 5,
								justifyContent: "center",
								alignItems: "center",
							}}
							onPress={() => {
								if (params.isMedicine) {
									updateMedicine();
								} else {
									saveReminder();
								}
							}}
						>
							<Text style={{ color: "white" }}>{i18n.get("save")}</Text>
							<Ionicons name={"add-circle"} size={25} color={"white"} />
						</TouchableOpacity>
					</View>
				</ScrollView>
			</ThemedView>
		);
}
