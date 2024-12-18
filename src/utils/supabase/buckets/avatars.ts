import userService from "@utils/supabase/services/user.service";
import { supabase } from "../client";
import { decode } from "base64-arraybuffer";
import serviceResponse from "@utils/generics/serviceResponse";
import { IServiceResponse } from "types/general";

export default {
	async updateUserAvatar(image: File | string): Promise<IServiceResponse<string>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase.storage
			.from("avatars")
			.upload(`/${userAuthenticated.id}.png`, typeof image === "string" ? decode(image) : image, {
				upsert: true,
				contentType: "image/png",
			});

		if (error) return serviceResponse.badRequest({ error });
		if (!data) return serviceResponse.internalServerError({ error: "No data returned" });

		return serviceResponse.success(data.path);
	},

	async deleteUserAvatar(): Promise<IServiceResponse<unknown>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase.storage.from("avatars").remove([`/${userAuthenticated.id}.png`]);

		if (error) return serviceResponse.badRequest({ error });

		return serviceResponse.success(data);
	},

	getUserAvatarById(userId: string): IServiceResponse<string> {
		return serviceResponse.success(supabase.storage.from("avatars").getPublicUrl(`/${userId}.png`).data.publicUrl);
	},

	async getUserAvatar(userId?: string): Promise<IServiceResponse<string>> {
		if (userId)
			return serviceResponse.success(supabase.storage.from("avatars").getPublicUrl(`/${userId}.png`).data.publicUrl);

		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data } = supabase.storage.from("avatars").getPublicUrl(`/${userAuthenticated.id}.png`);

		if (!data) return serviceResponse.internalServerError({ error: "No data returned" });

		return serviceResponse.success(data.publicUrl);
	},
};
