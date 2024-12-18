import { Database } from "types/supabase";
import { supabase } from "../client";
import userService from "./user.service";
import serviceResponse from "@utils/generics/serviceResponse";
import { IServiceResponse } from "../../../@types/general";

export type Place = Database["public"]["Tables"]["places"]["Insert"];

export default {
	async getPlacesByCityNStateNType(cityState: string, placeType: string): Promise<IServiceResponse<Place[]>> {
		const { data, error } = await supabase
			.from("places")
			.select("*")
			.eq("address_location", cityState)
			.eq("place_type", placeType)
			.eq("approved", true)
			.order("id", { ascending: true });

		if (error) return serviceResponse.internalServerError({ pgrest: error });

		return serviceResponse.success(data);
	},

	async createPlace(place: Place): Promise<IServiceResponse<Place>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase
			.from("places")
			.insert({ ...place, requested_by: userAuthenticated.id! })
			.single();

		if (error) return serviceResponse.internalServerError({ pgrest: error });

		return serviceResponse.created(data);
	},
};
