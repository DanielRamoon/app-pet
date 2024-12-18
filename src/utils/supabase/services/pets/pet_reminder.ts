import serviceResponse from "@utils/generics/serviceResponse";
import { supabase } from "@utils/supabase/client";
import { IServiceResponse } from "types/general";
import { Database } from "types/supabase";
import userService from "../user.service";
import { PostgrestError } from "@supabase/supabase-js";

export type IPetReminder = Database["public"]["Tables"]["pets_reminders"]["Row"];
type IPetReminderInsert = Database["public"]["Tables"]["pets_reminders"]["Insert"];
type IPetReminderUpdate = Database["public"]["Tables"]["pets_reminders"]["Update"];

interface ReminderContent {
	id: string;
	remember_when: Date;
	title: string;
}

export default {
	selectFields: `
    id,
	medicine_id,
    pet_id,
    text,
    description,
	triggered,
    remember_when,
    remember_again_in,
    name:pets(
      name
    )
	`,

	async getAllPetReminders(): Promise<IServiceResponse<IPetReminder[]>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		let query = supabase.from("pets_reminders").select(this.selectFields).eq("created_by", userAuthenticated.id);
		// .is("remember_again_in", null);

		const { data, error } = await query.select(this.selectFields);

		if (error)
			return serviceResponse.internalServerError({
				pgrest: error as PostgrestError,
			});

		return serviceResponse.success(data as unknown as IPetReminder[]);
	},

	async getPetReminderById(id: string): Promise<IServiceResponse<IPetReminder>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase.from("pets_reminders").select(this.selectFields).eq("id", id).single();

		if (error) return serviceResponse.internalServerError({ error });
		if (!data) return serviceResponse.notFound();
		return serviceResponse.success(data as unknown as IPetReminder);
	},

	async getPetReminderByMedicineId(mediceneId: number): Promise<IServiceResponse<IPetReminder>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase
			.from("pets_reminders")
			.select(this.selectFields)
			.eq("medicine_id", mediceneId)
			.single();

		if (error) return serviceResponse.internalServerError({ error });
		if (!data) return serviceResponse.notFound();
		return serviceResponse.success(data as unknown as IPetReminder);
	},

	async createPetReminder(reminder: IPetReminderInsert): Promise<IServiceResponse<IPetReminderInsert>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		reminder.created_by = userAuthenticated?.id;
		reminder.updated_by = userAuthenticated?.id;

		const { data, error } = await supabase.from("pets_reminders").insert([reminder]).select("*").single();

		if (error) return serviceResponse.internalServerError({ error });
		if (!data) return serviceResponse.notFound();

		return serviceResponse.success(data as unknown as IPetReminder);
	},

	async updatePetReminder(id: string, reminder: IPetReminderUpdate): Promise<IServiceResponse<IPetReminder>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		reminder.updated_by = userAuthenticated?.id;
		reminder.triggered = false;

		const { data, error } = await supabase.from("pets_reminders").update(reminder).eq("id", id).single();

		if (error) return serviceResponse.internalServerError({ error });
		if (!data) return serviceResponse.notFound();

		return serviceResponse.success(data);
	},

	async updatePetReminderName(mediceneId: number, newName: string): Promise<IServiceResponse<IPetReminder>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const reminder: IPetReminderUpdate = {};

		reminder.text = newName;

		const { data, error } = await supabase
			.from("pets_reminders")
			.update(reminder)
			.eq("medicine_id", mediceneId)
			.single();

		if (error) return serviceResponse.internalServerError({ error });
		if (!data) return serviceResponse.notFound();

		return serviceResponse.success(data);
	},

	async deletePetReminder(ids: string[] | ReminderContent[]): Promise<IServiceResponse<void>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const idArray = Array.isArray(ids) ? ids.map((item) => (typeof item === "string" ? item : item.id)) : ids;

		for (const id of idArray) {
			const { error } = await supabase.from("pets_reminders").delete().eq("id", id).single();

			if (error) {
				console.error(`Erro ao excluir o lembrete com ID ${id}: ${error.message}`);
			}
		}

		return serviceResponse.success();
	},

	async deletePetReminderMedicines(text: string, pet_id: string): Promise<IServiceResponse<void>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { error } = await supabase
			.from("pets_reminders")
			.delete()
			.eq("text", text)
			.eq("created_by", userAuthenticated.id)
			.eq("pet_id", pet_id)
			.neq("remember_again_in", null)
			.single();

		if (error) {
			console.error(`Erro ao excluir o lembrete: ${error.message}`);
		}

		return serviceResponse.success();
	},
};
