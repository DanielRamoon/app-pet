import { Fontisto, Octicons, FontAwesome5 } from "@expo/vector-icons";
import useAppTheme from "@hooks/useAppTheme";
import useColors from "@hooks/useColors";
import i18n from "@utils/i18n";
import petsHealthVaccinesService, {
	IPetHealthVaccines,
	IPetHealthVaccinesDoses,
} from "@utils/supabase/services/pets/pets-health-vaccines.service";
import { AlertDialog, Box, Button, KeyboardAvoidingView, ScrollView, Text } from "native-base";
import React, { useEffect, useRef, useState } from "react";
import { Platform, StyleSheet, TouchableOpacity, View, Alert } from "react-native";
import DateTimePicker, { DateTimePickerAndroid } from "@react-native-community/datetimepicker";
import PlatformButton from "@components/Wrappers/PlatformButton";
import LoadingModal from "@components/Modals/LoadingModal";
import SuccessModal from "@components/Modals/SuccessModal";
import WrongTime from "@components/Modals/WrongTime";
import pet_reminder from "@utils/supabase/services/pets/pet_reminder";
import ConfirmDel from "@components/Modals/ConfirmDelReminder";
import { DateTime } from "luxon";
import QuestionModal from "@components/Modals/QuestionModal";

type IProps = {
	vaccine: IPetHealthVaccines & { doses: IPetHealthVaccinesDoses[] };
	petID: string;
	isLastItem: boolean;
	onUpdate: () => void;
};

export default function Vaccine(props: IProps) {
	const colors = useColors();
	const [theme] = useAppTheme();

	const [dosesOrdered, setDosesOrdered] = useState<IPetHealthVaccinesDoses[]>([]);

	const [pickingDate, setPickingDate] = useState<boolean>(false);
	const [changingVaccineName, setChangingVaccineName] = useState<boolean>(false);

	const [newDose, setNewDose] = useState<Date>(new Date());
	const [newTimeDose, setNewTimeDose] = useState<Date>(new Date());
	const [success, setSuccess] = useState<boolean>(false);
	const [addDateModal, setAddDateModal] = useState<boolean>(false);
	const [loading, setLoading] = useState<boolean>(false);
	const [wrongTime, setWrongTime] = useState<boolean>(false);
	const [messageTime, setMessageTime] = useState<string>("");
	const [modePicker, setModePicker] = useState<any>("");
	const [deleting, setDeleting] = useState<boolean>(false);
	const [deletingDose, setDeletingDose] = useState<number>(-1);

	const [alertErrorDuplicate, setAlertErrorDuplicate] = useState<boolean>(false);
	const [alertError, setAlertError] = useState<boolean>(false);

	useEffect(() => {
		setDosesOrdered([...props.vaccine.doses].sort(orderByDate));
	}, [props]);

	async function addDose(date?: Date) {
		setLoading(true);

		const result = await petsHealthVaccinesService.createVaccineDose(props.vaccine.id, {
			dose: props.vaccine.doses.length + 1,
			injection_date: date?.toISOString() ?? newDose.toISOString(),
		} as Partial<IPetHealthVaccinesDoses>);

		setLoading(false);
		if (result.status === 201 || result.status === 200) {
			setSuccess(true);
			setPickingDate(false);
			setNewDose(new Date());
			setTimeout(() => setSuccess(false), 2000);

			props.onUpdate();
		} else {
			if (result.trace!.error.message.includes("duplicate")) setAlertErrorDuplicate(true);
			else setAlertError(true);

			setPickingDate(false);
		}
	}

	async function deleteDose() {
		const dose = dosesOrdered[deletingDose];
		setLoading(true);

		const result = await petsHealthVaccinesService.deleteVaccineDose({ doseId: dose.id, date: dose.injection_date! });
		setLoading(false);
		if (result.status === 200) {
			setSuccess(true);
			setDeletingDose(-1);
			setTimeout(() => setSuccess(false), 2000);

			props.onUpdate();
		} else {
			Alert.alert(i18n.get("error"), i18n.get("pets.errors.deleteDoseError"));
		}
	}

	async function deleteVaccine() {
		setDeleting(false);
		setLoading(true);

		const result = await petsHealthVaccinesService.deleteVaccine(props.vaccine.id);

		setLoading(false);
		if (result.status === 200) {
			setSuccess(true);
			setTimeout(() => setSuccess(false), 2000);

			props.onUpdate();
		} else {
			console.log(result);
			Alert.alert(i18n.get("error"), i18n.get("pets.errors.deleteVaccineError"));
		}
	}

	function formatHoursAndMinutes(date_: Date) {
		const date = DateTime.fromJSDate(date_).setZone("local").toJSDate();

		const options = { hour: "2-digit", minute: "2-digit" } as const;
		return date.toLocaleTimeString(i18n.locale, options);
	}

	async function changeVaccineName(newName: string) {
		if (!newName) {
			Alert.alert(i18n.get("error"), i18n.get("pets.errors.emptyVaccineName"));
			return;
		}

		setChangingVaccineName(false);
		setLoading(true);

		const result = await petsHealthVaccinesService.updateVaccine(props.vaccine.id, { description: newName });

		setLoading(false);
		if (result.status === 200) {
			setSuccess(true);
			setTimeout(() => setSuccess(false), 2000);

			props.onUpdate();
		} else {
			Alert.alert(i18n.get("error"), i18n.get("pets.errors.changeVaccineNameError"));
		}
	}

	async function addNewReminder() {
		if (Platform.OS === "android") {
			setPickingDate(false);
			if (newDose) addDose(newDose);
		}

		if (newDose && newTimeDose) {
			setSuccess(true);
			setTimeout(() => setSuccess(false), 2000);

			await pet_reminder.createPetReminder({
				pet_id: props.petID,
				text: props.vaccine.description,
				description: i18n.get("note.vaccine"),
				remember_when: DateTime.fromJSDate(
					new Date(
						newDose.getFullYear(),
						newDose.getMonth(),
						newDose.getDate(),
						newTimeDose.getHours(),
						newTimeDose.getMinutes()
					)
				)
					.setZone("utc")
					.toISO()!,
				created_at: DateTime.fromJSDate(new Date()).setZone("utc").toISO()!,
				updated_at: DateTime.fromJSDate(new Date()).setZone("utc").toISO()!,
			});
		}
	}

	function formatDate(date: string) {
		const formated = DateTime.fromISO(date).toFormat("dd/LL/yyyy");

		const [day, month, year] = formated.split("/");
		return `${day}/${month}\n${year}`;
	}

	function orderByDate(a: IPetHealthVaccinesDoses, b: IPetHealthVaccinesDoses) {
		return DateTime.fromISO(b.injection_date!).diff(DateTime.fromISO(a.injection_date!)).milliseconds;
	}

	const onChangeDate = (event: any, selectedDate: any) => {
		if (Platform.OS === "android" && event.type === "dismissed") return setPickingDate(false);

		if (selectedDate) setNewDose(selectedDate);

		if (Platform.OS === "android") {
			setPickingDate(false);
		}
	};

	const onChangeTime = (event: any, selectedTime: any) => {
		if (Platform.OS === "android" && event.type === "dismissed") return setPickingDate(false);

		if (selectedTime) setNewTimeDose(selectedTime);

		if (Platform.OS === "android") {
			setPickingDate(false);
		}
	};

	const showDatepicker = () => {
		DateTimePickerAndroid.open({
			value: newDose,
			onChange: onChangeDate,
			mode: "date",
			is24Hour: true,
			minimumDate: new Date(),
		});
	};

	const showTimepicker = () => {
		DateTimePickerAndroid.open({
			value: newTimeDose,
			onChange: onChangeTime,
			mode: "time",
			is24Hour: true,
			minimumDate: new Date(),
		});
	};

	const cancelRef = useRef(null);

	return (
		<>
			{loading && <LoadingModal />}
			{success && <SuccessModal />}
			{wrongTime && <WrongTime cancel={() => setWrongTime(false)} message={messageTime} />}
			{(alertErrorDuplicate || alertError) && (
				<ConfirmDel
					cancel={() => setAlertErrorDuplicate(false)}
					message={alertError ? i18n.get("pets.errors.addDoseError") : i18n.get("pets.errors.duplicateDoseError")}
				/>
			)}
			{changingVaccineName && (
				<QuestionModal
					title={i18n.get("pets.vaccine.changeName")}
					inputMessage={i18n.get("pets.questions.vaccineName")}
					confirm={changeVaccineName}
					cancel={() => setChangingVaccineName(false)}
				/>
			)}
			{addDateModal && (
				<QuestionModal
					title={i18n.get("pets.vaccine.addVaccineDate")}
					confirm={() => {
						const data = new Date();

						if (data.getFullYear() == newDose.getFullYear()) {
							if (data.getMonth() >= newDose.getMonth()) {
								if (data.getDate() == newDose.getDate()) {
									if (data.getHours() == newTimeDose.getHours()) {
										if (data.getMinutes() + 15 > newTimeDose.getMinutes()) {
											setWrongTime(true);
											setMessageTime(i18n.get("wrongTimeSelect"));
											return;
										}
									} else if (data.getHours() > newTimeDose.getHours()) {
										setWrongTime(true);
										setMessageTime(i18n.get("wrongHour"));
										return;
									}
								}
							}
						}
						setAddDateModal(false);
						addNewReminder();
					}}
					cancel={() => setAddDateModal(false)}
					customBody={
						<View
							style={{
								gap: 20,
								marginTop: 30,
								marginBottom: 30,
								width: "75%",
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
											setModePicker("date");
											setPickingDate(true);
										} else showDatepicker();
									}}
								>
									<Text style={{ color: colors.text }}>{newDose.toLocaleDateString(i18n.locale)}</Text>
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
											setModePicker("time");
											setPickingDate(true);
										} else showTimepicker();
									}}
								>
									<Text style={{ color: colors.text }}>{formatHoursAndMinutes(newTimeDose)}</Text>
								</TouchableOpacity>
							</View>
						</View>
					}
				/>
			)}
			{deleting && (
				<ConfirmDel
					message={i18n.get("pets.vaccine.deleteMessage")}
					confirm={deleteVaccine}
					cancel={() => setDeleting(false)}
				/>
			)}
			{deletingDose > -1 && (
				<ConfirmDel
					message={i18n.get("pets.vaccine.deleteDoseMessage")}
					confirm={deleteDose}
					cancel={() => setDeletingDose(-1)}
				/>
			)}

			<KeyboardAvoidingView behavior={Platform.OS === "ios" ? "padding" : "height"}>
				<AlertDialog
					isOpen={pickingDate}
					onClose={() => setPickingDate(false)}
					leastDestructiveRef={cancelRef}
					closeOnOverlayClick={true}
					overlayVisible={Platform.OS === "ios"}
					safeArea={true}
					avoidKeyboard={true}
					style={Platform.OS === "android" ? { display: "none", paddingBottom: 100 } : { paddingBottom: 100 }}
				>
					<AlertDialog.Content>
						{Platform.OS === "ios" && (
							<>
								<AlertDialog.CloseButton />
								<AlertDialog.Header>{i18n.get("pets.profile.addDose")}</AlertDialog.Header>
							</>
						)}
						<AlertDialog.Body>
							<DateTimePicker
								accentColor={colors.primary}
								value={newDose}
								mode={modePicker}
								style={{ width: "100%" }}
								onChange={(e, date: Date) => {
									if (Platform.OS === "android" && e.type === "dismissed") return setPickingDate(false);

									if (date) setNewDose(date);

									if (Platform.OS === "android") {
										setPickingDate(false);
										if (date) addDose(date);
									}
								}}
								themeVariant={theme as any}
							/>
						</AlertDialog.Body>
						{Platform.OS === "ios" && (
							<AlertDialog.Footer>
								<Button.Group space={2}>
									<PlatformButton
										onPress={() => setPickingDate(false)}
										style={{ backgroundColor: colors.danger }}
										useDefaultStyle={true}
									>
										{i18n.get("cancel")}
									</PlatformButton>

									<PlatformButton
										onPress={() => addDose()}
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

			<Box
				mt={3}
				mb={3}
				bg={colors.cardColor}
				style={{
					width: "100%",
					flex: 1,
					marginBottom: props.isLastItem ? 300 : 0,
					flexDirection: "row",
					borderRadius: 12,
				}}
				rounded="5"
			>
				<View style={{ display: "flex", flexDirection: "column" }}>
					<View
						style={{
							display: "flex",
							flexDirection: "row",
							width: "100%",
							paddingLeft: 10,
							paddingTop: 10,
							alignItems: "center",
							justifyContent: "center",
							paddingHorizontal: 10,
						}}
					>
						<Fontisto
							style={{ textAlign: "center", marginTop: "auto", marginBottom: "auto", paddingRight: 5, paddingLeft: 10 }}
							name="injection-syringe"
							size={22}
							color={colors.text}
						/>
						<Text
							onPress={() => setChangingVaccineName(true)}
							style={{ marginVertical: 5, marginLeft: 10, width: "65%" }}
							color={colors.text}
							fontWeight="medium"
							fontSize="xl"
							numberOfLines={1}
							ellipsizeMode="tail"
						>
							{props.vaccine.description}
						</Text>

						<TouchableOpacity
							onPress={() => setDeleting(true)}
							style={{
								marginLeft: "auto",
								marginRight: 10,
								marginTop: 10,
								backgroundColor: "#cc342c",
								display: "flex",
								justifyContent: "center",
								alignItems: "center",
								width: 40,
								height: 40,
								borderRadius: 8,
							}}
						>
							<FontAwesome5 name="trash" color={"white"} size={20} />
						</TouchableOpacity>
					</View>

					<Text
						color={colors.text}
						fontWeight="medium"
						fontSize="md"
						numberOfLines={1}
						lineHeight={27}
						ellipsizeMode="tail"
						ml={15}
						mt={5}
					>
						{i18n.get("pets.vaccine.dose")}
					</Text>
					<ScrollView horizontal={true} showsHorizontalScrollIndicator={false} style={{ marginBottom: 10 }}>
						<TouchableOpacity
							onPress={() => setAddDateModal(true)}
							style={{ ...styles.vaccineDose, paddingHorizontal: 20, marginLeft: 10 }}
						>
							<Octicons name="plus" size={24} color={colors.primary} />
						</TouchableOpacity>

						{dosesOrdered.map((vaccine: Partial<IPetHealthVaccinesDoses>, index) => (
							<TouchableOpacity
								key={index}
								onPress={() => setDeletingDose(index)}
								style={{
									backgroundColor: colors.primary,
									marginRight: 12,
									borderRadius: 15,
									display: "flex",
									justifyContent: "center",
									alignItems: "center",
								}}
							>
								<Text color={colors.text} style={styles.vaccineDose}>
									{formatDate(vaccine?.injection_date!)}
								</Text>
							</TouchableOpacity>
						))}
					</ScrollView>
				</View>
			</Box>
		</>
	);
}

const styles = StyleSheet.create({
	vaccineDose: {
		paddingVertical: 10,
		paddingHorizontal: 10,
		borderRadius: 5,
		textAlign: "center",
		marginRight: 5,
		marginLeft: 5,
		color: "white",
	},
});
