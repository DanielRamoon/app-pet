import Input from "@components/Wrappers/Input";
import PlatformButton from "@components/Wrappers/PlatformButton";
import WrappedSelect from "@components/Wrappers/Select";
import { Foundation } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import { Text } from "@ui-kitten/components";
import i18n from "@utils/i18n";
import { getCities, getCountries, getStates } from "@utils/supabase/services/locales.service";
import { Select } from "native-base";
import React, { useEffect, useState } from "react";
import { Alert, KeyboardAvoidingView, Platform, View } from "react-native";
import { IUserAddress } from "src/@types/User";
import { styles } from "./styles";

interface IProps {
	isFirstAccess?: boolean;
	initialValues?: Partial<IUserAddress>;
	onChange?: (address: IUserAddress) => void;
}

export default function UserAddress(props: IProps) {
	const colors = useColors();

	const [selectedCountry, setSelectedCountry] = useState<any>(null);
	const [selectedState, setSelectedState] = useState<any>(null);
	const [selectedCity, setSelectedCity] = useState<any>(null);

	const [countries, setCountries] = useState<any[]>([]);
	const [states, setStates] = useState<any[]>([]);
	const [cities, setCities] = useState<any[]>([]);

	const [change, setChange] = useState(props.initialValues?.country ? false : true);

	useEffect(() => {
		async function startup() {
			const countries = await getCountries();

			if (!countries) Alert.alert(i18n.get("error"), i18n.get("firstAccess.userInfo.error.countries"));
			else if (countries.length > 0) setCountries(countries);
		}

		startup();
	}, []);

	useEffect(() => {
		async function query() {
			if (!selectedCountry) return;

			const country_id = countries.find((country) => country.name === selectedCountry.name)?.id;

			const states = await getStates(country_id);
			if (!states) Alert.alert(i18n.get("error"), i18n.get("firstAccess.userInfo.error.states"));
			else if (states.length > 0) setStates(states);

			setSelectedState(null);
			setSelectedCity(null);
		}

		query();
	}, [selectedCountry]);

	useEffect(() => {
		async function query() {
			if (!selectedState) return;

			const state_id = states.find((state) => state.name === selectedState.name)?.id;

			const cities = await getCities(state_id);
			if (!cities) Alert.alert(i18n.get("error"), i18n.get("firstAccess.userInfo.error.cities"));
			else if (cities.length > 0) setCities(cities);
		}

		query();
	}, [selectedState]);

	useEffect(() => {
		if (!selectedCountry) return;
		// if (!selectedCity) return;
		// if (!selectedState) return;

		props.onChange &&
			props.onChange({
				country: selectedCountry?.name ?? null,
				state: selectedState?.name ?? null,
				city: selectedCity?.name ?? null,
			});
	}, [selectedCity, selectedState, selectedCountry]);

	return (
		<KeyboardAvoidingView behavior={Platform.OS === "ios" ? "padding" : "height"} style={{ flex: 1 }}>
			<View style={{ ...styles.card, paddingHorizontal: 15 }}>
				<View style={{ display: "flex", flexDirection: "row", alignItems: "center" }}>
					<Text category="h6" {...props}>
						{i18n.get("firstAccess.steps[2]")}
					</Text>
					{!props.isFirstAccess && (
						<PlatformButton
							onPress={() => setChange((change) => !change)}
							// useDefaultStyle
							style={{ marginTop: "auto", paddingRight: 10, paddingLeft: 10, paddingTop: 10, paddingBottom: 7 }}
							radius={15}
						>
							{change ? (
								<Foundation name="x" size={16} style={{ color: colors.text }} />
							) : (
								<Foundation name="pencil" size={16} style={{ color: colors.text }} />
							)}
						</PlatformButton>
					)}
				</View>

				{props.initialValues?.country && !change ? (
					<>
						<View style={styles.formControl}>
							<Input
								value={props.initialValues.country}
								isReadOnly
								isDisabled
								editable={false}
								label={i18n.get("firstAccess.userInfo.country")}
							/>
						</View>

						<View style={styles.formControl}>
							<Input
								value={props.initialValues.state}
								isReadOnly
								isDisabled
								editable={false}
								label={i18n.get("firstAccess.userInfo.state")}
							/>
						</View>

						<View style={styles.formControl}>
							<Input
								value={props.initialValues.city}
								isReadOnly
								isDisabled
								editable={false}
								label={i18n.get("firstAccess.userInfo.city")}
							/>
						</View>
					</>
				) : (
					<>
						<View style={styles.formControl}>
							<WrappedSelect
								accessibilityLabel={i18n.get("firstAccess.userInfo.country")}
								selectedValue={String(countries.indexOf(selectedCountry))}
								onValueChange={(contry) => {
									setSelectedCountry(countries[Number(contry)]);
								}}
								minWidth="full"
							>
								{countries.map((country, i) => (
									<Select.Item key={i} label={country.name} value={String(i)} />
								))}
							</WrappedSelect>
						</View>

						{states.length > 0 && (
							<View style={styles.formControl}>
								<WrappedSelect
									accessibilityLabel={i18n.get("firstAccess.userInfo.state")}
									selectedValue={String(states.indexOf(selectedState))}
									onValueChange={(state) => {
										setSelectedState(states[Number(state)]);
									}}
									minWidth="full"
								>
									{states.map((state, i) => (
										<Select.Item key={i} label={state.name} value={String(i)} />
									))}
								</WrappedSelect>
							</View>
						)}

						{cities.length > 0 && (
							<View style={styles.formControl}>
								<WrappedSelect
									accessibilityLabel={i18n.get("firstAccess.userInfo.city")}
									selectedValue={String(cities.indexOf(selectedCity))}
									onValueChange={(city) => {
										setSelectedCity(cities[Number(city)]);
									}}
									minWidth="full"
									_actionSheetBody={{
										windowSize: 5,
										onEndReachedThreshold: 0.2,
									}}
								>
									{cities.map((state, i) => (
										<Select.Item key={i} label={state.name} value={String(i)} />
									))}
								</WrappedSelect>
							</View>
						)}
					</>
				)}
			</View>
		</KeyboardAvoidingView>
	);
}
