import useColors from "@hooks/useColors";
import petsService, { IPet } from "@utils/supabase/services/pets/pets.service";
import { Image, Text } from "native-base";
import { useEffect, useState } from "react";
import {
	DeviceEventEmitter,
	Dimensions,
	ScrollView,
	StyleSheet,
	TouchableWithoutFeedback,
	Vibration,
	View,
} from "react-native";
import petBucket from "@utils/supabase/buckets/pets";
import flex from "@styles/flex";
import i18n from "@utils/i18n";
import { DateTime } from "luxon";
import { getRelativeTimeText } from "@utils/utilities";
import { capitalize } from "lodash";

export default function PetList({
	forceUpdate,
	onChangePetSelection,
}: {
	forceUpdate: boolean;
	onChangePetSelection: (ids: string[]) => void;
}) {
	// Hooks
	const colors = useColors();

	// Local state
	const [pets, setPets] = useState<IPet[]>([] as IPet[]);
	const [selectedPetsIds, setSelectedPetsIds] = useState<string[]>([] as string[]);

	// Functions
	const getLastWalkDistance = (walkData: IPet["walks"]) => {
		if (!walkData) return 0;
		if (!Array.isArray(walkData)) return 0;
		if (walkData.length === 0) return 0;

		const lastWalk = walkData[walkData.length - 1];

		const distance = (lastWalk?.total_distance as any)?.km ?? 0;

		return Number(distance?.toFixed(2))?.toLocaleString(i18n.locale);
	};

	const getWalkDuration = (walkData: IPet["walks"]) => {
		if (!walkData) return 0;
		if (!Array.isArray(walkData)) return 0;
		if (walkData.length === 0) return 0;

		const lastWalk = walkData[walkData.length - 1];

		if (!lastWalk.date_end) return 0;

		// Calculate duration based on start and end time using luxon
		const duration = DateTime.fromISO(lastWalk.date_end).diff(DateTime.fromISO(lastWalk.date_start), [
			"hours",
			"minutes",
			"seconds",
		]);

		return duration.toFormat("h'h' m'm' s's'");
	};

	// Returns the last walk date (like, 1 hour ago, 2 days ago, etc)
	const getLastWalkDate = (walkData: IPet["walks"]) => {
		if (!walkData) return 0;
		if (!Array.isArray(walkData)) return 0;
		if (walkData.length === 0) return 0;

		const lastWalk = walkData[walkData.length - 1];

		if (!lastWalk.date_end) return 0;

		return getRelativeTimeText(lastWalk.date_end);
	};

	const getTotalWalkedDistance = (walkData: IPet["walks"]) => {
		if (!walkData) return 0;
		if (!Array.isArray(walkData)) return 0;
		if (walkData.length === 0) return 0;

		const distance = walkData?.reduce((acc, curr) => acc + (curr.total_distance as any)?.km ?? 0, 0);
		return Number(distance?.toFixed(2))?.toLocaleString(i18n.locale);
	};

	const checkPet = (pet: IPet) => {
		// If pet is already selected, do nothing
		if (selectedPetsIds.includes(pet.id)) return;
		setSelectedPetsIds([...selectedPetsIds, pet.id]);

		// Vibrates the device
		Vibration.vibrate(100);
	};

	const uncheckPet = (pet: IPet) => {
		if (selectedPetsIds.length === 0) return;

		// If pet is not selected, do nothing
		if (!selectedPetsIds.includes(pet.id)) return checkPet(pet);
		setSelectedPetsIds(selectedPetsIds.filter((id) => id !== pet.id));

		Vibration.vibrate(30);
	};

	const handlePressPet = (pet: IPet) => {
		// if (selectedPetsIds.length === 0) return;
		if (selectedPetsIds.includes(pet.id)) return uncheckPet(pet);
		setSelectedPetsIds([...selectedPetsIds, pet.id]);

		Vibration.vibrate(30);
	};

	const checkPetIsSelected = (pet: IPet) => {
		return selectedPetsIds.includes(pet.id);
	};

	const fetchPets = async () => {
		const pets = await petsService.getPets();

		if (!pets?.data) return;

		// Ordena as walks por date_end
		pets.data.forEach((pet) => {
			if (pet.walks) {
				pet.walks = pet.walks.sort((a, b) => {
					return DateTime.fromISO(a.date_end).toMillis() - DateTime.fromISO(b.date_end).toMillis();
				});
			}
		});

		setPets(pets.data);
	};

	// Effects
	useEffect(() => {
		fetchPets();
	}, []);

	useEffect(() => {
		fetchPets();
	}, [forceUpdate]);

	useEffect(() => {
		onChangePetSelection(selectedPetsIds);
	}, [selectedPetsIds]);

	return (
		<ScrollView horizontal showsHorizontalScrollIndicator={false} alwaysBounceHorizontal={true} bounces={true}>
			{pets?.map((item, index) => {
				const petImage = petBucket.getPetPhoto(item.id, item.user_id).data;

				return (
					<TouchableWithoutFeedback
						onPress={() => {
							handlePressPet(item);
						}}
						key={index}
					>
						<View
							style={{
								display: "flex",
								flexDirection: "column",
								position: "relative",
							}}
						>
							<View
								style={{
									position: "absolute",
									left: index === 0 ? (Dimensions.get("window").width - 85) / 7.3 : 7,
									right: index === pets?.length - 1 ? (Dimensions.get("window").width - 85) / 7.3 : 7,
									justifyContent: "center",
									alignItems: "center",
									zIndex: 1000,
									top: 10,
								}}
							>
								<Image
									style={{
										width: 85,
										height: 85,
										borderRadius: 15,
										...flex.myAuto,
										zIndex: 100,
										borderColor: checkPetIsSelected(item) ? colors.primary : "transparent",
										borderWidth: 2,
									}}
									source={
										!petImage
											? {
													uri: petBucket.getPetPhoto().data,
											  }
											: {
													uri: petImage ?? undefined,
													headers: {
														Pragma: "no-cache",
													},
											  }
									}
									fallbackSource={{ uri: petBucket.getPetPhoto().data }}
									alt="Pet image"
								/>
							</View>

							<View
								style={{
									marginLeft: index === 0 ? (Dimensions.get("window").width - 85) / 7.3 : 7,
									marginRight: index === pets?.length - 1 ? (Dimensions.get("window").width - 85) / 7.3 : 7,
									width: Dimensions.get("window").width - 85,
									paddingTop: 24,
									marginBottom: 10,
									top: 60,
									borderRadius: 8,
									overflow: "hidden",
									flexDirection: "row",
									backgroundColor: colors.cardColor,
									paddingLeft: 0,
									maxWidth: Dimensions.get("window").width,
									height: 185,
									borderColor: checkPetIsSelected(item) ? colors.primary : "transparent",
									borderWidth: 2,
									...styles.shadowContainer,
								}}
							>
								<View
									style={{
										display: "flex",
										flexDirection: "column",
										width: "100%",
										paddingLeft: 13,
										paddingRight: 13,
										paddingBottom: 10,
										height: "100%",
									}}
								>
									<View style={{ display: "flex", flexDirection: "column" }}>
										<View
											style={{
												display: "flex",
												flexDirection: "row",
												justifyContent: "space-between",
												marginBottom: 6,
												marginTop: 10,
											}}
										>
											<Text
												color={colors.text}
												fontWeight="medium"
												fontSize="xl"
												numberOfLines={1}
												lineHeight={27}
												ellipsizeMode="tail"
												paddingRight={2}
												maxWidth={Dimensions.get("window").width - 140}
												marginTop={2}
												bold
											>
												{item.name}
											</Text>

											{getTotalWalkedDistance(item.walks) !== 0 && (
												<View style={{ display: "flex", flexDirection: "row", gap: 3, alignItems: "center" }}>
													<Text
														color={colors.primary}
														fontWeight="bold"
														numberOfLines={1}
														fontSize="xl"
														lineHeight={27}
														ellipsizeMode="tail"
														maxWidth={Dimensions.get("window").width - 150}
														bold
														mt={2}
													>
														{getTotalWalkedDistance(item.walks)}
													</Text>

													<Text
														fontSize={"xs"}
														color={colors.primary}
														fontWeight="bold"
														style={{ marginTop: "auto", marginBottom: 2.2 }}
													>
														km
													</Text>
												</View>
											)}
										</View>

										{getLastWalkDistance(item.walks) !== 0 && (
											<View
												style={{
													display: "flex",
													flexDirection: "row",
													gap: 4,
													alignItems: "center",
												}}
											>
												<Text color={colors.text} fontWeight="medium" fontSize="md">
													{i18n.get("lastWalk")}:
												</Text>

												<View style={{ display: "flex", flexDirection: "row", gap: 3, alignItems: "center" }}>
													<Text
														color={colors.text}
														fontWeight="medium"
														numberOfLines={1}
														fontSize="md"
														lineHeight={27}
														ellipsizeMode="tail"
														maxWidth={Dimensions.get("window").width - 150}
														bold
													>
														{getLastWalkDistance(item.walks)}
													</Text>

													<Text
														fontSize={"xs"}
														color={colors.text}
														fontWeight="bold"
														style={{ marginTop: "auto", marginBottom: 2.2 }}
													>
														km
													</Text>
												</View>
											</View>
										)}

										{getWalkDuration(item.walks) !== 0 && (
											<View
												style={{
													display: "flex",
													flexDirection: "row",
													gap: 4,
													alignItems: "center",
													marginBottom: 5,
												}}
											>
												<Text color={colors.text} fontWeight="medium" fontSize="md">
													{capitalize(i18n.get("date.duration"))}:
												</Text>

												<View style={{ display: "flex", flexDirection: "row", gap: 3, alignItems: "center" }}>
													<Text
														color={colors.text}
														fontWeight="medium"
														numberOfLines={1}
														fontSize="md"
														lineHeight={27}
														ellipsizeMode="tail"
														maxWidth={Dimensions.get("window").width - 150}
														bold
													>
														{getWalkDuration(item.walks)}
													</Text>
												</View>
											</View>
										)}

										{getLastWalkDate(item.walks) !== 0 && (
											<View style={{ display: "flex", flexDirection: "row", gap: 4, alignItems: "center" }}>
												<Text>{getLastWalkDate(item.walks)}</Text>
											</View>
										)}

										{getLastWalkDistance(item.walks) === 0 && (
											<View>
												<Text color={colors.text} fontWeight="medium" fontSize="md">
													{i18n
														.get("noWalk")
														.replace(
															"$PET",
															item.name.length > 9 ? item.name.substring(0, 10) + "..." : item.name.split(" ")[0]
														)}
												</Text>
											</View>
										)}
									</View>
								</View>
							</View>
						</View>
					</TouchableWithoutFeedback>
				);
			})}
		</ScrollView>
	);
}

const styles = StyleSheet.create({
	shadowContainer: {
		shadowColor: "#000",
		shadowOffset: { width: 0, height: 2 },
		shadowOpacity: 0.3,
		shadowRadius: 4,
		elevation: 5, // A propriedade 'elevation' é usada para sombras no Android
	},
});
