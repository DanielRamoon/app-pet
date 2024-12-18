import LoadingModal from "@components/Modals/LoadingModal";
import QuestionModal from "@components/Modals/QuestionModal";
import SuccessModal from "@components/Modals/SuccessModal";
import Medicine from "@components/Pets/Medicine";
import Input from "@components/Wrappers/Input";
import ThemedView from "@components/utils/ThemedView";
import { Octicons } from "@expo/vector-icons";
import DateTimePicker, { DateTimePickerAndroid } from "@react-native-community/datetimepicker";
import { DateTime } from "luxon";
import useColors from "@hooks/useColors";
import ConfirmDel from "@components/Modals/ConfirmDelReminder";
import { useRoute } from "@react-navigation/native";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import { FlashList } from "@shopify/flash-list";
import i18n from "@utils/i18n";
import petsHealthMedicinesService, {
	IPetHealthMedicines,
	eMedicineType,
} from "@utils/supabase/services/pets/pets-health-medicines.service";
import petsHealthService, { IPetHealth } from "@utils/supabase/services/pets/pets-health.service";
import { IPet } from "@utils/supabase/services/pets/pets.service";
import { AlertDialog, Box, Button, Fab, KeyboardAvoidingView } from "native-base";
import React, { useEffect, useRef, useState } from "react";
import {
	Alert,
	Keyboard,
	RefreshControl,
	StyleSheet,
	View,
	Text,
	Image,
	Dimensions,
	Platform,
	TouchableOpacity,
} from "react-native";
import { IServiceResponse } from "types/general";
import pet_reminder from "@utils/supabase/services/pets/pet_reminder";
import ContentLoader, { Rect } from "react-content-loader/native";
import PlatformButton from "@components/Wrappers/PlatformButton";

interface newMedicineItens {
	id?: string;
	description: string;
	dose: string;
	amount: string;
	medication_start: Date;
	medication_end: Date;
}

interface IPetHealthMedicinesModificate extends IPetHealthMedicines {
	haveReminder: boolean;
}

export default function ({ navigation }: NativeStackScreenProps<any, "MainTabs">) {
	const colors = useColors();
	const route = useRoute();
	const cancelRef = useRef(null);

	const params = route.params as {
		pet: IPet;
		health: string;
	};

	const [petHealth, setPetHealth] = useState<IPetHealth & { medicines: IPetHealthMedicines[] }>();

	const [firstLoad, setFirstLoad] = useState<boolean>(true);
	const [loading, setLoading] = useState<boolean>(false);
	const [refreshing, setRefreshing] = useState<boolean>(false);
	const [success, setSuccess] = useState<boolean>(false);
	const [alertMedicine, setAlertMedicine] = useState<boolean>(false);
	const [pickingDate, setPickingDate] = useState<boolean>(false);
	const [nameAlert, setNameAlert] = useState(false);
	const [sameName, setSameName] = useState<boolean>();
	const [addingNew, setAddingNew] = useState<boolean>(false);

	const [modePicker, setModePicker] = useState<"start" | "end">("start");

	const [newMedicine, setNewMedicine] = useState<newMedicineItens>({
		description: "",
		amount: "",
		dose: "",
		medication_start: new Date(),
		medication_end: new Date(),
	});
	const [medicines, setMedicines] = useState<IPetHealthMedicinesModificate[]>([]);

	const [keyboardVisible, setKeyboardVisible] = useState<boolean>(false);

	async function startup(refresh?: boolean) {
		if (refresh) setRefreshing(true);
		else setFirstLoad(true);

		const petHealth = (await petsHealthService.getPetHealthDetails(
			params.pet.id,
			eMedicineType.MEDICINE
		)) as IServiceResponse<
			IPetHealth & {
				medicines: IPetHealthMedicines[];
			}
		>;

		if (petHealth.data?.medicines) {
			const modifiedMedicines = await Promise.all(
				petHealth.data.medicines.map(async (medicine) => {
					const resultR = await pet_reminder.getPetReminderByMedicineId(medicine.id);
					if (resultR.status === 500) {
						return {
							...medicine,
							haveReminder: false,
						};
					} else {
						return {
							...medicine,
							haveReminder: true,
						};
					}
				})
			);
			setMedicines(modifiedMedicines);
		}

		setPetHealth(petHealth.data);
		if (refresh) setRefreshing(false);
	}

	useEffect(() => {
		startup().finally(() => setTimeout(() => setFirstLoad(false), 200));

		const keyboardDidShowListener = Keyboard.addListener("keyboardDidShow", () => setKeyboardVisible(true));
		const keyboardDidHideListener = Keyboard.addListener("keyboardDidHide", () => setKeyboardVisible(false));

		return () => {
			keyboardDidHideListener.remove();
			keyboardDidShowListener.remove();
		};
	}, [refreshing, loading]);

	const addNewMedicine = async (name: string | undefined) => {
		if (!name) {
			setAlertMedicine(false);
			setNameAlert(true);
			return;
		}
		// else if (
		// 	isNaN(Number(newMedicine.dose.replace(",", "."))) ||
		// 	isNaN(Number(newMedicine.amount.replace(",", ".")))
		// ) {
		// 	setAlertMedicine(true);
		// 	setNameAlert(true);
		// 	return;
		// }

		const consultN = await petsHealthMedicinesService.getPetHealthMedicines(newMedicine.description, params.health);

		if (consultN.data!.length > 0) {
			setSameName(true);
			return;
		}

		setAddingNew(false);
		setLoading(true);

		const result = await petsHealthMedicinesService.createPetHealthMedicines({
			description: name,
			dose: newMedicine.dose.replace(",", "."),
			amount: newMedicine.amount.replace(",", "."),
			health_id: petHealth?.id!,
			type: eMedicineType.MEDICINE,
			medication_start: newMedicine.medication_start,
			medication_end: newMedicine.medication_end,
		} as IPetHealthMedicines);

		if (result.status === 201 || result.status === 200) {
			if (Number(newMedicine.amount) != 0) {
				await pet_reminder.createPetReminder({
					pet_id: params.pet.id,
					medicine_id: result.data?.id!,
					text: name,
					description:
						i18n.get("addReminder.addMedicineReminder") +
						newMedicine.description +
						", " +
						i18n.get("addReminder.medicineDoseReminder") +
						newMedicine.dose,
					remember_when: DateTime.fromJSDate(newMedicine.medication_start).setZone("utc").toISO()!,
					remember_again_in: newMedicine.amount ? `${newMedicine.amount.replace(",", ".")}H` : null,
					created_at: DateTime.fromJSDate(new Date()).setZone("utc").toISO()!,
					updated_at: DateTime.fromJSDate(new Date()).setZone("utc").toISO()!,
				});
			}

			setAlertMedicine(false);
			setSuccess(true);
			setNewMedicine({
				description: "",
				amount: "",
				dose: "",
				id: "",
				medication_start: new Date(),
				medication_end: new Date(),
			});
			startup(true);
			setTimeout(() => setSuccess(false), 2000);

			//
		} else {
			Alert.alert(i18n.get("error"), i18n.get("pets.errors.addMedicineError"));
			setAddingNew(true);
		}

		setLoading(false);
	};

	const onChangeStartDate = (event: any, selectedDate: any) => {
		if (Platform.OS === "android" && event.type === "dismissed") return setPickingDate(false);

		if (selectedDate) {
			if (selectedDate > newMedicine.medication_end) {
				setNewMedicine({ ...newMedicine, medication_start: selectedDate, medication_end: selectedDate });
			} else {
				setNewMedicine({ ...newMedicine, medication_start: selectedDate });
			}
		}

		if (Platform.OS === "android") {
			setPickingDate(false);
		}
	};

	const showStartDatepicker = () => {
		DateTimePickerAndroid.open({
			value: newMedicine.medication_start,
			onChange: onChangeStartDate,
			mode: "date",
			is24Hour: true,
			minimumDate: new Date(),
		});
	};

	const onChangeEndDate = (event: any, selectedDate: any) => {
		if (Platform.OS === "android" && event.type === "dismissed") return setPickingDate(false);

		if (selectedDate) setNewMedicine({ ...newMedicine, medication_end: selectedDate });

		if (Platform.OS === "android") {
			setPickingDate(false);
		}
	};

	const showEndDatepicker = () => {
		DateTimePickerAndroid.open({
			value: newMedicine.medication_end,
			onChange: onChangeEndDate,
			mode: "date",
			is24Hour: true,
			minimumDate: newMedicine.medication_start,
		});
	};

	const renderItem = ({ item, index }: { item: IPetHealthMedicinesModificate; index: number }) => {
		const isLastItem = index === medicines.length - 1;

		return (
			<Medicine
				medicine={item}
				key={index}
				onUpdate={() => startup(true)}
				isLastItem={isLastItem}
				petId={params.pet.id}
			/>
		);
	};

	if (firstLoad) {
		return (
			<ThemedView absolute>
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
						<Rect width={Dimensions.get("window").width} height={140} x={0} y={30} rx={10} ry={10} />
					</ContentLoader>
				</View>
			</ThemedView>
		);
	}

	return (
		<ThemedView isRoot fadeIn>
			{loading && <LoadingModal />}
			{success && <SuccessModal />}
			{sameName && (
				<ConfirmDel message={i18n.get("pets.medicine.medicineSameName")} cancel={() => setSameName(false)} />
			)}
			{nameAlert && (
				<ConfirmDel
					message={
						alertMedicine ? i18n.get("pets.medicine.medicineDoseAmount") : i18n.get("pets.medicine.medicineName")
					}
					cancel={() => setNameAlert(false)}
				/>
			)}

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
								value={modePicker === "start" ? newMedicine.medication_start : newMedicine.medication_end}
								onChange={(e, date: Date) => {
									if (date) {
										if (modePicker === "start") {
											setNewMedicine({ ...newMedicine, medication_start: date });
										} else {
											setNewMedicine({ ...newMedicine, medication_end: date });
										}
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

			{addingNew && (
				<KeyboardAvoidingView behavior={Platform.OS === "ios" ? "padding" : "height"}>
					<QuestionModal
						title={i18n.get("pets.profile.addMedicine")}
						confirm={() => addNewMedicine(newMedicine.description)}
						cancel={() => {
							setAddingNew(false);
							setNewMedicine({
								description: "",
								amount: "",
								dose: "",
								id: "",
								medication_start: new Date(),
								medication_end: new Date(),
							});
						}}
						customBody={
							<View
								style={{
									gap: 20,
									marginTop: 30,
									marginBottom: 30,
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
										value={newMedicine.description}
										onChangeText={(value) => setNewMedicine({ ...newMedicine, description: value })}
										label={i18n.get("pets.profile.medicineName")}
										labelProps={{ color: colors.text }}
									/>
									<Input
										value={newMedicine.dose}
										onChangeText={(value) => setNewMedicine({ ...newMedicine, dose: value })}
										label={i18n.get("pets.profile.medicineDose")}
										labelProps={{ color: colors.text }}
									/>
									<Input
										value={newMedicine.amount}
										onChangeText={(value) => setNewMedicine({ ...newMedicine, amount: value })}
										label={i18n.get("pets.profile.medicineAmount")}
										labelProps={{ color: colors.text }}
									/>
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
												setModePicker("start");
												setPickingDate(true);
											} else showStartDatepicker();
										}}
									>
										<Text style={{ color: colors.text }}>
											{newMedicine.medication_start.toLocaleDateString(i18n.locale)}
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
											{newMedicine.medication_end.toLocaleDateString(i18n.locale)}
										</Text>
									</TouchableOpacity>
								</View>
							</View>
						}
						avoidKeyboard
					/>
				</KeyboardAvoidingView>
			)}

			<FlashList
				refreshControl={
					<RefreshControl
						refreshing={refreshing}
						onRefresh={() => startup(true).then(() => setRefreshing(false))}
						tintColor={colors.primary}
						colors={[colors.white]}
						progressBackgroundColor={colors.lightGreen}
					/>
				}
				contentContainerStyle={{ paddingTop: 10 }}
				showsVerticalScrollIndicator={false}
				alwaysBounceVertical={true}
				data={medicines}
				renderItem={renderItem}
				ListFooterComponent={
					medicines.length === 0 ? (
						<View
							style={{
								width: "100%",
								display: "flex",
								alignItems: "center",
								justifyContent: "center",
								gap: 10,
								flexDirection: "column",
							}}
						>
							<Image
								style={{
									width: 180,
									height: 170,
									marginTop: "auto",
								}}
								source={require("@assets/icons/medicine.png")}
							/>
							<Text style={{ color: colors.text, textAlign: "center", width: "100%" }}>{i18n.get("nothingToSee")}</Text>
						</View>
					) : (
						<></>
					)
				}
				estimatedItemSize={200}
				// extraData={selectedPets}
			/>

			{!keyboardVisible && (
				<Fab
					onPressOut={() => setAddingNew(true)}
					bgColor={colors.primary}
					position="absolute"
					bottom="85px"
					android_ripple={{ color: colors.background }}
					_ios={{ _pressed: { backgroundColor: colors.active } }}
					style={{ paddingLeft: 16, paddingRight: 16, paddingTop: 12, paddingBottom: 12 }}
					renderInPortal={false}
					shadow={2}
					size="xs"
					icon={<Octicons name="plus" size={24} color="white" />}
				/>
			)}
		</ThemedView>
	);
}

const styles = StyleSheet.create({});
