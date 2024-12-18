import userService from "@utils/supabase/services/user.service";
import { supabase } from "../client";
import { decode } from "base64-arraybuffer";
import serviceResponse from "@utils/generics/serviceResponse";
import { IServiceResponse } from "types/general";
import { isNullOrEmpty } from "@utils/utilities";
import environment from "environment";

export default {
	async updatePetPhoto(petId: string, image: File | string): Promise<IServiceResponse<string>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		if (isNullOrEmpty(petId) || !petId) return serviceResponse.badRequest({ error: "Pet ID is required" });

		const { data, error } = await supabase.storage
			.from("pets")
			.upload(`/photos/${userAuthenticated.id}/${petId}.png`, typeof image === "string" ? decode(image) : image, {
				upsert: true,
				contentType: "image/png",
			});

		if (error) return serviceResponse.badRequest({ error });
		if (!data) return serviceResponse.internalServerError({ error: "No data", data });

		return serviceResponse.success(data.path);
	},

	async deletePetPhoto(): Promise<IServiceResponse<unknown>> {
		const { data: userAuthenticated } = await userService.authenticatedUser();
		if (!userAuthenticated?.authenticated) return serviceResponse.unauthorized();

		const { data, error } = await supabase.storage.from("pet_photos").remove([`/${userAuthenticated.id}.png`]);

		if (error) return serviceResponse.badRequest({ error });

		return serviceResponse.success(data);
	},

	/**
	 * Retrieves the URL of a pet's photo based on the provided petId and ownerId. If none is provided, the default pet image placeholder is returned.
	 *
	 * @function
	 * @param {string} petId - The ID of the pet. Optional.
	 * @param {string} ownerId - The ID of the owner. Optional.
	 * @returns {IServiceResponse<string>} - An object representing the service response with the URL of the pet's photo.
	 *
	 * @example
	 * // Example usage:
	 * const photoUrl = getPetPhoto("123", "12");
	 * console.log(photoUrl); // '{bucket_url}/pets/photos/456/123.png?rel=4'
	 *
	 * @example
	 * // Example usage without information required to retrieve the pet's photo:
	 * const photoUrl = getPetPhoto().data;
	 * console.log(photoUrl); // '{bucket_url}/pets/default-pet-image.png'
	 */
	getPetPhoto(petId?: string | number, ownerId?: string | number): IServiceResponse<string> {
		const defaultPetImage = serviceResponse.success(
			`${
				environment.PUBLIC_STORAGE_BASE_URL ?? "https://jklzegiejeiaiopibomo.supabase.co/storage/v1/object/public"
			}/pets/default-pet-image.png`
		);

		if ((typeof petId === "string" && isNullOrEmpty(petId)) || !petId) return defaultPetImage;

		return serviceResponse.success(
			`${
				environment.PUBLIC_STORAGE_BASE_URL ?? "https://jklzegiejeiaiopibomo.supabase.co/storage/v1/object/public"
			}/pets/photos/${ownerId}/${petId}.png?rel=${Date.now().toString().slice(5, 6)}`
		);
	},
};
