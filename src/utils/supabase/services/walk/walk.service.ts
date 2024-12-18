import serviceResponse from "@utils/generics/serviceResponse";
import { IServiceResponse } from "types/general";
import { Database } from "types/supabase";
import userService from "../user.service";
import { supabase } from "@utils/supabase/client";
import { petProps } from "types/pets";

export type IPetWalk = Database["public"]["Tables"]["pets_walks"]["Row"];

export default {
	selectFields: `
		id,
		pet_id,
		created_by,
		updated_by,
		total_distance,
		date_start,
		date_end,
		duration
	`,

	async saveWalk(walk: Partial<IPetWalk> & { petIds?: Array<string> }): Promise<IServiceResponse<Array<IPetWalk>>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		walk.created_by = userAuthenticated?.id!;
		walk.updated_by = userAuthenticated?.id!;

		if (!walk.petIds) return serviceResponse.badRequest({ message: "No pet data provided" });

		const petIds: string[] = walk.petIds;

		const savedWalks: IPetWalk[] = [];
		const errors: any[] = [];

		for (const petId of petIds) {
			const walkCopy = { ...walk, pet_id: petId };
			delete walkCopy.petIds;

			console.log("SAVING WALK");
			console.log(walkCopy);

			const { data, error } = await supabase
				.from("pets_walks")
				.insert(walkCopy as any)
				.select()
				.single<IPetWalk>();

			if (error) errors.push(error);
			else savedWalks.push(data!);
		}

		if (errors.length > 0) return serviceResponse.internalServerError({ errors });
		else return serviceResponse.success(savedWalks as any);
	},

	async deleteWalk(id: string): Promise<IServiceResponse<IPetWalk>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase.from("pets_walks").delete().match({ id }).select().single<IPetWalk>();

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(data);
	},

	async countWalks(petIds: string[] | number[]): Promise<IServiceResponse<number>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase.from("pets_walks").select("id", { count: "exact" }).in("pet_id", petIds);

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(data?.length);
	},

	async getWalks(petIds: string[] | number[], page = 0): Promise<IServiceResponse<IPetWalk[]>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase
			.from("pets_walks")
			.select()
			.in("pet_id", petIds)
			.order("date_start", { ascending: false })
			.range(page * 10, (page + 1) * 10 - 1);

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(data);
	},

	// async getFriendsWalks(page = 0): Promise<IServiceResponse<any[]>> {
	// 	const { data: userAuthenticated } = await userService.authenticatedUser();
	// 	if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

	// 	const { data: friendsIds, error: friendsError } = await supabase
	// 		.from("user_follows")
	// 		.select("requested")
	// 		.eq("requester", userAuthenticated?.id!)
	// 		.eq("accepted", true);

	// 	const { data, error } = await supabase
	// 		.from("pets_walks")
	// 		.select(this.selectFields)
	// 		.in(
	// 			"created_by",
	// 			(friendsIds ?? []).map((friend) => friend.requested as string)
	// 		)
	// 		.order("date_start", { ascending: false })
	// 		.range(page * 10, (page + 1) * 10 - 1);

	// 	if (error) return serviceResponse.internalServerError({ error });

	// 	data.map((walk: any) => {
	// 		delete walk.distance;
	// 	});

	// 	return serviceResponse.success(data);
	// },

	async getFriendsWalks(): Promise<IServiceResponse<any[]>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data: friendsIds, error: friendsError } = await supabase
			.from("user_follows")
			.select("requested")
			.eq("requester", userAuthenticated?.id!)
			.eq("accepted", true);

		const { data, error } = await supabase
			.from("pets_walks")
			.select(this.selectFields)
			.in(
				"created_by",
				(friendsIds ?? []).map((friend) => friend.requested as string)
			)
			.order("date_start", { ascending: false });

		if (error) return serviceResponse.internalServerError({ error });

		data.map((walk: any) => {
			delete walk.distance;
		});

		return serviceResponse.success(data);
	},

	async walksLikes(walkId: string): Promise<any> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const likeInfos = {
			user_id: userAuthenticated.id,
			walk_id: walkId,
		};

		const { data, error } = await supabase
			.from("walks_likes")
			.insert(likeInfos as any)
			.select()
			.single();

		if (error) return serviceResponse.internalServerError({ error });
		else serviceResponse.success(data);
	},

	async walkDeslike(walkId: string): Promise<any> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const likeInfos = {
			user_id: userAuthenticated.id,
			walk_id: walkId,
		};

		const { data, error } = await supabase
			.from("walks_likes")
			.delete(likeInfos as any)
			.eq("user_id", userAuthenticated.id)
			.eq("walk_id", walkId)
			.single();

		if (error) return serviceResponse.internalServerError({ error });
		else return serviceResponse.success(data);
	},

	async checkLikeExists(walkId: string) {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase
			.from("walks_likes")
			.select("*")
			.eq("user_id", userAuthenticated.id)
			.eq("walk_id", walkId);

		if (error) return serviceResponse.internalServerError({ error });
		else return serviceResponse.success(data);
	},

	async getMyWalksLikes(walkId: string): Promise<any> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase.from("walks_likes").select("*").eq("walk_id", walkId);

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(data);
	},

	// async getMyWalks(page = 0): Promise<IServiceResponse<any[]>> {
	// 	const { data: userAuthenticated } = await userService.authenticatedUser();
	// 	if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

	// 	const { data, error } = await supabase
	// 		.from("pets_walks")
	// 		.select(this.selectFields)
	// 		.in("created_by", [userAuthenticated.id as string])
	// 		.order("date_start", { ascending: false })
	// 		.range(page * 10, (page + 1) * 10 - 1);

	// 	if (error) return serviceResponse.internalServerError({ error });

	// 	data.map((walk: any) => {
	// 		delete walk.distance;
	// 	});

	// 	return serviceResponse.success(data);
	// },

	async getMyWalks(): Promise<IServiceResponse<any[]>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase
			.from("pets_walks")
			.select(this.selectFields)
			.in("created_by", [userAuthenticated.id as string])
			.order("date_start", { ascending: false });

		if (error) return serviceResponse.internalServerError({ error });

		data.map((walk: any) => {
			delete walk.distance;
		});

		return serviceResponse.success(data);
	},

	async getLastWalk(petId: string | number): Promise<IServiceResponse<IPetWalk>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase
			.from("pets_walks")
			.select()
			.eq("pet_id", petId)
			.order("date_start", { ascending: false })
			.range(0, 1);

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(data?.[0]);
	},
};
