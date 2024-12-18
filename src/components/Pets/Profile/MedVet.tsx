import { FontAwesome5, Fontisto, Ionicons, Octicons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import i18n from "@utils/i18n";
import { navigate } from "@utils/navigator";
import { IPetHealth } from "@utils/supabase/services/pets/pets-health.service";
import { IPet } from "@utils/supabase/services/pets/pets.service";
import { Box, ScrollView } from "native-base";
import React, { useEffect } from "react";
import { StyleSheet, Text, TouchableOpacity, View } from "react-native";
import { IServiceResponse } from "types/general";

interface IProps {
	pet: Partial<IPet>;
	health: IServiceResponse<IPetHealth>;
	colors: ReturnType<typeof useColors>;
}

export default function MedVet(props: IProps) {
	useEffect(() => {}, []);
	return (
		<ScrollView style={{ flex: 1, backgroundColor: props.colors.background }}>
			<View style={{ display: "flex", marginTop: 20 }}>
				{props.pet.description && props.pet.description?.length > 0 && (
					<View
						style={{
							display: "flex",
							alignItems: "flex-start",
							marginBottom: "auto",
						}}
					>
						<Text style={{ color: props.colors.text, fontWeight: "bold", fontSize: 20 }}>
							{i18n.get("pets.petObservations")}
						</Text>

						<Box
							rounded="5"
							style={{
								backgroundColor: props.colors.cardColor,
								width: "100%",
								minHeight: props.pet.description && props.pet.description.length > 10 ? 100 : 10,
								marginTop: 5,
							}}
						>
							<Text style={{ marginTop: 10, marginLeft: 10, color: props.colors.text }}>{props.pet.description}</Text>
						</Box>
					</View>
				)}

				<View
					style={{
						display: "flex",
						flexDirection: "column",
						width: "100%",
						alignItems: "center",
						justifyContent: "center",
						gap: 20,
						marginTop: 20,
					}}
				>
					<TouchableOpacity
						style={{ ...styles.btnBox, backgroundColor: props.colors.cardColor }}
						onPress={() => navigate("Vaccines", { pet: props.pet })}
					>
						<View style={{ display: "flex", flexDirection: "row", gap: 10 }}>
							<Fontisto size={20} name="injection-syringe" color={props.colors.text} />
							<Text style={{ color: props.colors.text }}>{i18n.get("pets.profile.vaccines")}</Text>
						</View>
						<Ionicons name="chevron-forward" size={20} color={props.colors.text} />
					</TouchableOpacity>

					<TouchableOpacity
						style={{ ...styles.btnBox, backgroundColor: props.colors.cardColor }}
						onPress={() => navigate("Medicines", { pet: props.pet, health: props.health.data!.id })}
					>
						<View style={{ display: "flex", flexDirection: "row", gap: 10 }}>
							<FontAwesome5 name="pump-medical" size={20} color={props.colors.text} />
							<Text style={{ color: props.colors.text }}>{i18n.get("pets.profile.medicines")}</Text>
						</View>
						<Ionicons name="chevron-forward" size={20} color={props.colors.text} />
					</TouchableOpacity>

					<TouchableOpacity
						style={{ ...styles.btnBox, backgroundColor: props.colors.cardColor }}
						onPress={() => navigate("Products", { pet: props.pet })}
					>
						<View style={{ display: "flex", flexDirection: "row", gap: 10 }}>
							<FontAwesome5 name="shopping-bag" size={20} color={props.colors.text} />
							<Text style={{ color: props.colors.text }}>{i18n.get("pets.profile.products")}</Text>
						</View>
						<Ionicons name="chevron-forward" size={20} color={props.colors.text} />
					</TouchableOpacity>
				</View>
			</View>
		</ScrollView>
	);
}

const styles = StyleSheet.create({
	title: { fontWeight: "bold", fontFamily: "Inter", fontSize: 20 },
	listItem: {
		display: "flex",
		flexDirection: "row",
		justifyContent: "space-between",
		alignItems: "center",
		padding: 10,
		borderTopWidth: 1,
		borderBottomWidth: 1,
	},
	btnBox: {
		width: "90%",
		height: 80,
		padding: 10,
		paddingHorizontal: 40,
		display: "flex",
		flexDirection: "row",
		justifyContent: "space-between",
		alignItems: "center",
		borderRadius: 15,
	},
});
