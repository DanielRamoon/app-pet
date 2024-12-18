import ThemedView from "@components/utils/ThemedView";
import useColors from "@hooks/useColors";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import i18n from "@utils/i18n";
import { View, Text } from "react-native";
import React, { useEffect, useState } from "react";
import petsService, { IPet } from "@utils/supabase/services/pets/pets.service";

export default function ({ navigation }: NativeStackScreenProps<any, "MainTabs">) {
	const colors = useColors();
	const [data, setData] = useState<IPet>();

	const getPets = async () => {
		// await petsService.getPets().then((resulte)=>{
		// })
	};

	getPets();

	return (
		<ThemedView>
			<View style={{ width: "100%", paddingHorizontal: 20, marginTop: 30 }}>
				<Text style={{ color: colors.text, fontSize: 16 }}>{i18n.get("newPost.select")}</Text>
			</View>
		</ThemedView>
	);
}
