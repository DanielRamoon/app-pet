import serviceResponse from "@utils/generics/serviceResponse";
import { supabase } from "@utils/supabase/client";
import { IServiceResponse } from "types/general";
import { Database } from "types/supabase";
import userService from "../user.service";

export enum eMedicineType {
	GENERIC_PRODUCT = 0,
	MEDICINE,
	ALL,
}

export type IPetHealthMedicines = Database["public"]["Tables"]["health_medicines"]["Row"] & { type: eMedicineType };
type IPetHealthMedicinesUpdate = Omit<
	Partial<Database["public"]["Tables"]["health_medicines"]["Row"]>,
	"id" | "health_id" | "created_at" | "updated_at"
>;

export default {
	selectFields: `
		id,
		health_id,
		description,
		amount,
		dose,
		created_at,
		updated_at,
		medication_start,
		medication_end
	`,

	async createPetHealthMedicines(body: IPetHealthMedicines): Promise<IServiceResponse<IPetHealthMedicines>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		body.created_by = userAuthenticated?.id!;
		body.updated_by = userAuthenticated?.id!;

		const { data, error } = await supabase
			.from("health_medicines")
			.insert({ ...body, created_at: new Date().toISOString(), updated_at: new Date().toISOString() })
			.select(this.selectFields)
			.single<IPetHealthMedicines>();

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(data);
	},

	async getPetHealthMedicines(name: string, id: string): Promise<IServiceResponse<IPetHealthMedicines[]>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase
			.from("health_medicines")
			.select("description")
			.eq("description", name)
			.eq("health_id", id)
			.eq("created_by", userAuthenticated.id);

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(data as unknown as IPetHealthMedicines[]);
	},

	async getPetHealthMedicine(id: number): Promise<IServiceResponse<IPetHealthMedicines>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase
			.from("health_medicines")
			.select(this.selectFields)
			.eq("id", id)
			.eq("created_by", userAuthenticated.id);

		if (error) return serviceResponse.internalServerError({ error });

		// Ensure data contains exactly one item
		if (data && data.length === 1) {
			return serviceResponse.success(data[0] as unknown as IPetHealthMedicines);
		}

		// Handle cases where no items or multiple items are returned
		return serviceResponse.internalServerError({ error: "Unexpected number of items returned" });
	},

	async updatePetHealthMedicines(
		medicineId: number,
		body: IPetHealthMedicinesUpdate,
		healthId?: string
	): Promise<IServiceResponse<IPetHealthMedicines>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		if (body.created_by) delete body.created_by;

		// Adiciona healthId ao objeto de atualização se ele estiver presente
		const updateData: any = {
			...body,
			updated_at: new Date().toISOString(),
			updated_by: userAuthenticated?.id!,
		};
		if (healthId) {
			updateData.health_id = healthId;
		}

		const { data, error } = await supabase
			.from("health_medicines")
			.update(updateData)
			.eq("id", medicineId)
			.select(this.selectFields)
			.single<IPetHealthMedicines>();

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(data);
	},

	async deletePetHealthMedicines(medicineId: number): Promise<IServiceResponse<IPetHealthMedicines>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase
			.from("health_medicines")
			.delete()
			.eq("id", medicineId)
			.select(this.selectFields)
			.single<IPetHealthMedicines>();

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(data);
	},
};
