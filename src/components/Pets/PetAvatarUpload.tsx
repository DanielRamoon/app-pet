import { Foundation } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import i18n from "@utils/i18n";
import petBucket from "@utils/supabase/buckets/pets";
import { Image } from "expo-image";
import * as ImagePicker from "expo-image-picker";
import React, { useCallback, useEffect, useState } from "react";
import { ActivityIndicator, Alert, Dimensions, StyleSheet, TouchableOpacity, View } from "react-native";

interface IProps {
	initialImage?: string | null;
	compact?: boolean;
	style?: any;
	disabled?: boolean;
	onImageChange: (image: string) => void;
	onImageLoaded?: () => void;
	disabledLongPress?: boolean;
}

export default function PetAvatarUpload(props: IProps) {
	const [loading, setLoading] = useState<boolean>(false);
	const [changingImage, setChangingImage] = useState<boolean>(false);
	const [image, setImage] = useState<string | null>(props.initialImage ?? null);

	const colors = useColors();

	useEffect(() => {
		if (props.initialImage) setImage(props.initialImage + "?" + new Date().getTime() ?? "");
	}, [props.initialImage]);

	const pickImage = useCallback(async () => {
		const result = await ImagePicker.launchImageLibraryAsync({
			mediaTypes: ImagePicker.MediaTypeOptions.Images,
			allowsEditing: true,
			aspect: [1, 1],
			quality: 1,
			base64: true,
			allowsMultipleSelection: false,
		});

		if (!result.canceled && result.assets && result.assets[0] && result.assets[0].base64) {
			setImage(`data:image/png;base64,${result.assets[0].base64}`);
			props.onImageChange(result.assets[0].base64);
		}
	}, [props.onImageChange]);

	const imageLoaded = () => {
		setLoading(false);
		setChangingImage(false);

		props.onImageLoaded?.();
	};

	const removeImage = async () => {
		setImage("");
		props.onImageChange("");
	};

	return (
		<View
			style={[styles.card, props.style]}
			// header={(props) => (
			// 	<Text category="h6" {...props}>
			// 		{i18n.get("firstAccess.steps[0]")}
			// 	</Text>
			// )}
		>
			<TouchableOpacity
				onPress={pickImage}
				onLongPress={props.disabledLongPress ? undefined : removeImage}
				style={{ display: "flex", justifyContent: "center", alignItems: "center", marginTop: 0 }}
				disabled={props.disabled}
			>
				<>
					{image ? (
						<Image
							style={{
								display: !loading && !changingImage ? "flex" : "none",
								width: props.compact ? 100 : 150,
								height: props.compact ? 100 : 150,
								borderRadius: 150,
								marginTop: "auto",
							}}
							contentFit="cover"
							onLoad={imageLoaded}
							source={{
								uri: image === "" ? undefined : image,
							}}
							cachePolicy="none"
							priority="high"
							onError={() => setImage(petBucket.getPetPhoto().data ?? null)}
						/>
					) : (
						<Image
							style={{
								display: !loading && !changingImage ? "flex" : "none",
								width: props.compact ? 100 : 150,
								height: props.compact ? 100 : 150,
								borderRadius: 150,
								marginTop: "auto",
							}}
							contentFit="cover"
							onLoad={imageLoaded}
							source={{
								uri: petBucket.getPetPhoto().data,
							}}
							placeholder={{
								uri: petBucket.getPetPhoto().data,
							}}
							cachePolicy="none"
							priority="high"
						/>
					)}

					<View
						style={{
							display: loading || changingImage ? "flex" : "none",
							flex: 1,
							justifyContent: "center",
							alignItems: "center",
							width: props.compact ? 100 : 150,
							height: props.compact ? 100 : 150,
							borderRadius: 150,
							marginTop: "auto",
							backgroundColor: colors.backgroundSecondary,
						}}
					>
						<ActivityIndicator color={colors.primary} size="large" />
					</View>
				</>
			</TouchableOpacity>

			{!props.compact ? (
				<View
					style={{
						position: "absolute",
						bottom: 10,
						right: Dimensions.get("window").width / 2 - 65,
						width: 25,
						height: 25,
						backgroundColor: colors.primary,
						borderRadius: 25,
						justifyContent: "center",
						alignItems: "center",
					}}
				>
					<Foundation name="pencil" size={16} style={{ color: colors.white }} />
				</View>
			) : (
				<View
					style={{
						position: "absolute",
						bottom: 5,
						right: 0,
						width: 25,
						height: 25,
						backgroundColor: colors.primary,
						borderRadius: 25,
						justifyContent: "center",
						alignItems: "center",
					}}
				>
					<Foundation name="pencil" size={16} style={{ color: colors.white }} />
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
		marginVertical: 30,
		marginBottom: 50,
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
