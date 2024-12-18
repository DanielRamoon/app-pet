import { Database } from "types/supabase";
import { supabase } from "../../client";
import { IServiceResponse } from "types/general";
import userService from "../user.service";
import serviceResponse from "@utils/generics/serviceResponse";
import { PostgrestError } from "@supabase/supabase-js";
import { isNullOrEmpty } from "@utils/utilities";

export type IPet = Database["public"]["Tables"]["pets"]["Row"];
type IPetUpdate = Omit<
	Partial<Database["public"]["Tables"]["pets"]["Row"]>,
	"id" | "user_id" | "created_at" | "updated_at" | "deleted_at" | "health" | "breed"
>;

export default {
	/**
	 * Select fields to be returned by the queries to the database
	 *
	 * @type {string}
	 */
	selectFields: `
		id,
		user_id,
		birth_date,
		gender,
		has_stud_book,
		name,
		type,
		created_at,
		updated_at,
		deleted_at,
		breed,
		health:pets_health(
			height,
			length,
			weight,
			medicines:health_medicines(
				description,
				amount,
				dose
			),
			vaccines:health_vaccines(
				description,
				doses:vaccines_doses(
					dose,
					injection_date
				)
			)
		),
		walks:pets_walks(
			total_distance,
			date_start,
			date_end,
			duration
		)
	`,

	async getPetsMetadata(): Promise<{ q: number; ids: string[] | number[] }> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return { q: 0, ids: [] };

		const { data, messages } = await this.getPets("asc");

		if (messages) throw new Error(messages[0]);

		return { q: data?.length ?? 0, ids: data?.map((pet) => pet.id) ?? [] };
	},

	async getPetName(id: string): Promise<IServiceResponse<string>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase
			.from("pets")
			.select("name")
			.eq("id", id)
			// .eq("user_id", userAuthenticated.id)
			.single();

		if (error) return serviceResponse.internalServerError({ pgrest: error });

		return serviceResponse.success(data?.name);
	},

	async getPets(
		sort: "asc" | "desc" = "asc",
		searchQuery?: string,
		includeDeleted = false
	): Promise<IServiceResponse<IPet[]>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		let query = supabase
			.from("pets")
			.select(this.selectFields)
			.order("name", { ascending: sort === "asc" })
			.eq("user_id", userAuthenticated.id);

		if (!includeDeleted) query.is("deleted_at", null);
		if (!isNullOrEmpty(searchQuery)) query.ilike("name", `%${searchQuery}%`);

		const { data, error } = await query.select(this.selectFields);

		if (error)
			return serviceResponse.internalServerError({
				pgrest: error as PostgrestError,
			});

		return serviceResponse.success(data as unknown as IPet[]);
	},

	async getPet(id: string, includeDeleted = false): Promise<IServiceResponse<IPet>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		let query = supabase.from("pets").select(this.selectFields).eq("id", id).eq("user_id", userAuthenticated.id);

		if (!includeDeleted) query.is("deleted_at", null);

		const { data, error } = await query.select("*").single();

		if (error)
			return serviceResponse.internalServerError({
				pgrest: error,
			});

		return serviceResponse.success(data);
	},

	async getPetByName(name: string): Promise<IServiceResponse<IPet[]>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase
			.from("pets")
			.select("name")
			.eq("name", name)
			.eq("user_id", userAuthenticated.id);

		if (error)
			return serviceResponse.internalServerError({
				pgrest: error,
			});

		return serviceResponse.success(data as IPet[]);
	},

	async createPet(data: IPet): Promise<IServiceResponse<IPet>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		data.created_by = userAuthenticated.id;
		data.updated_by = userAuthenticated.id;

		const { data: createdPet, error } = await supabase
			.from("pets")
			.insert({ ...data, user_id: userAuthenticated.id })
			.select("*")
			.single();

		console.log(error);

		if (error) return serviceResponse.internalServerError({ pgrest: error });

		return serviceResponse.success(createdPet);
	},

	async updatePet(id: string, data: IPetUpdate): Promise<IServiceResponse<IPet>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		data.updated_by = userAuthenticated.id;

		if (data?.created_by) delete data.created_by;

		const { data: updatedPet, error } = await supabase
			.from("pets")
			.update({ ...data, user_id: userAuthenticated.id, updated_at: new Date().toISOString() })
			.eq("id", id)
			.eq("user_id", userAuthenticated.id)
			.select(this.selectFields)
			.single<IPet>();

		if (error) return serviceResponse.internalServerError({ pgrest: error });

		return serviceResponse.success(updatedPet);
	},

	async deletePet(id: string): Promise<IServiceResponse<IPet>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data: deletedPet, error } = await supabase
			.from("pets")
			.update({ deleted_at: new Date().toISOString(), updated_at: new Date().toISOString() })
			.eq("id", id)
			.eq("user_id", userAuthenticated.id)
			.select(this.selectFields)
			.single<IPet>();

		if (error) return serviceResponse.internalServerError({ pgrest: error });

		return serviceResponse.success(deletedPet);
	},

	async deletePets(ids: string[]): Promise<IServiceResponse<IPet[]>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data: deletedPets, error } = await supabase
			.from("pets")
			.update({
				deleted_at: new Date().toISOString(),
				updated_at: new Date().toISOString(),
				updated_by: userAuthenticated.id,
			})
			.in("id", ids)
			.eq("user_id", userAuthenticated.id)
			.select(this.selectFields);

		if (error) return serviceResponse.internalServerError({ pgrest: error });

		return serviceResponse.success(deletedPets as any);
	},

	async deletePetPermanently(id: string): Promise<IServiceResponse<IPet>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data: deletedPet, error } = await supabase
			.from("pets")
			.delete()
			.eq("id", id)
			.eq("user_id", userAuthenticated.id)
			.select(this.selectFields)
			.single<IPet>();

		if (error) return serviceResponse.internalServerError({ pgrest: error });

		return serviceResponse.success(deletedPet);
	},

	async restorePet(id: string): Promise<IServiceResponse<IPet>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data: restoredPet, error } = await supabase
			.from("pets")
			.update({ deleted_at: null, updated_at: new Date().toISOString(), updated_by: userAuthenticated.id })
			.not("deleted_at", "is", null)
			.eq("id", id)
			.eq("user_id", userAuthenticated.id)
			.select(this.selectFields)
			.single<IPet>();

		if (error) return serviceResponse.internalServerError({ pgrest: error });

		return serviceResponse.success(restoredPet);
	},
};
