import ThemedView from "@components/utils/ThemedView";
import { Ionicons, MaterialCommunityIcons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import { useRoute } from "@react-navigation/native";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import i18n, { PlaceType } from "@utils/i18n";
import { ScrollView } from "native-base";
import { useEffect, useState } from "react";
import {
	ActivityIndicator,
	Alert,
	FlatList,
	Linking,
	RefreshControl,
	StyleSheet,
	Text,
	TouchableOpacity,
	View,
} from "react-native";
import * as Location from "expo-location";
import axios from "axios";
import { IOSMGeocodeResponse } from "types/geocoding";
import placesService, { Place } from "@utils/supabase/services/places.service";
import { FlashList } from "@shopify/flash-list";
import { navigate } from "@utils/navigator";
import Loader from "@components/Loader";

interface IParams {
	queryType: number;
}

export default function ({ navigation }: NativeStackScreenProps<any, "MainTabs">) {
	const colors = useColors();
	const { params } = useRoute() as { params: IParams };

	const [loading, setLoading] = useState(false);
	const [places, setPlaces] = useState<Place[]>([]);
	const [refreshing, setRefreshing] = useState(false);

	const getUserCurrentLocation = async (): Promise<string | null> => {
		const location = await Location.getCurrentPositionAsync({ accuracy: Location.Accuracy.High });
		const { latitude, longitude } = location.coords;

		const locationGeocodeRequest = await axios.get<IOSMGeocodeResponse>(
			`https://nominatim.openstreetmap.org/reverse?lat=${latitude}&lon=${longitude}&format=json`
		);

		const { address } = locationGeocodeRequest.data;

		return `${address.city}, ${address["ISO3166-2-lvl4"].split("-")[1]}`;
	};

	const getPlaces = async () => {
		try {
			setLoading(true);

			const userLocation = await getUserCurrentLocation();

			if (!userLocation) {
				Alert.alert(i18n.get("error"), i18n.get("error_messages.unknown"));

				setLoading(false);

				return;
			}

			const result = await placesService.getPlacesByCityNStateNType(userLocation, PlaceType[params.queryType]);

			if (result.trace) {
				Alert.alert(i18n.get("error"), i18n.get("error_messages.unknown"));

				setLoading(false);

				return;
			}

			if (!result.data) {
				Alert.alert(i18n.get("error"), i18n.get("error_messages.unknown"));

				setLoading(false);

				return;
			}

			setPlaces(result.data);

			//
		} catch (error) {
			Alert.alert(i18n.get("error"), i18n.get("error_messages.unknown"));
		} finally {
			setLoading(false);
		}
	};

	function beautifyAddress(place: Place) {
		return `${place.address_street}, ${place.address_number}, ${place.address_district}, ${place.address_location}`;
	}

	function tryFormatPhoneBr(phone: string) {
		if (phone.startsWith("0")) phone = phone.substring(1);

		if (phone.length === 10) return phone.replace(/(\d{2})(\d{4})(\d{4})/, "($1) $2-$3");
		else if (phone.length === 11) return phone.replace(/(\d{2})(\d{5})(\d{4})/, "($1) $2-$3");
		else if (phone.length === 9) return phone.replace(/(\d{5})(\d{4})/, "$1-$2");
		else return phone;
	}

	navigation.setOptions({
		headerTitle: i18n.get(`places.options[${params.queryType}]`),
	});

	useEffect(() => {
		getPlaces();
	}, []);

	return (
		<ThemedView isRoot fadeIn>
			<FlashList
				showsVerticalScrollIndicator={false}
				// ListHeaderComponent={renderHeader}
				refreshControl={
					<RefreshControl
						refreshing={refreshing}
						onRefresh={() => (setRefreshing(true), getPlaces().then(() => setRefreshing(false)))}
						tintColor={colors.primary}
						colors={[colors.white]}
						progressBackgroundColor={colors.lightGreen}
					/>
				}
				contentContainerStyle={{ paddingTop: 10 }}
				alwaysBounceVertical={true}
				data={places}
				ListHeaderComponent={
					<View style={{ display: "flex", flexDirection: "row", justifyContent: "space-between" }}>
						<TouchableOpacity
							onPress={() => {
								if (params.queryType === PlaceType.others) return;
								if (params.queryType === PlaceType.pet_friendly) return;

								Linking.openURL(
									`https://www.google.com/maps/search/${i18n.get(`places.mapsUriOptions[${params.queryType}]`)}/`
								);
							}}
							style={{
								display:
									params.queryType === PlaceType.others || params.queryType === PlaceType.pet_friendly
										? "none"
										: "flex",
								justifyContent: "center",
								alignItems: "center",
								borderWidth: 1.5,
								borderColor: colors.text,
								borderRadius: 12,
								padding: 10,
							}}
						>
							<View
								style={{
									display: "flex",
									justifyContent: "center",
									alignItems: "center",
									flexDirection: "row",
									gap: 10,
								}}
							>
								<Text style={{ color: colors.text }}>{i18n.get("seeMoreInMaps")}</Text>
								<MaterialCommunityIcons name="map-marker" size={20} color={colors.text} />
							</View>
						</TouchableOpacity>

						<TouchableOpacity
							style={{
								display: "flex",
								justifyContent: "center",
								alignItems: "center",
								borderWidth: 1.5,
								borderColor: colors.text,
								borderRadius: 12,
								padding: 10,
							}}
							onPress={() => {
								navigate("Suggest");
							}}
						>
							<View
								style={{
									display: "flex",
									justifyContent: "center",
									alignItems: "center",
									flexDirection: "row",
									gap: 10,
								}}
							>
								<Text style={{ color: colors.text }}>{i18n.get("suggest")}</Text>
								<MaterialCommunityIcons name="map-marker-plus" size={20} color={colors.text} />
							</View>
						</TouchableOpacity>
					</View>
				}
				renderItem={(place) => (
					<TouchableOpacity
						key={place.index}
						style={{ ...styles.btn, backgroundColor: colors.cardColor }}
						onPress={() => {
							Linking.openURL(place.item.maps_url);
						}}
					>
						<View style={{ display: "flex", flexDirection: "row", gap: 5, marginRight: "auto" }}>
							<MaterialCommunityIcons name="map-marker" size={20} color={colors.text} />
							<View style={{ display: "flex", flexDirection: "column", gap: 5 }}>
								<Text>{`${place.item.name} ${
									place.item.address_phone ? "- " + tryFormatPhoneBr(place.item.address_phone) : ""
								}`}</Text>

								<Text style={{ maxWidth: "95%" }}>{place.item.description}</Text>

								<Text style={{ maxWidth: "95%" }}>{beautifyAddress(place.item)}</Text>
							</View>
						</View>
						<Ionicons style={{ marginLeft: "auto" }} name="chevron-forward" size={20} color={colors.text} />
					</TouchableOpacity>
				)}
				ListFooterComponent={
					!loading && places.length === 0 ? (
						<View
							style={{
								display: "flex",
								flexDirection: "row",
								justifyContent: "center",
								alignItems: "center",
								marginTop: 20,
							}}
						>
							<Text style={{ color: colors.text }}>{i18n.get("places.no_places")}</Text>
						</View>
					) : (
						<Loader />
					)
				}
				estimatedItemSize={200}
			/>
		</ThemedView>
	);
}

const styles = StyleSheet.create({
	btn: {
		marginTop: 20,
		width: "100%",
		minHeight: 70,
		display: "flex",
		flexDirection: "row",
		justifyContent: "space-evenly",
		alignItems: "center",
		borderRadius: 15,
		padding: 10,
	},
});
