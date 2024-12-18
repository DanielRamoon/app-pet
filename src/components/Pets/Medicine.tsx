import ConfirmDel from "@components/Modals/ConfirmDelReminder";
import LoadingModal from "@components/Modals/LoadingModal";
import QuestionModal from "@components/Modals/QuestionModal";
import SuccessModal from "@components/Modals/SuccessModal";
import { FontAwesome5, Fontisto, MaterialCommunityIcons, Octicons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import i18n from "@utils/i18n";
import { navigate } from "@utils/navigator";
import pet_reminder from "@utils/supabase/services/pets/pet_reminder";
import petsHealthMedicinesService, {
	IPetHealthMedicines,
} from "@utils/supabase/services/pets/pets-health-medicines.service";
import { DateTime } from "luxon";
import { Box, Text } from "native-base";
import React, { useEffect, useState } from "react";
import ContentLoader, { Rect } from "react-content-loader/native";
import { Alert, StyleSheet, TouchableOpacity, View } from "react-native";

interface IPetHealthMedicinesModificate extends IPetHealthMedicines {
	haveReminder: boolean;
}

type IProps = {
	medicine: IPetHealthMedicinesModificate;
	petId: string;
	isProduct?: boolean;
	isLastItem: boolean;
	onUpdate: () => void;
};

export default function Medicine(props: IProps) {
	const colors = useColors();

	const [changingMedicineName, setChangingMedicineName] = useState(false);

	const [deleting, setDeleting] = useState<boolean>(false);
	const [success, setSuccess] = useState<boolean>(false);
	const [loading, setLoading] = useState<boolean>(false);
	const [haveReminder, setHaveReminder] = useState<boolean>(props.medicine.haveReminder);
	const [loadingData, setLoadingData] = useState<boolean>(true);

	async function changeMedicineName(newName: string) {
		if (!newName) {
			Alert.alert(i18n.get("error"), i18n.get(`pets.errors.${props.isProduct ? "product" : "medicine"}NameEmpty}`));
			return;
		}

		setChangingMedicineName(false);
		setLoading(true);

		const result = await petsHealthMedicinesService.updatePetHealthMedicines(props.medicine?.id!, {
			description: newName,
		});

		const resultR = await pet_reminder.getPetReminderByMedicineId(props.medicine.id);

		if (resultR.status === 200) await pet_reminder.updatePetReminderName(props.medicine?.id, newName);

		setLoading(false);
		if (result.status === 200) {
			setSuccess(true);
			setTimeout(() => setSuccess(false), 2000);

			props.onUpdate();
		} else {
			Alert.alert(
				i18n.get("error"),
				i18n.get(`pets.errors.change${props.isProduct ? "Product" : "Medicine"}NameError`)
			);
		}
	}

	async function deleteMedicine() {
		setDeleting(false);
		setLoading(true);

		const result = await petsHealthMedicinesService.deletePetHealthMedicines(props.medicine?.id!);

		setLoading(false);

		if (result.status === 200) {
			setSuccess(true);
			setTimeout(() => setSuccess(false), 2000);

			props.onUpdate();
		} else {
			Alert.alert(i18n.get("error"), i18n.get(`pets.errors.delete${props.isProduct ? "Product" : "Medicine"}Error`));
		}
	}

	return (
		<>
			{loading && <LoadingModal />}
			{success && <SuccessModal />}
			{changingMedicineName && (
				<QuestionModal
					title={i18n.get("pets.vaccine.changeName")}
					inputMessage={i18n.get(`pets.questions.${props.isProduct ? "productName" : "medicineName"}`)}
					confirm={changeMedicineName}
					cancel={() => setChangingMedicineName(false)}
				/>
			)}
			{deleting && (
				<ConfirmDel
					message={i18n.get("pets.product.deleteMessage")}
					confirm={deleteMedicine}
					cancel={() => setDeleting(false)}
				/>
			)}

			<View
				style={{
					width: "100%",
					marginBottom: props.isLastItem ? 300 : 20,
					flex: 1,
					flexDirection: "row",
					padding: 10,
					borderRadius: 12,
					backgroundColor: colors.cardColor,
					marginTop: 10,
				}}
			>
				<TouchableOpacity
					style={{ display: "flex", flexDirection: "column", padding: 10 }}
					onPress={async () => {
						if (!props.isProduct) {
							if (!haveReminder) {
								setLoading(true);
								await pet_reminder.createPetReminder({
									pet_id: props.petId,
									medicine_id: props.medicine.id,
									text: props.medicine.description,
									description:
										i18n.get("addReminder.addMedicineReminder") +
										props.medicine.description +
										", " +
										i18n.get("addReminder.medicineDoseReminder") +
										props.medicine.dose,
									remember_when: DateTime.fromJSDate(
										new Date(
											new Date().getFullYear(),
											new Date().getMonth(),
											new Date().getDate(),
											new Date().getHours(),
											new Date().getMinutes() + 30
										)
									)
										.setZone("utc")
										.toISO()!,
									remember_again_in: props.medicine.amount ? `${props.medicine.amount}H` : null,
									created_at: DateTime.fromJSDate(new Date()).setZone("utc").toISO()!,
									updated_at: DateTime.fromJSDate(new Date()).setZone("utc").toISO()!,
								});
								setHaveReminder(true);
								setLoading(false);
							}
						}
					}}
				>
					{props.isProduct ? (
						<></>
					) : (
						<View
							style={{
								display: "flex",
								flexDirection: "row",
								justifyContent: "flex-end",
								alignItems: "flex-end",
								gap: 20,
								width: "100%",
							}}
						>
							<TouchableOpacity
								onPress={() => setDeleting(true)}
								style={{
									backgroundColor: colors.danger,
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

							<TouchableOpacity
								onPress={() => navigate("EditMedicine", { id: props.medicine.id })}
								style={{
									backgroundColor: colors.darkBlue,
									display: "flex",
									justifyContent: "center",
									alignItems: "center",
									width: 40,
									height: 40,
									borderRadius: 8,
								}}
							>
								<MaterialCommunityIcons name="pencil" color={"white"} size={20} />
							</TouchableOpacity>
						</View>
					)}
					{loading ? (
						<View style={{ width: 150, borderRadius: 15, height: 20, position: "absolute" }}>
							<ContentLoader
								viewBox={`0 0 140 20`}
								foregroundColor={colors.loaderForeColor}
								backgroundColor={colors.loaderBackColor}
							>
								<Rect width={140} height={20} x={0} y={0} rx={10} ry={10} />
							</ContentLoader>
						</View>
					) : props.isProduct ? (
						<></>
					) : !haveReminder ? (
						<View
							style={{
								backgroundColor: colors.danger,
								width: 150,
								borderRadius: 10,
								position: "absolute",
								marginTop: 5,
								marginLeft: 5,
							}}
						>
							<Text style={{ color: "white", textAlign: "center", fontSize: 12 }}>{i18n.get("withOutReminder")}</Text>
						</View>
					) : (
						<View
							style={{
								backgroundColor: colors.primary,
								width: 150,
								borderRadius: 10,
								position: "absolute",
								marginTop: 5,
								marginLeft: 5,
							}}
						>
							<Text style={{ color: "white", textAlign: "center", fontSize: 12 }}>{i18n.get("withReminder")}</Text>
						</View>
					)}
					{props.isProduct ? (
						<View
							style={{
								display: "flex",
								flexDirection: "row",
								width: "100%",
								height: "100%",
								alignItems: "center",
								justifyContent: "space-around",
							}}
						>
							<View style={{ display: "flex", flexDirection: "row", gap: 10 }}>
								<FontAwesome5
									style={{ textAlign: "center", marginTop: "auto", marginBottom: "auto", paddingRight: 5 }}
									name={props.isProduct ? "shopping-bag" : "pump-medical"}
									size={20}
									color={colors.text}
								/>
								<Text
									onPress={() => setChangingMedicineName(true)}
									style={{ marginVertical: 5, marginLeft: 10, width: "65%" }}
									color={colors.text}
									fontWeight="medium"
									fontSize="lg"
									numberOfLines={1}
									ellipsizeMode="tail"
								>
									{props.medicine.description}
								</Text>
							</View>

							<TouchableOpacity
								onPress={() => setDeleting(true)}
								style={{
									backgroundColor: colors.danger,
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
					) : (
						<View
							style={{
								display: "flex",
								flexDirection: "row",
								width: "100%",
								alignItems: "center",
								justifyContent: "flex-start",
							}}
						>
							<FontAwesome5
								style={{ textAlign: "center", marginTop: "auto", marginBottom: "auto", paddingRight: 5 }}
								name={props.isProduct ? "shopping-bag" : "pump-medical"}
								size={20}
								color={colors.text}
							/>
							<Text
								onPress={() => setChangingMedicineName(true)}
								style={{ marginVertical: 5, marginLeft: 10, width: "65%" }}
								color={colors.text}
								fontWeight="medium"
								fontSize="lg"
								numberOfLines={1}
								ellipsizeMode="tail"
							>
								{props.medicine.description}
							</Text>
						</View>
					)}

					{!props.isProduct ? (
						<View style={{ display: "flex", flexDirection: "row" }}>
							<View
								style={{
									display: "flex",
									flexDirection: "column",
									width: "50%",
									justifyContent: "flex-start",
									alignItems: "flex-start",
								}}
							>
								<View style={styles.medicineValues}>
									<Text style={styles.medicineTitle}>{i18n.get("pets.profile.medicineDoseSmall")}:</Text>
									<Text>{props.medicine.dose}</Text>
								</View>
								<View style={styles.medicineValues}>
									<Text style={styles.medicineTitle}>{i18n.get("pets.profile.medicineAmountSmall")}:</Text>
									<Text>{props.medicine.amount}</Text>
								</View>
							</View>
							<View
								style={{
									display: "flex",
									flexDirection: "column",
									width: "50%",
									borderLeftWidth: 1,
									borderLeftColor: colors.text,
								}}
							>
								<View
									style={{
										...styles.medicineValues,

										width: "80%",
										marginLeft: 20,
									}}
								>
									<Text style={styles.medicineTitle}>{i18n.get("start")}:</Text>
									<Text>{new Date(props.medicine.medication_start).toLocaleDateString(i18n.locale)}</Text>
								</View>
								<View
									style={{
										...styles.medicineValues,
										justifyContent: "flex-start",
										alignItems: "flex-start",
										width: "80%",
										marginLeft: 20,
									}}
								>
									<Text style={styles.medicineTitle}>{i18n.get("end")}:</Text>
									<Text>{new Date(props.medicine.medication_end).toLocaleDateString(i18n.locale)}</Text>
								</View>
							</View>
						</View>
					) : (
						<View style={{ marginTop: 10 }} />
					)}
				</TouchableOpacity>
			</View>
		</>
	);
}

const styles = StyleSheet.create({
	medicineValues: {
		marginTop: 18,
		display: "flex",
		justifyContent: "flex-start",
		alignItems: "flex-start",
		gap: 10,
	},
	medicineTitle: {
		fontSize: 14,
		fontStyle: "normal",
		fontWeight: "bold",
		marginBottom: 5,
		textAlign: "left",
	},
	medicineValue: {
		marginLeft: "auto",
		marginRight: "auto",
		marginBottom: 5,
		fontSize: 14,
		textAlign: "left",
	},
});
