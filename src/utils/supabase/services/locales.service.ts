import { supabase } from "../client";

export async function getCountries() {
	try {
		const { data, error } = await supabase.from("locale_countries").select("*");

		if (error) {
			return false;
		}
		return data;
	} catch (error) {
		return false;
	}
}

export async function getStates(country_id: string | number) {
	try {
		const { data, error } = await supabase.from("locale_states").select("*").eq("country_id", Number(country_id));

		if (error) {
			console.log(error);
			return false;
		}
		return data;
	} catch (error) {
		console.log(error);
		return false;
	}
}

export async function getCities(state_id: string | number) {
	try {
		const { data, error } = await supabase.from("locale_cities").select("*").eq("state_id", Number(state_id));

		if (error) {
			console.log(error);
			return false;
		}
		return data;
	} catch (error) {
		console.log(error);
		return false;
	}
}
