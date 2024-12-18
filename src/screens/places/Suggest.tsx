import { WrappedInput } from "@components/Wrappers/Input";
import TextArea from "@components/Wrappers/TextArea";
import ThemedView from "@components/utils/ThemedView";
import useColors from "@hooks/useColors";
import i18n, { PlaceType } from "@utils/i18n";
import { Button, ScrollView, Text, View } from "native-base";
import { useEffect, useState } from "react";
import { ActivityIndicator, Alert, Linking, StyleSheet } from "react-native";
import * as Location from "expo-location";
import axios from "axios";
import { IOSMGeocodeResponse } from "types/geocoding";
import { isNullOrEmpty } from "@utils/utilities";
import placesService from "@utils/supabase/services/places.service";
import { navigate } from "@utils/navigator";
import { Select } from "native-base";
import WrappedSelect from "@components/Wrappers/Select";

export default function () {
	const [loading, setLoading] = useState(false);
	const [loadingGeocode, setLoadingGeocode] = useState(false);

	const colors = useColors();
	const [place, setPlace] = useState({
		name: "",
		description: "",
		address_street: "",
		address_number: "",
		address_district: "",
		address_location: "",
		phone: "",
		coordinates: [0, 0],
		place_type: "",
	});
	const [placeValidator, setPlaceValidator] = useState({
		name: true,
		// description: true,
		address_street: true,
		address_number: true,
		address_district: true,
		address_location: true,
		// phone: true,
		place_type: true,
	});

	async function getUserCurrentLocation(): Promise<IOSMGeocodeResponse["address"] | null> {
		const { status } = await Location.requestForegroundPermissionsAsync();
		if (status !== "granted") {
			Alert.alert("Permission to access location was denied");
			return null;
		}

		setLoadingGeocode(true);

		const location = await Location.getCurrentPositionAsync({ accuracy: Location.Accuracy.High });
		const { latitude, longitude } = location.coords;

		const locationGeocodeRequest = await axios.get<IOSMGeocodeResponse>(
			`https://nominatim.openstreetmap.org/reverse?lat=${latitude}&lon=${longitude}&format=json`
		);

		const { address } = locationGeocodeRequest.data;

		setPlace((data) => ({
			...data,
			address_street: address.road,
			address_district: address.suburb,
			address_location: `${address.city}, ${address["ISO3166-2-lvl4"].split("-")[1]}, ${address.postcode}`,
			coordinates: [latitude, longitude],
		}));

		setLoadingGeocode(false);

		return address;

		//
	}

	function assembleStreetMapsLink() {
		const { address_street, address_number, address_district, address_location } = place;
		const address = `${address_street}, ${address_number}, ${address_location}`
			.replaceAll(" ", "+")
			.replaceAll("%", "")
			.replaceAll("#", "")
			.replaceAll("?", "");

		return `https://www.google.com/maps/place/${address}`;
	}

	async function saveSuggestion() {
		if (loading) return;

		if (Object.values(placeValidator).some((value) => value)) {
			Alert.alert("Erro ao enviar sugestão", "Preencha todos os campos corretamente.");
			return;
		}

		const address = await getUserCurrentLocation();

		if (!address) {
			Alert.alert("Erro ao enviar sugestão", "Não foi possível obter os dados da sua localização.");
			return;
		}

		setLoading(true);

		const result = await placesService.createPlace({
			name: place.name,
			description: place.description,
			address_street: place.address_street,
			address_number: +place.address_number,
			address_district: place.address_district,
			address_location: `${address.city}, ${address["ISO3166-2-lvl4"].split("-")[1]}`,
			address_phone: place.phone,
			coordinates: place.coordinates,
			address_cep: address.postcode,
			maps_url: assembleStreetMapsLink(),
			approved: false,
			requested_by: "",
			place_type: place.place_type,
		});

		if (result.status !== 201) {
			Alert.alert("Erro ao enviar sugestão", "Tente novamente mais tarde.");

			setLoading(false);

			return;
		}

		Alert.alert("Sugestão enviada", "Obrigado por contribuir com a comunidade!");

		setLoading(false);

		// Navigate to home
		navigate("Index");
	}

	useEffect(() => {
		getUserCurrentLocation();
	}, []);

	useEffect(() => {
		const { name, description, address_street, address_number, address_district, address_location, phone } = place;

		setPlaceValidator({
			name: isNullOrEmpty(name),
			// description: false,
			address_street: isNullOrEmpty(address_street),
			address_number: Number.isNaN(Number(address_number)) || isNullOrEmpty(address_number),
			address_district: isNullOrEmpty(address_district),
			address_location: isNullOrEmpty(address_location),
			// phone: isNullOrEmpty(phone),
			place_type: isNullOrEmpty(place.place_type),
		});
	}, [place]);

	return (
		<ThemedView isRoot fadeIn>
			<ScrollView
				contentContainerStyle={[styles.slide, { backgroundColor: colors.background, paddingBottom: 200 }]}
				showsVerticalScrollIndicator={false}
			>
				<WrappedInput
					label={i18n.get("places.labels.placeName")}
					w="80%"
					mb={30}
					value={place.name}
					onChangeText={(text) => setPlace((data) => ({ ...data, name: text }))}
					isRequired
					isInvalid={placeValidator.name}
					isDisabled={loading}
				/>

				<TextArea
					label={i18n.get("places.labels.placeDescription")}
					w="80%"
					mb={30}
					value={place.description}
					onChangeText={(text) => setPlace((data) => ({ ...data, description: text }))}
					isDisabled={loading}
				/>

				<WrappedSelect
					accessibilityLabel={i18n.get("places.type")}
					minWidth="80%"
					mb={30}
					selectedValue={place.place_type}
					onValueChange={(value) => setPlace((data) => ({ ...data, place_type: value }))}
					isRequired
				>
					{i18n.get("places.options").map((option: string, i: number) => (
						<Select.Item label={option} value={PlaceType[i]} key={i} />
					))}
				</WrappedSelect>

				<WrappedInput
					label={i18n.get("places.labels.placeAddressStreet")}
					w="80%"
					mb={30}
					value={place.address_street}
					isDisabled={loadingGeocode || loading}
					onChangeText={(text) => setPlace((data) => ({ ...data, address_street: text }))}
					isRequired
					isInvalid={placeValidator.address_street}
				/>

				<WrappedInput
					label={i18n.get("places.labels.placeAddressNumber")}
					w="80%"
					mb={30}
					value={place.address_number}
					onChangeText={(text) => setPlace((data) => ({ ...data, address_number: text }))}
					isRequired
					isInvalid={placeValidator.address_number}
					isDisabled={loading}
				/>

				<WrappedInput
					label={i18n.get("places.labels.placeAddressDistrict")}
					w="80%"
					mb={30}
					value={place.address_district}
					isDisabled={loadingGeocode || loading}
					onChangeText={(text) => setPlace((data) => ({ ...data, address_district: text }))}
					isRequired
					isInvalid={placeValidator.address_district}
				/>

				<WrappedInput
					label={i18n.get("places.labels.placeAddressLocation")}
					w="80%"
					mb={30}
					value={place.address_location}
					isDisabled={loadingGeocode || loading}
					onChangeText={(text) => setPlace((data) => ({ ...data, address_location: text }))}
					isRequired
					isInvalid={placeValidator.address_location}
				/>

				<WrappedInput
					label={i18n.get("places.labels.placePhone")}
					w="80%"
					mb={30}
					value={place.phone}
					onChangeText={(text) => setPlace((data) => ({ ...data, phone: text }))}
					isRequired={false}
					// isInvalid={placeValidator.phone}
					isDisabled={loading}
				/>

				<Button
					backgroundColor={colors.primary}
					isDisabled={loading || loadingGeocode}
					onPress={saveSuggestion}
					mt="auto"
					mb="1"
					width={"80%"}
				>
					<View
						style={{
							display: "flex",
							flexDirection: "row",
							alignItems: "center",
							gap: 10,
							width: "100%",
						}}
					>
						{loading || loadingGeocode ? (
							<>
								<ActivityIndicator color="white" />
								<Text color="white">{loadingGeocode ? i18n.get("loading") : i18n.get("saving")}</Text>
							</>
						) : (
							<Text color="white">{i18n.get("suggest")}</Text>
						)}
					</View>
				</Button>
			</ScrollView>
		</ThemedView>
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
		marginTop: 10,
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
