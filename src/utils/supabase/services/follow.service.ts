import { Database } from "types/supabase";
import { supabase } from "../client";
import userService from "./user.service";
import serviceResponse from "@utils/generics/serviceResponse";
import { IServiceResponse } from "../../../@types/general";

export type IUserFollow = Database["public"]["Tables"]["user_follows"]["Row"] & {
	requester_data?: Database["public"]["Tables"]["profiles"]["Row"];
	requested_data?: Database["public"]["Tables"]["profiles"]["Row"];
};

export default {
	async getUserFollows(
		page?: number,
		options?: { getUserData: boolean; all?: boolean; onlyMine?: boolean }
	): Promise<IServiceResponse<IUserFollow[]>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		let query = supabase
			.from("user_follows")
			.select(
				`id,
				requester,
				requested,
				accepted,
				created_at,
				updated_at
				${options?.getUserData ? ",requester_data:profiles!user_follows_requester_fkey(id, user_name, avatar_url)" : ""}
				${options?.getUserData ? ",requested_data:profiles!user_follows_requested_fkey(id, user_name, avatar_url)" : ""}`
			)
			.or(`requester.eq.${userAuthenticated.id},requested.eq.${userAuthenticated.id}`)
			// Order by request not accepted first
			.order("accepted", { ascending: true })
			.order("requested", { ascending: true });

		if (!options?.all) query = query.eq("accepted", false);
		// if (options?.onlyMine) query = query.eq("requested", userAuthenticated.id);

		if (page) query = query.order("created_at", { ascending: false }).range(page * 10, (page + 1) * 10 - 1);

		const { data, error } = await query;

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(data as unknown as IUserFollow[]);
	},

	async sendFollowRequest(requestedId: string): Promise<IServiceResponse<IUserFollow>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase
			.from("user_follows")
			.insert({
				requester: String(userAuthenticated.id),
				requested: requestedId,
				created_at: new Date().toISOString(),
				updated_at: new Date().toISOString(),
			})
			.single();

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(data);
	},

	async acceptFollowRequest(requesterId: string | number): Promise<IServiceResponse<IUserFollow>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase
			.from("user_follows")
			.update({
				accepted: true,
				updated_at: new Date().toISOString(),
			})
			.eq("requester", requesterId)
			.eq("requested", userAuthenticated.id)
			.single();

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(data);
	},

	async deleteFollowRequest(requesterId: string | number): Promise<IServiceResponse<IUserFollow>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase
			.from("user_follows")
			.delete()
			.eq("requester", requesterId)
			.eq("requested", userAuthenticated.id)
			.single();

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(data);
	},

	async deleteFollow(options: { requested?: string; requester?: string }): Promise<IServiceResponse<boolean>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { count, error, data, status } = await supabase
			.from("user_follows")
			.delete()
			.eq("requester", options.requester ?? userAuthenticated.id)
			.eq("requested", options.requested ?? userAuthenticated.id);

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(count && count > 0 ? true : false);
	},

	async getRequestedFollowsQty(): Promise<IServiceResponse<number>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase
			.from("user_follows")
			.select("requested")
			.eq("requested", userAuthenticated.id)
			.eq("accepted", false);

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(data?.length ?? 0);
	},
};
