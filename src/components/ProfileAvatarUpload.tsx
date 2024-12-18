import { Foundation } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import i18n from "@utils/i18n";
import avatars from "@utils/supabase/buckets/avatars";
import { supabase } from "@utils/supabase/client";
import { getRandomHexColor } from "@utils/utilities";
import env from "environment";
import { Image } from "expo-image";
import { SaveFormat, manipulateAsync } from "expo-image-manipulator";
import * as ImagePicker from "expo-image-picker";
import React, { useCallback, useEffect, useState } from "react";
import { ActivityIndicator, Alert, Dimensions, StyleSheet, TouchableOpacity, View } from "react-native";
import { IProps } from "types/User";

const generateAvatar = (initials: string) => {
	return `${
		env.UIAVATARS_URL ?? "https://ui-avatars.com/api/"
	}?name=${initials}&size=256&rounded=true&background=${getRandomHexColor({
		removeHash: true,
	})}&color=ffffff&format=png`;
};

export default function ProfileAvatarUpload(props: IProps) {
	const [image, setImage] = useState<string>("");
	const [loadingImage, setLoadingImage] = useState<boolean>(false);

	const colors = useColors();

	useEffect(() => {
		const startup = async () => {
			if (!props.initialImage) {
				const { data } = await supabase.auth.getUser();
				if (data.user && data.user?.email) {
					const image = generateAvatar(data.user.email[0] + data.user.email[1]);
					setImage(image);

					props.onImageChange(image);
				}
			}
		};

		startup();
	}, []);

	useEffect(() => {
		if (props.initialImage) setImage(props.initialImage ?? "");
	}, [props.initialImage]);

	const pickImage = useCallback(async () => {
		const result = await ImagePicker.launchImageLibraryAsync({
			mediaTypes: ImagePicker.MediaTypeOptions.Images,
			allowsEditing: true,
			aspect: [500, 500],
			quality: 1,
			base64: true,
		});

		if (!result.canceled && result.assets && result.assets[0] && result.assets[0].base64) {
			setLoadingImage(true);

			try {
				const compressedImage = await manipulateAsync(
					`data:image/png;base64,${result.assets[0].base64}`,
					[{ resize: { width: 500, height: 500 } }],
					{
						compress: 0,
						format: SaveFormat.PNG,
						base64: true,
					}
				);

				const uploaded = await avatars.updateUserAvatar(String(compressedImage.base64));

				if (!uploaded.data) return Alert.alert(i18n.get("error"), i18n.get("errorUploadingImage"));
				props.onImageChange(uploaded.data);

				setImage(`data:image/png;base64,${String(compressedImage.base64)}`);
			} catch (error) {
			} finally {
				setLoadingImage(false);
			}
		}
	}, [props.onImageChange]);

	const removeImage = async () => {
		const { data } = await supabase.auth.getUser();

		try {
			await avatars.deleteUserAvatar();
		} catch (error) {}

		if (data.user && data.user?.email) {
			const url = generateAvatar(data.user.email[0] + data.user.email[1]);
			setImage(url);
			props.onImageChange(url);
		} else {
			setImage("");
			props.onImageChange("");
		}
	};

	const getImageData = useCallback(() => {
		if (image === "" || image === null || image === undefined) return undefined;

		let uri = "";

		if (image.includes("data:image/png;base64,") || image.includes("http")) uri = image;
		else uri = String(avatars.getUserAvatarById(image.split(".png")[0]).data) + "?q=" + Date.now();

		return {
			uri,
		};
	}, [image]);

	return (
		<View
			style={[styles.card, { flex: props.compact ? 0 : 1, width: props.compact ? "auto" : "100%" }, props.style]}
			// header={(props) => (
			// 	<Text category="h6" {...props}>
			// 		{i18n.get("firstAccess.steps[0]")}
			// 	</Text>
			// )}
		>
			<TouchableOpacity
				onPress={() =>
					Alert.alert(
						i18n.get("imageInstantReplace"),
						i18n.get("imageInstantReplaceDescription"),
						[{ text: i18n.get("ok"), onPress: pickImage, style: "default" }],
						{ cancelable: true }
					)
				}
				onLongPress={removeImage}
				style={{ display: "flex", justifyContent: "center", alignItems: "center", marginTop: 0 }}
				disabled={props.disabled}
			>
				{loadingImage ? (
					<ActivityIndicator
						color={colors.primary}
						size="large"
						style={{
							width: props.compact ? 100 : 150,
							height: props.compact ? 100 : 150,
							marginLeft: "auto",
							marginRight: "auto",
						}}
					/>
				) : (
					<Image
						style={{
							width: props.compact ? 100 : 150,
							height: props.compact ? 100 : 150,
							borderRadius: 150,
							marginTop: "auto",
						}}
						contentFit="cover"
						source={getImageData()}
						cachePolicy="none"
						priority="high"
					/>
				)}
			</TouchableOpacity>

			{!props.compact && !loadingImage && (
				<View
					style={{
						position: "absolute",
						bottom: 10,
						right: Dimensions.get("window").width / 2 - 65,
						width: 35,
						height: 35,
						backgroundColor: colors.background,
						borderRadius: 25,
						justifyContent: "center",
						alignItems: "center",
					}}
				>
					<Foundation name="camera" size={25} style={{ color: colors.text }} />
				</View>
			)}
		</View>
	);
}

const styles = StyleSheet.create({
	card: {
		display: "flex",
		flexDirection: "column",
		width: "100%",
		flex: 1,
	},
	formControl: {
		display: "flex",
		flexDirection: "row",
		marginTop: 10,
		marginBottom: 10,
	},
	input: {
		flex: 1,
		margin: 2,
	},
});
