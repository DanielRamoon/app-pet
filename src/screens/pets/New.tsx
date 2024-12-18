import ErrorModal from "@components/Modals/ErrorModal";
import LoadingModal from "@components/Modals/LoadingModal";
import SuccessModal from "@components/Modals/SuccessModal";
import NewPetSlider from "@components/Pets/NewPetSlider";
import ThemedView from "@components/utils/ThemedView";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import i18n from "@utils/i18n";
import petBucket from "@utils/supabase/buckets/pets";
import petsService, { IPet } from "@utils/supabase/services/pets/pets.service";
import { DateTime } from "luxon";
import React, { useEffect, useState } from "react";
import { Alert } from "react-native";

export default function ({
	navigation,
	initialPet,
}: NativeStackScreenProps<any, "MainTabs"> & { initialPet?: Partial<IPet> }) {
	const [loading, setLoading] = useState(false);
	const [success, setSuccess] = useState(false);
	const [error, setError] = useState(false);

	async function uploadPetImage(petId: string, image: string) {
		const response = await petBucket.updatePetPhoto(petId, image);
		if (response.trace) {
			return false;
		}

		return true;
	}

	async function createOrUpdatePet(pet: Partial<IPet>, petImage: string) {
		if (loading) return;

		setLoading(true);

		if (!initialPet?.id) {
			pet.created_at = DateTime.local().toISO();
		}

		pet.updated_at = DateTime.local().toISO() as any;

		const response = !initialPet?.id
			? await petsService.createPet({ ...pet, gender: (pet.gender ?? 0) + 1 } as IPet)
			: await petsService.updatePet(String(pet.id), { ...pet, gender: (pet.gender ?? 0) + 1 } as IPet);

		if (response.trace) return Alert.alert(i18n.get("pets.errors.createPet")), setLoading(false);
		if (!response.data) return Alert.alert(i18n.get("pets.errors.createPet")), setLoading(false);

		if (petImage) {
			const success = await uploadPetImage(initialPet?.id ?? response.data.id, petImage);
			if (!success) {
				setLoading(false);
				setError(true);

				setTimeout(() => {
					setError(false);
				}, 3000);

				return;
			}
		}

		setLoading(false);
		setSuccess(true);
	}

	function dateIsValid(date: string) {
		const dateObj = DateTime.fromFormat(date, "dd/MM/yyyy");
		return dateObj.isValid && dateObj <= DateTime.local();
	}

	useEffect(() => {
		if (success) {
			setTimeout(() => {
				setSuccess(false);
			}, 3000);

			setTimeout(() => {
				navigation.navigate("Index");
			}, 2000);
		}
	}, [success]);

	return (
		<ThemedView fadeIn>
			{loading && <LoadingModal />}
			{success && <SuccessModal />}
			{error && <ErrorModal errorMessage={i18n.get("pets.errors.uploadImage")} />}

			<NewPetSlider
				initialPet={initialPet}
				onFinish={(pet, image) => {
					if (!pet.name) return Alert.alert(i18n.get("pets.errors.emptyName"));
					if (!pet.birth_date) return Alert.alert(i18n.get("pets.errors.emptyBirthDate"));
					if (!dateIsValid(pet.birth_date)) return Alert.alert(i18n.get("pets.errors.invalidBirthDate"));

					// pet.birth_date = DateTime.fromFormat(pet.birth_date, "dd/MM/yyyy").toISODate();

					createOrUpdatePet(
						{ ...pet, birth_date: DateTime.fromFormat(pet.birth_date, "dd/MM/yyyy").toISODate() },
						image
					);
				}}
			/>
		</ThemedView>
	);
}
