import Loader from "@components/Loader";
import LoadingModal from "@components/Modals/LoadingModal";
import QuestionModal from "@components/Modals/QuestionModal";
import SuccessModal from "@components/Modals/SuccessModal";
import Medicine from "@components/Pets/Medicine";
import Input from "@components/Wrappers/Input";
import ThemedView from "@components/utils/ThemedView";
import { Octicons } from "@expo/vector-icons";
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
import { Fab, KeyboardAvoidingView } from "native-base";
import React, { useEffect, useState } from "react";
import { Alert, Dimensions, Image, Keyboard, RefreshControl, StyleSheet, Text, View } from "react-native";
import { IServiceResponse } from "types/general";
import ContentLoader, { Rect } from "react-content-loader/native";

interface IPetHealthMedicinesModificate extends IPetHealthMedicines {
	haveReminder: boolean;
}

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
	const [nameAlert, setNameAlert] = useState(false);
	const [success, setSuccess] = useState(false);
	const [isLastItem, setIsLastItem] = useState<boolean>(false);
	const [addingNew, setAddingNew] = useState(false);

	const [newProduct, setNewProduct] = useState<Partial<IPetHealthMedicines>>({});
	const [products, setProducts] = useState<IPetHealthMedicinesModificate[]>([]);

	const [keyboardVisible, setKeyboardVisible] = useState(false);

	async function startup(refresh?: boolean) {
		if (refresh) setRefreshing(true);
		else setFirstLoad(true);

		const petHealth = (await petsHealthService.getPetHealthDetails(
			params.pet.id,
			eMedicineType.GENERIC_PRODUCT
		)) as IServiceResponse<
			IPetHealth & {
				medicines: IPetHealthMedicines[];
			}
		>;

		if (petHealth.status === 200) {
			setPetHealth(petHealth.data);
			setProducts(
				petHealth.data
					? (petHealth.data.medicines.filter(
							(med) => med.type == eMedicineType.GENERIC_PRODUCT
					  ) as IPetHealthMedicinesModificate[])
					: []
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

	const addNewProduct = async (name: string | undefined) => {
		if (!name) {
			setNameAlert(true);
			return;
		}

		setAddingNew(false);
		setLoading(true);

		const result = await petsHealthMedicinesService.createPetHealthMedicines({
			description: name,
			dose: newProduct.dose ? newProduct.dose : 0,
			amount: newProduct.amount ? newProduct.amount : 0,
			health_id: petHealth?.id!,
			type: eMedicineType.GENERIC_PRODUCT,
		} as IPetHealthMedicines);

		setLoading(false);
		if (result.status === 201 || result.status === 200) {
			setSuccess(true);
			setNewProduct({});
			startup(true);
			setTimeout(() => setSuccess(false), 2000);
		} else {
			Alert.alert(i18n.get("error"), i18n.get("pets.errors.addProductError"));
			setAddingNew(true);
		}
	};

	const renderItem = ({ item, index }: { item: IPetHealthMedicinesModificate; index: number }) => {
		const isLastItem = index === products.length - 1;

		return (
			<Medicine
				medicine={item}
				key={index}
				onUpdate={() => startup(true)}
				isProduct={true}
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
						<Rect width={Dimensions.get("window").width} height={80} x={0} y={30} rx={10} ry={10} />
					</ContentLoader>
				</View>
			</ThemedView>
		);
	}

	return (
		<ThemedView isRoot fadeIn>
			{loading && <LoadingModal />}
			{success && <SuccessModal />}
			{nameAlert && <ConfirmDel message={i18n.get("pets.questions.productName")} cancel={() => setNameAlert(false)} />}
			{addingNew && (
				<KeyboardAvoidingView behavior="position" style={{ height: "100%", width: "100%" }}>
					<QuestionModal
						title={i18n.get("pets.profile.addProduct")}
						confirm={() => addNewProduct(newProduct.description)}
						cancel={() => setAddingNew(false)}
						customBody={
							<View style={{ marginTop: 0, gap: 10 }}>
								<Input
									value={newProduct.description}
									onChangeText={(value) => setNewProduct({ ...newProduct, description: value })}
									label={i18n.get("pets.profile.productName")}
									labelProps={{ color: colors.text }}
								/>
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
				alwaysBounceVertical={true}
				data={products}
				renderItem={renderItem}
				ListFooterComponent={
					products.length === 0 ? (
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
									width: 220,
									height: 200,
									marginTop: "auto",
								}}
								source={require("@assets/icons/shop.png")}
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
