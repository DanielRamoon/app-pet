import { View, Text, TouchableOpacity, StyleSheet, ScrollView, DeviceEventEmitter, Dimensions } from "react-native";
import { MaterialCommunityIcons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import { useRoute } from "@react-navigation/native";
import i18n from "@utils/i18n";
import ThemedView from "@components/utils/ThemedView";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import { useEffect, useState } from "react";
import Loader from "@components/Loader";
import pet_reminder from "@utils/supabase/services/pets/pet_reminder";
import { DateTime } from "luxon";
import WrongTime from "@components/Modals/WrongTime";
import ContentLoader, { Rect } from "react-content-loader/native";

interface IParams {
	id_reminder: string;
	isMedicine: boolean;
	medicineId: number;
}

interface DataReminder {
	id: string;
	pet_id: string;
	title: string;
	desc: string;
	date: Date;
	name: string;
	triggered: boolean;
}

export default function Note({ navigation }: NativeStackScreenProps<any, "MainTabs">) {
	const colors = useColors();
	const [data, setData] = useState<DataReminder>();
	const { params } = useRoute() as { params: IParams };
	const [messageTime, setMessageTime] = useState<string>("");
	const date = new Date();
	const [wrongTime, setWrongTime] = useState<boolean>(false);

	useEffect(() => {
		pet_reminder.getPetReminderById(params.id_reminder).then((val: any) => {
			if (val.data) {
				setData({
					id: params.id_reminder,
					title: val.data.text,
					desc: val.data.description,
					date: new Date(val.data.remember_when),
					pet_id: val.data.pet_id,
					triggered: val.data.triggered,
					name: val.data.name.name,
				});
			}
		});

		const editEvent = DeviceEventEmitter.addListener("editReminder", (e: any) => {
			navigation.navigate("AddReminder", { id_reminder: params.id_reminder, isMedicine: params.isMedicine, medicineId: params.medicineId });
		});

		return () => {
			editEvent.remove();
		};
	}, []);

	function formatHoursAndMinutes(date_: Date) {
		const date = DateTime.fromJSDate(date_).setZone("local").toJSDate();

		const options = { hour: "2-digit", minute: "2-digit" } as const;
		return date.toLocaleTimeString(i18n.locale, options);
	}

	if (data) {
		return (
			<ThemedView isRoot fadeIn>
				{wrongTime && <WrongTime cancel={() => setWrongTime(false)} message={messageTime} />}
				<ScrollView style={{ width: "100%", paddingBottom: "20%" }} showsVerticalScrollIndicator={false}>
					<View style={styles.container}>
						<View style={{ display: "flex", justifyContent: "center", alignItems: "center" }}>
							<Text style={{ color: colors.text, fontSize: 23 }}>{data.title} </Text>

							{data.triggered ? (
								<View style={{ width: "100%", display: "flex", alignItems: "flex-start" }}>
									<Text style={{ ...styles.outTime, backgroundColor: colors.danger }}>
										{i18n.get("reminder.outTime")}
									</Text>
								</View>
							) : (
								<></>
							)}
							{params.isMedicine ? (
								<View style={{ width: "100%", display: "flex", alignItems: "flex-start" }}>
									<Text style={{ ...styles.medicine, backgroundColor: colors.primary }}>
										{i18n.get("reminder.medicine")}
									</Text>
								</View>
							) : (
								<></>
							)}
						</View>

						<View
							style={{
								display: "flex",
								width: "100%",
								flexDirection: "column",
								gap: 12,
								alignItems: "center",
								justifyContent: "flex-start",
								marginTop: 10,
							}}
						>
							<View
								style={{
									display: "flex",
									flexDirection: "column",
									justifyContent: "center",
									width: "100%",
									alignItems: "flex-start",
									gap: 10,
								}}
							>
								<Text style={{ color: colors.text }}>
									{i18n.get("note.date")}: {data.date.toLocaleDateString(i18n.locale)}
									{" - "}
									{formatHoursAndMinutes(data.date)}
								</Text>
								<Text style={{ color: colors.text }}>Pet: {data.name}</Text>
							</View>
						</View>

						<View
							style={{ width: "100%", marginTop: 10, display: "flex", justifyContent: "center", alignItems: "center" }}
						>
							<View style={{ display: "flex", flexDirection: "column", gap: 20, width: "100%" }}>
								<Text style={{ color: colors.text, textAlign: "left" }}>{i18n.get("description")}:</Text>
								<Text style={{ color: colors.text, textAlign: "left" }}>{data.desc}</Text>
							</View>
						</View>
					</View>
				</ScrollView>
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
						<Rect width={120} height={35} x={155} y={20} rx={8} ry={8} />
						<Rect width={220} height={20} x={14} y={95} rx={6} ry={6} />
						<Rect width={180} height={15} x={14} y={135} rx={4} ry={4} />
						<Rect width={95} height={15} x={14} y={206} rx={4} ry={4} />
						<Rect width={Dimensions.get("window").width} height={100} x={14} y={235} rx={10} ry={10} />
					</ContentLoader>
				</View>
			</ThemedView>
		);
	}
}

const styles = StyleSheet.create({
	container: {
		width: "100%",
		// marginTop: 30,
		display: "flex",
		flexDirection: "column",
		alignItems: "center",
		gap: 40,
		justifyContent: "flex-start",
		padding: 10,
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
	actionBtnS: {
		borderRadius: 14,
		width: 100,
		height: 50,
		backgroundColor: "#54c59f",
		display: "flex",
		flexDirection: "row",
		justifyContent: "space-evenly",
		alignItems: "center",
	},
	datePickerBtn: {
		display: "flex",
		justifyContent: "center",
		alignItems: "center",
		backgroundColor: "#f67f31",
		padding: 10,
		flexDirection: "row",
		gap: 10,
		borderRadius: 15,
		width: 150,
	},
	containerDate: {
		gap: 8,
		display: "flex",
		alignItems: "flex-start",
		justifyContent: "flex-start",
		width: "100%",
	},
	outTime: {
		paddingHorizontal: 20,
		paddingVertical: 5,
		borderRadius: 15,
		color: "white",
	},
	medicine: {
		paddingHorizontal: 20,
		paddingVertical: 5,
		borderRadius: 15,
		color: "white",
	},
});
