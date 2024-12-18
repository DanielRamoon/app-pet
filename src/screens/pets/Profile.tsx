import Loader from "@components/Loader";
import LoadingModal from "@components/Modals/LoadingModal";
import SuccessModal from "@components/Modals/SuccessModal";
import PetAvatarUpload from "@components/Pets/PetAvatarUpload";
import MedVet from "@components/Pets/Profile/MedVet";
import Walks from "@components/Pets/Profile/Walks";
import ThemedView from "@components/utils/ThemedView";
import useColors from "@hooks/useColors";
import { useRoute } from "@react-navigation/native";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import i18n from "@utils/i18n";
import petTypes from "@utils/petTypes";
import petBucket from "@utils/supabase/buckets/pets";
import { supabase } from "@utils/supabase/client";
import petsHealthService, { IPetHealth } from "@utils/supabase/services/pets/pets-health.service";
import petsService, { IPet } from "@utils/supabase/services/pets/pets.service";
import { getPetDuration } from "@utils/utilities";
import { DateTime } from "luxon";
import { Badge, Box, HStack, Text } from "native-base";
import React, { useCallback, useEffect, useState } from "react";
import ContentLoader, { Circle, Rect } from "react-content-loader/native";
import { Alert, DeviceEventEmitter, Dimensions, View, useWindowDimensions } from "react-native";
import { SceneMap, TabBar, TabView } from "react-native-tab-view";
import { IServiceResponse } from "types/general";

export default function ({ navigation }: NativeStackScreenProps<any, "MainTabs">) {
	const colors = useColors();
	const route = useRoute();

	const params = route.params as {
		id: string;
	};

	const [loading, setLoading] = useState(true);
	const [success, setSuccess] = useState(false);
	const [pet, setPet] = useState<IPet>();
	const [health, setPetHealth] = useState<IServiceResponse<IPetHealth>>();
	const [userId, setUserId] = useState<string>();

	const layout = useWindowDimensions();

	const [index, setIndex] = React.useState(0);

	async function startup() {
		setLoading(true);

		const user = await supabase.auth.getUser();
		setUserId(user.data.user?.id ?? "");

		const result = await petsService.getPet(params.id);
		const resultHealth = await petsHealthService.getPetHealthDetails(params.id);

		setPetHealth(resultHealth);
		setPet(result.data);

		setLoading(false);
	}

	useEffect(() => {
		startup().finally(() => setTimeout(() => setLoading(false), 1000));

		const editEvent = DeviceEventEmitter.addListener("editPet", () => {
			navigation.navigate("Edit", { id: params.id });
		});

		return () => {
			editEvent.remove();
		};
	}, []);

	async function updatePetImage(petImage: string) {
		if (!pet || !petImage) return;

		setLoading(true);

		const response = await petBucket.updatePetPhoto(pet.id, petImage);
		if (response.trace) Alert.alert(i18n.get("pets.errors.uploadImage"));

		setLoading(false);
		setSuccess(true);

		setTimeout(() => {
			setSuccess(false);
		}, 3000);
	}

	const [modalOpen, setModalOpen] = useState(false);
	const FirstRoute = useCallback(
		() => (
			<Walks
				pet={pet!}
				colors={colors}
				userId={userId!}
				openingModal={() => setModalOpen(true)}
				closingModal={() => setModalOpen(false)}
			/>
		),
		[pet, userId]
	);

	const SecondRoute = () => <MedVet pet={pet!} colors={colors} health={health!} />;

	const renderScene = SceneMap({
		first: FirstRoute,
		second: SecondRoute,
		// third: () => null,
	});

	if (loading) {
		return (
			<ThemedView>
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
						<Circle cx={65} cy={70} r={55} />
						<Rect width={160} height={16} x={150} y={20} rx={5} ry={5} />
						<Rect width={80} height={11} x={150} y={50} rx={3} ry={3} />
						<Rect width={55} height={25} x={150} y={70} rx={4} ry={4} />
					</ContentLoader>
				</View>
			</ThemedView>
		);
	}

	return (
		<ThemedView>
			{loading && <LoadingModal />}
			{success && <SuccessModal />}

			{!modalOpen && (
				<Box
					// bg={colors.cardColor}
					style={{
						width: "100%",
						// flex: 1,
						display: "flex",
						flexDirection: "row",
					}}
					rounded="5"
				>
					<Box
						style={{
							flex: 1,
							flexDirection: "column",
							justifyContent: "space-between",
						}}
						paddingLeft={5}
						paddingRight={5}
						paddingTop={2}
						paddingBottom={2}
					>
						<HStack alignItems="flex-start">
							<PetAvatarUpload
								onImageChange={(image) => updatePetImage(image)}
								initialImage={petBucket.getPetPhoto(pet!.id, pet!.user_id).data + "?" + DateTime.now().toMillis()}
								style={{
									marginTop: 10,
									marginBottom: "auto",
									width: "auto",
									height: "auto",
									justifyContent: "center",
									alignItems: "center",
								}}
								compact
								disabledLongPress
							/>

							<View style={{ display: "flex", flexDirection: "column", paddingLeft: 30 }}>
								<Text
									style={{ marginTop: 5 }}
									color={colors.text}
									fontWeight="medium"
									fontSize="xl"
									numberOfLines={1}
									lineHeight={27}
									ellipsizeMode="tail"
									maxWidth={Dimensions.get("window").width - 150}
								>
									{pet!.name}
								</Text>

								<View style={{ display: "flex", flexDirection: "row" }}>
									<Text style={{ marginTop: 4 }} color={colors.text}>
										{petTypes[pet!.type ?? 6]()}
									</Text>

									<Text style={{ marginTop: 4 }} color={colors.text}>
										{pet!.breed && pet!.type ? "," : " -"}
									</Text>

									<Text style={{ marginTop: 4, marginLeft: 5 }} color={colors.text}>
										{pet!.breed ?? i18n.get((pet as any).breed_relation ?? "pets.noBreed")}
									</Text>
								</View>

								<Text style={{ marginTop: 4 }} fontSize={10} color={colors.text}>
									{getPetDuration(pet!.birth_date)} -{" "}
									{pet!.birth_date && DateTime.fromISO(pet!.birth_date).toFormat("dd/MM/yyyy")}
								</Text>

								<Badge
									mb="auto"
									mt="7px"
									bgColor={pet!.gender === 1 ? colors.male : colors.female}
									_text={{
										color: "white",
									}}
									variant="solid"
									rounded="4"
									style={{ marginTop: 10 }}
									maxW={65}
								>
									{pet!.gender === 1 ? i18n.get("pets.male") : i18n.get("pets.female")}
								</Badge>
							</View>
						</HStack>
					</Box>
				</Box>
			)}

			<View style={{ flex: 1, backgroundColor: colors.background }}>
				<TabView
					navigationState={{
						index: index ?? 0,
						routes: [
							{ key: "first", title: i18n.get("pets.profile.walks") },
							{ key: "second", title: i18n.get("pets.profile.medvet") },
							// { key: "third", title: i18n.get("pets.profile.others") },
						],
					}}
					renderScene={renderScene}
					onIndexChange={setIndex}
					initialLayout={{ width: layout.width }}
					swipeEnabled={!modalOpen}
					renderTabBar={(props: any) => (
						<TabBar
							{...props}
							indicatorStyle={{ backgroundColor: colors.primary }}
							style={{ backgroundColor: "transparent", display: modalOpen ? "none" : "flex" }}
							labelStyle={{ color: colors.text }}
						/>
					)}
				/>
			</View>
		</ThemedView>
	);
}
