import ThemedView from "@components/utils/ThemedView";
import useColors from "@hooks/useColors";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import React, { useEffect } from "react";
import New from "./New";
import petsService, { IPet } from "@utils/supabase/services/pets/pets.service";
import Loader from "@components/Loader";
import { Alert } from "react-native";
import i18n from "@utils/i18n";

export default function ({ navigation, route }: NativeStackScreenProps<any, "MainTabs">) {
	const colors = useColors();

	const [pet, setPet] = React.useState<IPet>();

	useEffect(() => {
		const params = route.params as {
			id: string;
		};

		async function startup() {
			const result = await petsService.getPet(params.id);

			if (!result.data) {
				Alert.alert(i18n.get("pets.errors.notFound"));
				return navigation.goBack();
			}

			setPet(result.data);
		}

		startup();
	});

	if (!pet)
		return (
			<ThemedView>
				<Loader />
			</ThemedView>
		);

	return <New navigation={navigation} route={route} initialPet={pet} />;
}
