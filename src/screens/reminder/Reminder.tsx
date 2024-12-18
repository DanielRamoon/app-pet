import { View, Text, TouchableOpacity, StyleSheet, Dimensions, FlatList, Image, Alert } from "react-native";
import { Ionicons, MaterialCommunityIcons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import i18n from "@utils/i18n";
import { navigate } from "@utils/navigator";
import { useRoute } from "@react-navigation/native";
import ThemedView from "@components/utils/ThemedView";
import { useEffect, useState } from "react";
import pet_reminder from "@utils/supabase/services/pets/pet_reminder";
import { CheckBoxProps, CheckBox } from "@ui-kitten/components";
import ConfirmDel from "@components/Modals/ConfirmDelReminder";
import { DateTime } from "luxon";
import EmptyReminder from "@components/Modals/EmptyReminders";
import ContentLoader, { Rect } from "react-content-loader/native";

interface IParams {
	reload: number;
}
interface ReminderContent {
	id: string;
	remember_when: Date;
	title: string;
	medicine_id: number;
	triggered: boolean;
	name: string;
	selected?: boolean;
	remember_again_in?: Date;
}

export default function Reminder() {
	const colors = useColors();
	const { params } = useRoute() as { params: IParams };
	const [toDelete, setToDelete] = useState<string[]>([]);
	const [toDeleteMedicine, setToDeleteMedicine] = useState<string[]>([]);
	const [loading, setIsLoading] = useState<boolean>(true);
	const [remove, setRemove] = useState<boolean>(false);
	const [confirmDel, setConfirmDel] = useState<boolean>(false);
	const [message, setMessage] = useState<string>("");
	const [reminders, setReminders] = useState<ReminderContent[] | null>(null);
	const windowWidth = Dimensions.get("window").width;
	const [empty, setEmpty] = useState<boolean>(false);
	const allRemindersCheckbox = (initialCheck = false): CheckBoxProps => {
		const [checked, setChecked] = useState<boolean>(initialCheck);
		return {
			checked,
			onChange: () => {
				setChecked(!checked);
				setToDelete([]);
			},
		};
	};
	const outTimeCheckBox = (initialCheck = false): CheckBoxProps => {
		const [checked, setChecked] = useState<boolean>(initialCheck);
		return {
			checked,
			onChange: () => {
				setChecked(!checked);
				setToDelete([]);
			},
		};
	};
	const removeAll = allRemindersCheckbox();
	const removeOutTime = outTimeCheckBox();

	useEffect(() => {
		setIsLoading(true);
		pet_reminder.getAllPetReminders().then((value) => {
			const result = value.data?.map((val: any) => {
				return {
					id: val.id,
					remember_when: new Date(val.remember_when),
					title: val.text,
					triggered: val.triggered,
					name: val.name.name,
					selected: false,
					remember_again_in: val.remember_again_in,
					medicine_id: val.medicine_id,
				};
			});

			if (result) {
				setReminders(result);
				setIsLoading(false);
			}
		});
	}, [params.reload]);

	async function ReloadReminders() {
		pet_reminder.getAllPetReminders().then((value) => {
			const result = value.data?.map((val: any) => {
				return {
					id: val.id,
					remember_when: new Date(val.remember_when),
					title: val.text,
					triggered: val.triggered,
					name: val.name.name,
					remember_again_in: val.remember_again_in,
					medicine_id: val.medicine_id,
				};
			});

			if (result) {
				setReminders(result);
				setIsLoading(false);

				return;
			}

			Alert.alert(i18n.get("error"), i18n.get("errorOccurred"));
		});
	}

	function formatHoursAndMinutes(date_: Date) {
		const date = DateTime.fromJSDate(date_).setZone("local").toJSDate();

		const options = { hour: "2-digit", minute: "2-digit" } as const;
		return date.toLocaleTimeString(i18n.locale, options);
	}

	const renderItem = ({ item, index }: { item: ReminderContent; index: number }) => (
		<TouchableOpacity
			disabled={removeOutTime.checked || removeAll.checked ? true : false}
			style={{
				...styles.btn,
				backgroundColor: colors.cardColor,
				gap: remove ? 40 : 30,
				marginBottom: index === reminders!.length - 1 ? 400 : 0,
				paddingRight: item.selected ? 0 : 20,
			}}
			onPress={() => {
				if (!remove) {
					navigate("Note", {
						id_reminder: item.id,
						isMedicine: item.medicine_id ? true : false,
						medicineId: item.medicine_id,
					});
				} else {
					item.selected = !item.selected;
					if (item.remember_again_in) {
						setToDeleteMedicine((prevToDelete) => {
							if (item.selected) {
								if (!prevToDelete.includes(item.id)) {
									return [...prevToDelete, item.id];
								}
							} else {
								return prevToDelete.filter((itemF) => itemF !== item.id);
							}
							return prevToDelete;
						});
						return;
					}
					setToDelete((prevToDelete) => {
						if (item.selected) {
							if (!prevToDelete.includes(item.id)) {
								return [...prevToDelete, item.id];
							}
						} else {
							return prevToDelete.filter((itemF) => itemF !== item.id);
						}
						return prevToDelete;
					});
				}
			}}
		>
			{item.selected && remove ? (
				<View
					style={{
						zIndex: item.selected ? 0 : 1,
						backgroundColor: item.remember_again_in ? colors.reminderMedicineReminder : colors.reminderDelete,
						width: "100%",
						height: "100%",
						display: "flex",
						justifyContent: "center",
						alignItems: "center",
						borderRadius: 15,
					}}
				>
					<Ionicons
						style={{
							position: item.remember_again_in ? "absolute" : "relative",
							zIndex: item.remember_again_in ? 3 : 0,
						}}
						name={item.remember_again_in ? "medkit-outline" : "trash-bin-outline"}
						color={"white"}
						size={40}
					/>
					{item.remember_again_in ? (
						<View
							style={{
								width: "100%",
								display: "flex",
								alignItems: "flex-end",
								justifyContent: "center",
								height: "100%",
							}}
						>
							<View
								style={{
									width: "50%",
									backgroundColor: colors.reminderDelete,
									height: "100%",
									borderTopRightRadius: 15,
									borderBottomRightRadius: 15,
								}}
							/>
						</View>
					) : (
						<></>
					)}
				</View>
			) : (
				<></>
			)}
			<View
				style={{
					minWidth: "50%",
					display: "flex",
					flexDirection: "row",
					maxWidth: "50%",
					gap: 20,
					paddingLeft: 20,
					marginRight: remove ? 20 : 0,
				}}
			>
				<View
					style={{
						display: "flex",
						flexDirection: "row",
						gap: 20,
						paddingLeft: 20,
					}}
				>
					{item.triggered ? (
						<Text
							style={{
								position: "absolute",
								display: "flex",
								marginLeft: 20,
								top: -27,
								fontSize: 12,
								backgroundColor: colors.danger,
								color: "white",
								borderRadius: 15,
								padding: 1,
								paddingHorizontal: 5,
							}}
						>
							{i18n.get("reminder.outTime")}
						</Text>
					) : (
						<></>
					)}
					{item.remember_again_in ? (
						<Text
							style={{
								position: "absolute",
								display: "flex",
								marginLeft: 20,
								top: -27,
								fontSize: 12,
								backgroundColor: colors.primary,
								color: "white",
								borderRadius: 15,
								padding: 1,
								paddingHorizontal: 5,
							}}
						>
							{i18n.get("reminder.medicine")}
						</Text>
					) : (
						<></>
					)}
					<Text
						style={{
							color: colors.text,
							fontSize: 15,
						}}
						numberOfLines={1}
					>
						{item.title}
					</Text>
				</View>
			</View>
			<View
				style={{
					display: "flex",
					flexDirection: "row",
					justifyContent: "flex-start",
					alignItems: "center",
					gap: 10,
				}}
			>
				<View>
					<Text style={{ color: colors.text, maxWidth: 130 }} numberOfLines={1}>
						{i18n.get("reminder.on")}: {item.remember_when.toLocaleDateString(i18n.locale)}
					</Text>
					<Text style={{ color: colors.text, maxWidth: 130 }} numberOfLines={1}>
						{i18n.get("hour")}: {formatHoursAndMinutes(item.remember_when)}
					</Text>
					<Text style={{ color: colors.text, maxWidth: 130 }} numberOfLines={1}>
						Pet: {item.name}
					</Text>
				</View>

				{remove ? <></> : <Ionicons name="chevron-forward" size={20} color={colors.text} />}
			</View>
		</TouchableOpacity>
	);

	async function DeleteCheck() {
		if (removeAll.checked && reminders) {
			setIsLoading(true);
			setConfirmDel(false);
			setRemove(false);
			await pet_reminder.deletePetReminder(reminders);

			ReloadReminders();
		} else if (removeOutTime.checked && reminders) {
			const remindersToRemove = reminders.filter((reminder) => reminder.triggered);
			setIsLoading(true);
			setConfirmDel(false);
			setRemove(false);
			await pet_reminder.deletePetReminder(remindersToRemove);
			ReloadReminders();
		} else {
			setIsLoading(true);
			setConfirmDel(false);
			setRemove(false);
			if (toDelete.length > 0) {
				await pet_reminder.deletePetReminder(toDelete);
			}
			if (toDeleteMedicine.length > 0) {
				await pet_reminder.deletePetReminder(toDeleteMedicine);
			}
			setToDelete([]);
			ReloadReminders();
		}
	}

	if (!loading && reminders) {
		return (
			<ThemedView isRoot fadeIn>
				{confirmDel && <ConfirmDel confirm={DeleteCheck} cancel={() => setConfirmDel(false)} message={message} />}
				{empty && <EmptyReminder confirm={() => setEmpty(false)} message={i18n.get("reminder.noOutTimeReminders")} />}
				<View style={styles.container}>
					<View
						style={{
							display: "flex",
							width: "100%",
							marginTop: 20,
							flexDirection: "row",
							gap: 10,
							justifyContent: "flex-end",
							alignItems: "center",
						}}
					>
						<TouchableOpacity
							style={{ ...styles.actionBtnE, backgroundColor: remove ? "#253045" : colors.danger }}
							onPress={() => {
								if (reminders.length === 0) {
									return;
								}
								setRemove(!remove);
							}}
						>
							<Text style={{ color: "white" }}>{remove ? i18n.get("cancel") : i18n.get("remove")}</Text>
							<Ionicons name={remove ? "close-outline" : "trash-bin-outline"} color={"white"} size={20} />
						</TouchableOpacity>

						{remove ? (
							<TouchableOpacity
								style={{ ...styles.actionBtnE, backgroundColor: colors.danger }}
								onPress={() => {
									if (removeOutTime.checked) {
										const remindersToRemove = reminders.filter((reminder) => reminder.triggered);
										if (remindersToRemove.length > 0) {
											setMessage(i18n.get("reminder.removeAllOutTimeReminders"));
											setConfirmDel(true);
										} else {
											setEmpty(true);
										}
									} else if (removeAll.checked) {
										setMessage(i18n.get("reminder.removeAllReminders"));
										setConfirmDel(true);
									} else if (toDelete.length > 0 && toDeleteMedicine.length === 0) {
										if (toDelete.length > 1) setMessage(i18n.get("reminder.removeReminders"));
										else setMessage(i18n.get("reminder.removeReminder"));
										setConfirmDel(true);
									} else if (toDeleteMedicine.length > 0 && toDelete.length === 0) {
										if (toDeleteMedicine.length > 1) setMessage(i18n.get("reminder.removeMedicineReminders"));
										else setMessage(i18n.get("reminder.removeMedicineReminder"));
										setConfirmDel(true);
									} else if (toDeleteMedicine.length > 0 && toDelete.length > 0) {
										if (toDeleteMedicine.length > 1 && toDelete.length > 1)
											setMessage(i18n.get("reminder.removeRemindersWithMedicines"));
										else if (toDeleteMedicine.length > 1 && toDelete.length === 1)
											setMessage(i18n.get("reminder.removeReminderWithMedicines"));
										else if (toDeleteMedicine.length === 1 && toDelete.length > 1)
											setMessage(i18n.get("reminder.removeRemindersWithMedicine"));
										else setMessage(i18n.get("reminder.removeReminderWithMedicine"));
										setConfirmDel(true);
									}
								}}
							>
								<Text style={{ color: "white" }}>{i18n.get("confirm")}</Text>
								<Ionicons name="trash-bin-outline" color={"white"} size={20} />
							</TouchableOpacity>
						) : (
							<TouchableOpacity
								style={styles.actionBtnN}
								onPress={() => navigate("AddReminder", { isMedicine: false })}
							>
								<Text style={{ color: "white" }}>{i18n.get("new")}</Text>
								<Ionicons name="add-circle-outline" color={"white"} size={20} />
							</TouchableOpacity>
						)}
					</View>
					{remove ? (
						<View
							style={{
								width: "100%",
								display: "flex",
								flexDirection: "column",
								gap: 20,
								marginTop: 20,
								marginBottom: 10,
								justifyContent: "flex-start",
								alignItems: "center",
							}}
						>
							{removeOutTime.checked ? (
								<></>
							) : (
								<View style={styles.removerAll}>
									<CheckBox style={styles.checkbox} {...removeAll} />
									<Text style={{ color: colors.text }}>{i18n.get("reminder.removeAll")}</Text>
								</View>
							)}
							{removeAll.checked ? (
								<></>
							) : (
								<View style={styles.removerAll}>
									<CheckBox style={styles.checkbox} {...removeOutTime} />
									<Text style={{ color: colors.text }}>{i18n.get("reminder.clearOutTime")}</Text>
								</View>
							)}
						</View>
					) : (
						<></>
					)}
					<View style={{ width: "100%", height: "100%", paddingTop: remove ? 0 : 20 }}>
						<FlatList
							showsVerticalScrollIndicator={false}
							data={reminders}
							renderItem={renderItem}
							ListFooterComponent={
								reminders.length === 0 ? (
									<View
										style={{
											width: windowWidth,
											display: "flex",
											alignItems: "center",
											marginTop: 30,
											gap: 10,
											justifyContent: "center",
											flexDirection: "column",
										}}
									>
										<Image
											style={{
												width: 180,
												height: 130,
												marginTop: "auto",
											}}
											source={require("@assets/icons/catIcon.png")}
										/>
										<Text style={{ color: colors.text, textAlign: "center", width: "100%" }}>
											{i18n.get("nothingToSee")}
										</Text>
									</View>
								) : (
									<></>
								)
							}
						/>
					</View>
				</View>
			</ThemedView>
		);
	} else {
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
						<Rect width={120} height={58} x={160} y={20} rx={10} ry={10} />
						<Rect width={120} height={58} x={290} y={20} rx={10} ry={10} />
						<Rect width={Dimensions.get("window").width} height={120} x={0} y={120} rx={20} ry={20} />
					</ContentLoader>
				</View>
			</ThemedView>
		);
	}
}

const styles = StyleSheet.create({
	container: {
		width: "100%",
		height: "100%",
		display: "flex",
		flexDirection: "column",
		justifyContent: "flex-start",
		alignItems: "center",
	},
	btn: {
		width: "100%",
		height: 100,
		marginTop: 15,
		display: "flex",
		flexDirection: "row",
		justifyContent: "flex-start",
		alignItems: "center",
		borderRadius: 15,
	},
	checkbox: {
		margin: 2,
	},
	actionBtnN: {
		borderRadius: 14,
		width: 100,
		height: 50,
		backgroundColor: "#f67f31",
		display: "flex",
		flexDirection: "row",
		justifyContent: "space-evenly",
		alignItems: "center",
	},
	actionBtnE: {
		borderRadius: 14,
		width: 100,
		height: 50,
		display: "flex",
		flexDirection: "row",
		justifyContent: "space-evenly",
		alignItems: "center",
	},
	removerAll: {
		display: "flex",
		justifyContent: "flex-start",
		flexDirection: "row",
		alignItems: "flex-start",
		gap: 15,
		width: "100%",
	},
});
