import { WrappedInput } from "@components/Wrappers/Input";
import MaskedInput from "@components/Wrappers/MaskedInput";
import WrappedSelect from "@components/Wrappers/Select";
import { Ionicons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import i18n from "@utils/i18n";
import petBucket from "@utils/supabase/buckets/pets";
import petsService from "@utils/supabase/services/pets/pets.service";
import { IPet } from "@utils/supabase/services/pets/pets.service";
import { DateTime } from "luxon";
import { Checkbox, Fab, ScrollView, Select } from "native-base";
import React, { useCallback, useEffect, useRef, useState } from "react";
import { Keyboard, StyleSheet, View, Text, Alert } from "react-native";
import * as Animatable from "react-native-animatable";
import AppIntroSlider from "react-native-app-intro-slider";
import PetAvatarUpload from "./PetAvatarUpload";

interface IProps {
	onFinish: (pet: Partial<IPet>, petImage: string) => void;
	initialPet?: Partial<IPet>;
}

export default function NewPetSlider(props: IProps) {
	const colors = useColors();

	const [ref, setRef] = useState<AppIntroSlider>();
	const [currentSlide, setCurrentSlide] = useState(0);

	const petImage = useRef<string | null>(null);
	const [petData, setPetData] = useState<Partial<IPet>>({
		type: 0,
		has_stud_book: false,
	});

	const [keyboardVisible, setKeyboardVisible] = useState(false);

	const slides = [0, 1];

	useEffect(() => {
		setPetData((data) => ({
			...data,
			...props.initialPet,
			gender: props.initialPet && props.initialPet?.gender ? props.initialPet.gender - 1 : 0,
			birth_date:
				props.initialPet && props.initialPet?.birth_date
					? DateTime.fromISO(props.initialPet.birth_date).toFormat("dd/MM/yyyy")
					: null,
			description: "",
		}));

		const keyboardDidShowListener = Keyboard.addListener("keyboardDidShow", () => {
			setKeyboardVisible(true);
		});

		const keyboardDidHideListener = Keyboard.addListener("keyboardDidHide", () => {
			setKeyboardVisible(false);
		});

		return () => {
			keyboardDidHideListener.remove();
			keyboardDidShowListener.remove();
		};
	}, []);

	useEffect(() => {
		if (currentSlide > 0 && !petData.name) {
			setCurrentSlide(0);
			ref?.goToSlide(0);
		}
	}, [currentSlide]);

	const getPetImage = useCallback(() => {
		if (petImage) return `data:image/png;base64,${petImage}`;

		if (petData.id) return petBucket.getPetPhoto(petData.id, petData.user_id).data + "?" + DateTime.now().toMillis();

		return undefined;
	}, [petImage, petData]);

	const renderItem = ({ item }: { item: any }) => {
		if (item === 0) {
			return (
				<ScrollView
					contentContainerStyle={[styles.slide, { backgroundColor: colors.background, paddingBottom: 80 }]}
					showsVerticalScrollIndicator={false}
				>
					<PetAvatarUpload
						onImageChange={(image) => {
							petImage.current = image;
						}}
						initialImage={getPetImage()}
					/>

					<WrappedInput
						label={i18n.get("pets.questions.petName")}
						w="80%"
						mb={30}
						maxLength={15}
						value={petData.name}
						onChangeText={(text) => setPetData((data) => ({ ...data, name: text }))}
						isRequired
						rightElement={<Text style={{ color: colors.text, marginRight: 6 }}>{petData.name?.length}/15</Text>}
					/>

					<WrappedSelect
						w="80%"
						accessibilityLabel={i18n.get("pets.questions.petType")}
						selectedValue={String(petData.type ?? 0)}
						onValueChange={(type) => {
							setPetData((pet) => ({ ...pet, type: Number(type) }));
						}}
						minWidth="full"
					>
						<Select.Item key={0} label={i18n.get("pets.types.dog")} value={String(0)} />
						<Select.Item key={1} label={i18n.get("pets.types.cat")} value={String(1)} />
						{/* <Select.Item key={2} label={i18n.get("pets.types.bird")} value={String(2)} />
						<Select.Item key={3} label={i18n.get("pets.types.fish")} value={String(3)} />
						<Select.Item key={4} label={i18n.get("pets.types.rodent")} value={String(4)} />
						<Select.Item key={5} label={i18n.get("pets.types.reptile")} value={String(5)} /> */}
						<Select.Item key={6} label={i18n.get("pets.types.other")} value={String(6)} />
					</WrappedSelect>

					<View style={{ marginBottom: 30 }} />

					<WrappedSelect
						w="80%"
						accessibilityLabel={i18n.get("pets.questions.petGender")}
						selectedValue={String(petData.gender ?? 1)}
						onValueChange={(gender) => {
							setPetData((pet) => ({ ...pet, gender: Number(gender) }));
						}}
						minWidth="full"
					>
						<Select.Item key={1} label={i18n.get("pets.male")} value={String(0)} />
						<Select.Item key={2} label={i18n.get("pets.female")} value={String(1)} />
					</WrappedSelect>

					<View style={{ height: 150 }} />
				</ScrollView>
			);
		} else if (item === 1) {
			return (
				<View style={[styles.slide, { backgroundColor: colors.background, paddingTop: 25 }]}>
					<MaskedInput
						w="80%"
						mb={30}
						mask="date"
						label={i18n.get("pets.questions.petBirthDate")}
						value={petData.birth_date ?? ""}
						onChangeText={(text) => setPetData((data) => ({ ...data, birth_date: text }))}
						isRequired
					/>

					<WrappedInput
						label={i18n.get("pets.questions.petBreed")}
						w="80%"
						mb={30}
						value={petData.breed ?? undefined}
						onChangeText={(text) => setPetData((data) => ({ ...data, breed: text }))}
						placeholder="Ex: Poodle, Bulldog, etc."
					/>

					{/* <WrappedTextArea
						label={i18n.get("pets.questions.petDescription")}
						w="80%"
						mb={30}
						value={petData.description}
						onChangeText={(text) => setPetData((data) => ({ ...data, description: text }))}
						multiline={true}
						numberOfLines={5}
					/> */}

					<View style={{ width: "79%", display: "flex" }}>
						<Checkbox
							accessibilityLabel="has_stud_book"
							aria-label="has_stud_book"
							value="has_stud_book"
							isChecked={petData.has_stud_book ?? false}
							onChange={(selected) => setPetData((data) => ({ ...data, has_stud_book: selected }))}
						>
							{i18n.get("pets.questions.petHasPedigree")}
						</Checkbox>
					</View>
					<View style={{ height: 150 }} />
				</View>
			);
		}

		return <View />;
	};

	const renderPagination = () => {
		if (keyboardVisible) return null;

		return (
			<View style={styles.paginationContainer}>
				{currentSlide !== 0 && (
					<Fab
						onPress={() => {
							(ref as any).goToSlide(currentSlide - 1);
							setCurrentSlide(currentSlide - 1);
						}}
						position="absolute"
						bottom="85px"
						bgColor={colors.secondary}
						android_ripple={{ color: colors.background }}
						_ios={{ _pressed: { backgroundColor: colors.active } }}
						style={{ paddingLeft: 11, paddingRight: 11, paddingTop: 10, paddingBottom: 10 }}
						renderInPortal={false}
						shadow={2}
						size="xs"
						icon={<Ionicons name="arrow-back" size={26} color="white" />}
						placement="bottom-left"
					/>
				)}

				{petData.name && (
					<Fab
						onPress={async () => {
							if (!props.initialPet?.id) {
								const res = await petsService.getPetByName(petData.name!);

								if (res.data!.length > 0) {
									Alert.alert(i18n.get("existPetName"));
									return;
								}
							}

							if (slides.length - 1 === currentSlide) return props.onFinish(petData, petImage.current ?? "");

							(ref as any).goToSlide(currentSlide + 1);
							setCurrentSlide(currentSlide + 1);
						}}
						position="absolute"
						bottom="85px"
						bgColor={colors.primary}
						android_ripple={{ color: colors.background }}
						_ios={{ _pressed: { backgroundColor: colors.active } }}
						style={{ paddingLeft: 11, paddingRight: 11, paddingTop: 10, paddingBottom: 10 }}
						renderInPortal={false}
						shadow={2}
						size="xs"
						icon={
							currentSlide >= slides.length - 1 ? (
								<Ionicons name="checkmark-sharp" size={26} color="white" />
							) : (
								<Ionicons name="arrow-forward" size={26} color="white" />
							)
						}
						placement="bottom-right"
					/>
				)}
			</View>
		);
	};

	return (
		<Animatable.View animation="fadeIn" style={{ flex: 1 }}>
			<View style={styles.header}>
				{slides.map((_, i) => {
					return (
						<View
							style={[styles.page, { backgroundColor: currentSlide >= i ? colors.primary : colors.lightGray }]}
							key={i}
						/>
					);
				})}
			</View>

			<AppIntroSlider
				ref={(ref) => setRef(ref as any)}
				data={slides}
				onDone={() => props.onFinish(petData, petImage.current ?? "")}
				renderItem={renderItem}
				renderPagination={renderPagination}
				renderPrevButton={() => null}
				renderNextButton={() => null}
				renderDoneButton={() => null}
				onSlideChange={(index) => setCurrentSlide(index)}
				scrollEnabled={false}
			/>
		</Animatable.View>
	);
}

const styles = StyleSheet.create({
	header: {
		position: "absolute",
		top: 0,
		left: 0,
		right: 0,
		zIndex: 1,

		display: "flex",
		flexDirection: "row",
		justifyContent: "center",
		alignItems: "center",
		height: 64,

		width: "100%",
	},
	page: {
		width: 32,
		height: 8,
		borderRadius: 4,
		marginHorizontal: 4,
	},
	slide: {
		// flex: 1,
		alignItems: "center",
		minHeight: "100%",
		marginTop: 70,
	},
	texts: {
		marginTop: 128,
	},
	title: {
		color: "white",
		textAlign: "center",
		fontFamily: "Inter",
	},
	text: {
		color: "white",
		textAlign: "center",
		fontFamily: "Inter",
		marginTop: 16,
		paddingHorizontal: 30,
	},
	image: {
		width: 256,
		height: 256,
		transform: [{ scale: 1 }],
		marginTop: "auto",
		marginBottom: "auto",
	},

	paginationContainer: {
		// position: "absolute",
		display: "flex",
		flexDirection: "row",
		justifyContent: "space-between",
		alignItems: "center",
		marginTop: "auto",
		width: "100%",
		paddingHorizontal: 20,
		// gap: 10,
	},
	paginationButton: {
		display: "flex",
		justifyContent: "center",
		alignItems: "center",
		width: 48,
		height: 48,
		borderRadius: 9999,
	},
});
