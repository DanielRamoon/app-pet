import serviceResponse from "@utils/generics/serviceResponse";
import { supabase } from "@utils/supabase/client";
import { IServiceResponse } from "types/general";
import { Database } from "types/supabase";
import userService from "../user.service";
import { eMedicineType } from "./pets-health-medicines.service";

export type IPetHealth = Database["public"]["Tables"]["pets_health"]["Row"];
type IPetHealthUpdate = Omit<
	Partial<Database["public"]["Tables"]["pets_health"]["Row"]>,
	"id" | "pet_id" | "created_at" | "medicines" | "vaccines"
>;

export default {
	selectFields: `
		id,
		pet_id,
		height,
		length,
		weight,
		created_at,
		updated_at,
		medicines:health_medicines(
			id,
			description,
			amount,
			health_id,
			dose,
			type,
			created_at,
		    medication_start,
		    medication_end
		),
		vaccines:health_vaccines(
			id,
			description,
			doses:vaccines_doses(
				dose,
				injection_date
			),
			created_at
		)
	`,

	async getPetHealthDetails(petId: string, type?: eMedicineType): Promise<IServiceResponse<IPetHealth>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const query = supabase.from("pets_health").select(this.selectFields).eq("pet_id", petId);

		if (type !== eMedicineType.ALL && type) {
			query.eq("health_medicines.type", type);
		}

		const { data, error } = await query.single<IPetHealth>();

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(data);
	},

	async getPetHealthId(petId: string): Promise<IServiceResponse<string>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const query = supabase.from("pets_health").select(this.selectFields).eq("pet_id", petId);

		const { data, error } = await query.single<IPetHealth>();

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(data.id);
	},

	async updatePetHealth(petId: string, body: IPetHealthUpdate): Promise<IServiceResponse<IPetHealth>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		body.updated_by = userAuthenticated?.id;

		const { data, error } = await supabase
			.from("pets_health")
			.update(body)
			.eq("pet_id", petId)
			.select(this.selectFields)
			.single<IPetHealth>();

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(data);
	},
};
