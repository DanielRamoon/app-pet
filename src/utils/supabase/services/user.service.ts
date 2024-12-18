import { supabase } from "../client";
import { Database } from "types/supabase";
import { DateTime } from "luxon";
import { IServiceResponse } from "types/general";
import serviceResponse from "@utils/generics/serviceResponse";
import avatars from "../buckets/avatars";

export type IUser = Database["public"]["Tables"]["profiles"]["Row"];
type IUserUpdate = Partial<Database["public"]["Tables"]["profiles"]["Row"]>;

interface IAuthenticatedUserResponse {
	id: string;
	authenticated: boolean;
}

export default {
	async authenticatedUser(): Promise<IServiceResponse<IAuthenticatedUserResponse>> {
		const { data: userData } = await supabase.auth.getUser();

		return serviceResponse.success({
			id: userData?.user?.id!,
			authenticated: !!userData?.user?.id,
		});
	},

	async updateUserProfile(data: IUserUpdate): Promise<IServiceResponse<IUser>> {
		const { data: userAuthenticated } = await this.authenticatedUser();

		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const safeData: IUserUpdate = {
			...data,
			updated_at: DateTime.now().toISO(),
			disabled: false,
		};

		const { data: updatedUser, error } = await supabase
			.from("profiles")
			.update(safeData)
			.eq("id", userAuthenticated.id)
			.eq("disabled", false)
			.select("*")
			.single();

		if (error)
			return serviceResponse.internalServerError({
				error,
			});

		return serviceResponse.success(updatedUser);
	},

	async getUserName(id: string): Promise<IServiceResponse<{userName: (string | null), fullName: (string | null)}>> {
		const { data, error } = await supabase.from("profiles").select("user_name, full_name").eq("id", id).single();

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success({ userName: data?.user_name, fullName: data?.full_name});
	},

	async getLoggedUserProfile(specificField?: string): Promise<IServiceResponse<Partial<IUser>>> {
		const { data: userAuthenticated } = await this.authenticatedUser();

		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = (await supabase
			.from("profiles")
			.select(specificField ?? "*")
			.eq("id", userAuthenticated.id)
			.eq("disabled", false)
			.single()) as any;

		if (error) return serviceResponse.internalServerError({ error });
		if (specificField) return serviceResponse.success(data);

		if (!data.avatar_url?.includes("http")) {
			data.avatar_url = supabase.storage.from("avatars").getPublicUrl(`${data.id}.png`).data.publicUrl;
		}

		return serviceResponse.success(data);
	},

	async isUserFirstAccess(): Promise<IServiceResponse<boolean>> {
		const { data: userAuthenticated } = await this.authenticatedUser();

		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase.from("profiles").select("completed").eq("id", userAuthenticated.id).single();

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(!data?.completed, {}, [
			!data?.completed ? "User hasn't completed it's first access" : "User has completed it's first access",
		]);
	},

	async isUsernameAvailable(username: string): Promise<IServiceResponse<boolean>> {
		const { data: userAuthenticated } = await this.authenticatedUser();

		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase.from("profiles").select("id").eq("user_name", username).limit(1);

		if (error) return serviceResponse.internalServerError({ error });

		if (data[0]?.id === userAuthenticated.id) return serviceResponse.success(true);

		return serviceResponse.success(!data[0]?.id, {}, [
			!data[0]?.id ? "Username is available" : "Username is not available",
		]);
	},

	async getUsers(username: string, page = 0, isUserId = false): Promise<IServiceResponse<Partial<IUser>[]>> {
		if (username) username = username.toLowerCase();

		const { data: userAuthenticated } = await this.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		if (isUserId) {
			const { data, error } = await supabase
				.from("profiles")
				.select("id,user_name,avatar_url")
				.eq("id", username)
				.limit(1);
			if (error) return serviceResponse.internalServerError({ error });

			return serviceResponse.success(data);
		}

		const { data, error } = await supabase
			.from("profiles")
			.select("id,user_name,avatar_url")
			.or(`or(user_name.ilike.%${username}%),or(full_name.ilike.%${username}%)`)
			.eq("private", false)
			.order("user_name", { ascending: true })
			.range(page * 10, (page + 1) * 10 - 1);

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(data);
	},

	async setUserExpoPushToken(token: string): Promise<IServiceResponse<boolean>> {
		const { data: userAuthenticated } = await this.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		// Get user current settings
		const { data: userSettings, error: userSettingsError } = await supabase
			.from("profiles")
			.select("settings")
			.eq("id", userAuthenticated.id)
			.single();

		if (userSettingsError) return serviceResponse.internalServerError({ error: userSettingsError });

		const settings = (userSettings?.settings as Record<string, any>) ?? {};

		// Validate if is necessary to update the token
		if (settings?.exponent_push_token === token) return serviceResponse.success(true);

		const { error } = await supabase
			.from("profiles")
			.update({
				settings: {
					...settings,
					exponent_push_token: token,
				},
			})
			.eq("id", userAuthenticated.id);

		if (error) return serviceResponse.internalServerError({ error });

		return serviceResponse.success(true);
	},
};
