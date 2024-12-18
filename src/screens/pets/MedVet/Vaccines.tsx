import Loader from "@components/Loader";
import LoadingModal from "@components/Modals/LoadingModal";
import QuestionModal from "@components/Modals/QuestionModal";
import SuccessModal from "@components/Modals/SuccessModal";
import Vaccine from "@components/Pets/Vaccine";
import ConfirmDel from "@components/Modals/ConfirmDelReminder";
import ThemedView from "@components/utils/ThemedView";
import { Octicons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import { useRoute } from "@react-navigation/native";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import { FlashList } from "@shopify/flash-list";
import i18n from "@utils/i18n";
import petsHealthVaccinesService, {
	IPetHealthVaccines,
	IPetHealthVaccinesDoses,
} from "@utils/supabase/services/pets/pets-health-vaccines.service";
import petsHealthService, { IPetHealth } from "@utils/supabase/services/pets/pets-health.service";
import { IPet } from "@utils/supabase/services/pets/pets.service";
import { Box, Fab } from "native-base";
import React, { useEffect, useState } from "react";
import { Alert, Keyboard, StyleSheet, Image, Text, View, Dimensions } from "react-native";
import { RefreshControl } from "react-native-gesture-handler";
import { IServiceResponse } from "types/general";
import ContentLoader, { Rect } from "react-content-loader/native";

export default function ({ navigation }: NativeStackScreenProps<any, "MainTabs">) {
	const colors = useColors();
	const route = useRoute();

	const params = route.params as {
		pet: IPet;
	};

	const [petHealth, setPetHealth] = useState<IPetHealth>();

	const [firstLoad, setFirstLoad] = useState(true);
	const [loading, setLoading] = useState(false);
	const [refreshing, setRefreshing] = useState(false);
	const [success, setSuccess] = useState(false);
	const [nameAlert, setNameAlert] = useState(false);
	const [addingNew, setAddingNew] = useState(false);

	const [newVaccine, setNewVaccine] = useState<Partial<IPetHealthVaccines>>({});
	const [vaccines, setVaccines] = useState<(IPetHealthVaccines & { doses: IPetHealthVaccinesDoses[] })[]>([]);

	const [keyboardVisible, setKeyboardVisible] = useState(false);

	async function startup(refresh?: boolean) {
		if (refresh) setRefreshing(true);
		else setFirstLoad(true);

		const petHealth = (await petsHealthService.getPetHealthDetails(params.pet.id)) as IServiceResponse<
			IPetHealth & {
				vaccines: IPetHealthVaccines[];
			}
		>;
		if (petHealth.status === 200) {
			setPetHealth(petHealth.data);
			setVaccines(
				petHealth.data ? (petHealth.data.vaccines as (IPetHealthVaccines & { doses: IPetHealthVaccinesDoses[] })[]) : []
			);
		}

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
	}, []);

	async function addNewVaccine(description: string) {
		if (!description) {
			setNameAlert(true);
			return;
		}

		setAddingNew(false);
		setLoading(true);

		const result = await petsHealthVaccinesService.createVaccine(petHealth?.id!, {
			...newVaccine,
			description,
		} as IPetHealthVaccines);

		setLoading(false);
		if (result.status === 201 || result.status === 200) {
			setSuccess(true);
			setNewVaccine({});
			startup(true);
			setTimeout(() => setSuccess(false), 2000);
		} else {
			Alert.alert(i18n.get("error"), i18n.get("pets.errors.addVaccineError"));
			setAddingNew(true);
		}
	}

	const renderItem = ({
		item,
		index,
	}: {
		item: IPetHealthVaccines & { doses: IPetHealthVaccinesDoses[] };
		index: number;
	}) => {
		const isLastItem = index === vaccines.length - 1;
		return (
			<Vaccine
				vaccine={item}
				key={index}
				onUpdate={() => startup(true)}
				petID={params.pet.id}
				isLastItem={isLastItem}
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
						<Rect width={Dimensions.get("window").width} height={185} x={0} y={30} rx={20} ry={20} />
					</ContentLoader>
				</View>
			</ThemedView>
		);
	}

	return (
		<ThemedView isRoot fadeIn>
			{loading && <LoadingModal />}
			{success && <SuccessModal />}
			{nameAlert && <ConfirmDel message={i18n.get("pets.questions.vaccineName")} cancel={() => setNameAlert(false)} />}

			{addingNew && (
				<QuestionModal
					title={i18n.get("pets.profile.addVaccine")}
					inputMessage={i18n.get("pets.questions.vaccineName")}
					confirm={(value: string) => addNewVaccine(value)}
					cancel={() => setAddingNew(false)}
					avoidKeyboard
				/>
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
				alwaysBounceVertical={true}
				showsVerticalScrollIndicator={false}
				data={vaccines}
				renderItem={renderItem}
				ListFooterComponent={
					vaccines.length === 0 ? (
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
									width: 170,
									height: 170,
									marginTop: "auto",
								}}
								source={require("@assets/icons/vaccine.png")}
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
