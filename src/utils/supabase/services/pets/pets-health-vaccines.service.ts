import serviceResponse from "@utils/generics/serviceResponse";
import { supabase } from "@utils/supabase/client";
import { IServiceResponse } from "types/general";
import { Database } from "types/supabase";
import userService from "../user.service";

export type IPetHealthVaccines = Database["public"]["Tables"]["health_vaccines"]["Row"];
type IPetHealthVaccinesUpdate = Omit<
	Partial<Database["public"]["Tables"]["health_vaccines"]["Row"]>,
	"id" | "health_id" | "created_at" | "doses" | "updated_at"
>;

export type IPetHealthVaccinesDoses = Database["public"]["Tables"]["vaccines_doses"]["Row"];

export default {
	selectFields: `
		id,
		health_id,
		description,
		doses:vaccines_doses(
			id,
			dose,
			injection_date
		)
	`,

	async createVaccine(healthId: string, vaccine: IPetHealthVaccines): Promise<IServiceResponse<IPetHealthVaccines>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		vaccine.created_by = userAuthenticated?.id!;
		vaccine.updated_by = userAuthenticated?.id!;

		const { data, error } = await supabase
			.from("health_vaccines")
			.insert({
				...vaccine,
				health_id: healthId,
				created_at: new Date().toISOString(),
			})
			.select(this.selectFields)
			.single<IPetHealthVaccines>();

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(data);
	},

	async updateVaccine(
		vaccineId: string,
		vaccine: IPetHealthVaccinesUpdate
	): Promise<IServiceResponse<IPetHealthVaccines>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		if (vaccine.created_by) delete vaccine.created_by;

		const { data, error } = await supabase
			.from("health_vaccines")
			.update({
				...vaccine,
				// updated_at: new Date().toISOString(),
				updated_by: userAuthenticated?.id!,
			})
			.eq("id", vaccineId)
			.select(this.selectFields)
			.single<IPetHealthVaccines>();

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(data);
	},

	async deleteVaccine(vaccineId: string): Promise<IServiceResponse<boolean>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { error } = await supabase.from("health_vaccines").delete().eq("id", vaccineId).single();

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(true);
	},

	async createVaccineDose(
		vaccineId: string,
		dose: Partial<IPetHealthVaccinesDoses>
	): Promise<IServiceResponse<boolean>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { error } = await supabase.from("vaccines_doses").insert({
			...dose,
			vaccine_id: vaccineId,
			created_at: new Date().toISOString(),
			created_by: userAuthenticated?.id!,
			updated_at: new Date().toISOString(),
			updated_by: userAuthenticated?.id!,
		});

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(true);
	},

	async updateVaccineDose(
		doseId: string,
		dose: IPetHealthVaccinesDoses
	): Promise<IServiceResponse<IPetHealthVaccinesDoses>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase
			.from("vaccines_doses")
			.update({ ...dose, updated_at: new Date().toISOString(), updated_by: userAuthenticated?.id! })
			.eq("id", doseId)
			.select(this.selectFields)
			.single<IPetHealthVaccinesDoses>();

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(data);
	},

	async deleteVaccineDose(params: {
		doseId?: string;
		date?: string;
	}): Promise<IServiceResponse<IPetHealthVaccinesDoses>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase
			.from("vaccines_doses")
			.delete()
			.eq(params.doseId ? "id" : "injection_date", params.doseId! ?? params.date!)
			.single<IPetHealthVaccinesDoses>();

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(data);
	},
};
