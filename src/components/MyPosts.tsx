import i18n from "@utils/i18n";
import { IPetWalk } from "@utils/supabase/services/walk/walk.service";
import { useCallback, useEffect, useState } from "react";
import { Alert, Dimensions, Image, StyleSheet, Text, View } from "react-native";
import ContentLoader, { Rect } from "react-content-loader/native";
import petBucket from "@utils/supabase/buckets/pets";
import petsService from "@utils/supabase/services/pets/pets.service";
import userService from "@utils/supabase/services/user.service";
import avatars from "@utils/supabase/buckets/avatars";
import environment from "environment";
import { getRandomHexColor } from "@utils/utilities";
import useColors from "@hooks/useColors";
import { FontAwesome5, MaterialCommunityIcons, MaterialIcons } from "@expo/vector-icons";
interface profileImages {
	userAvatar: string | undefined;
	petAvatar: string | undefined;
}

export default function MyPosts(props: { petWalk: IPetWalk; isLast?: boolean; isVertical?: boolean }) {
	const colors = useColors();

	const [petName, setPetName] = useState<string>();
	const [userName, setUserName] = useState<string>();
	const [imageError, setImageError] = useState<boolean>(false);
	const [petImageError, setPetImageError] = useState<boolean>(false);

	const [avatar, setAvatar] = useState<profileImages>({ userAvatar: undefined, petAvatar: undefined });
	const getPetName = useCallback(async () => {
		const { data, trace } = await petsService.getPetName(props.petWalk.pet_id);
		if (trace?.error) console.log(trace.error);
		else return data;
	}, []);
	const getUserName = useCallback(async () => {
		const { data, trace } = await userService.getUserName(props.petWalk.created_by);
		if (trace?.error) console.log(trace.error);
		else return data;
	}, []);
	useEffect(() => {
		async function startup() {
			const petname = await getPetName();
			const username = await getUserName();
			if (!petname) Alert.alert(i18n.get("error"), i18n.get("errorLoadingPetName"));
			if (!username) return Alert.alert(i18n.get("error"), i18n.get("errorLoadingUserName"));
			if (avatar.petAvatar === undefined || avatar.userAvatar === undefined) {
				setAvatar({
					userAvatar: avatars.getUserAvatarById(props.petWalk.created_by).data,
					petAvatar: petBucket.getPetPhoto(props.petWalk.pet_id, props.petWalk.created_by).data,
				});
			}
			setPetName(petname);
			setUserName(username.userName!);
		}

		startup();
	}, []);

	const getDistance = () => {
		if (props.petWalk.total_distance?.km > 1) return String(props.petWalk.total_distance?.km?.toFixed(1)) + " km";
		else if (props.petWalk.total_distance?.km > 0)
			return String((props.petWalk.total_distance?.km * 1000).toFixed(1)) + " m";
		else return props.petWalk.total_distance?.km + " m";
	};
	const generateAvatar = (initials: string) => {
		return `${
			environment.UIAVATARS_URL ?? "https://ui-avatars.com/api/"
		}?name=${initials}&size=256&rounded=true&background=${getRandomHexColor({
			removeHash: true,
		})}&color=ffffff&format=png`;
	};
	const handleImageError = () => {
		setImageError(true);
	};
	const handlePetImageError = () => {
		setPetImageError(true);
	};

	return (
		<View style={{ flex: 1, marginHorizontal: 20, justifyContent: "center", alignItems: "center" }}>
			<View
				style={{
					width: Dimensions.get("window").width * 0.9,
					marginBottom: props.isVertical ? 40 : 0,
					marginTop: props.isVertical ? 0 : 20,
					backgroundColor: colors.background,
				}}
			>
				{avatar.userAvatar && avatar.petAvatar ? (
					<View
						style={{
							height: 160,
						}}
					>
						<View style={{ ...styles.icon, backgroundColor: colors.background }}>
							{!imageError ? (
								<Image
									source={{ uri: avatar.userAvatar, cache: "only-if-cached" }}
									style={styles.image}
									onError={handleImageError}
								/>
							) : (
								<Image source={{ uri: generateAvatar(userName!?.slice(0, 2)) }} style={styles.image} />
							)}
						</View>

						<View style={{ ...styles.iconRight, backgroundColor: colors.background }}>
							{!petImageError ? (
								<Image
									source={{
										uri: avatar.petAvatar,
										cache: "only-if-cached",
									}}
									style={styles.image}
									onError={handlePetImageError}
								/>
							) : (
								<Image source={{ uri: petBucket.getPetPhoto().data }} style={styles.image} />
							)}
						</View>

						<View
							style={{
								position: "absolute",
								left: 70,
								top: 7,
								width: 200,
								maxWidth: Dimensions.get("window").width * 0.85 - 70 * 2,
								zIndex: 9999999,
							}}
						>
							<Text numberOfLines={1} style={{ color: colors.white, fontSize: 16, fontWeight: "bold" }}>
								@{userName}
							</Text>
							<Text numberOfLines={1} style={{ color: colors.white, fontSize: 14, fontWeight: "bold" }}>
								{petName}
							</Text>
						</View>

						<View
							style={{
								display: "flex",
								flexDirection: "row",
								justifyContent: "space-around",
								backgroundColor: colors.primary,
								height: 120,
								borderRadius: 15,
								borderBottomRightRadius: 15,
								paddingBottom: 10,
							}}
						>
							<View
								style={{
									display: "flex",
									flexDirection: "row",
									alignItems: "center",
									justifyContent: "flex-start",
									marginTop: "auto",
								}}
							>
								<MaterialCommunityIcons name="map-marker-distance" size={24} color={colors.white} />
								<Text
									style={{
										width: "auto",
										color: colors.white,
										paddingLeft: 7,
										marginRight: "auto",
									}}
								>
									{getDistance()}
								</Text>
							</View>

							<View
								style={{
									display: "flex",
									flexDirection: "row",
									alignItems: "center",
									justifyContent: "flex-start",
									marginTop: "auto",
								}}
							>
								<FontAwesome5 name="walking" size={24} color={colors.white} />
								<Text
									style={{
										width: "auto",
										color: colors.white,
										paddingLeft: 7,
										marginRight: "auto",
									}}
								>
									{props.petWalk.total_distance?.humanDistance}
								</Text>
							</View>

							<View
								style={{
									display: "flex",
									flexDirection: "row",
									alignItems: "center",
									justifyContent: "flex-start",
									marginTop: "auto",
								}}
							>
								<MaterialIcons
									name="pets"
									size={24}
									color={colors.white}
									style={{
										marginLeft: "auto",
										// marginBottom: 5
									}}
								/>
								<Text
									style={{
										width: "auto",
										color: colors.white,
										paddingLeft: 7,
										marginRight: "auto",
									}}
								>
									{props.petWalk.total_distance?.animalDistance}
								</Text>
							</View>
						</View>
					</View>
				) : (
					<View
						style={{
							width: "100%",
							height: 160,
							display: "flex",
							justifyContent: "center",
							backgroundColor: colors.background,
							alignItems: "center",
						}}
					>
						<ContentLoader
							viewBox={`0 0 ${Dimensions.get("window").width} 160`}
							backgroundColor={colors.loaderBackColor}
							foregroundColor={colors.loaderForeColor}
						>
							<Rect width={Dimensions.get("window").width * 0.95} height={140} x={10} y={0} rx={20} ry={20} />
						</ContentLoader>
					</View>
				)}
			</View>
		</View>
	);
}
const styles = StyleSheet.create({
	image: {
		width: 60,
		height: 60,
		borderRadius: 999,
	},
	imagemBody: {
		width: 250,
		height: 200,
		borderRadius: 15,
	},
	icon: {
		width: 70,
		height: 70,
		borderRadius: 999,
		display: "flex",
		alignItems: "center",
		justifyContent: "center",
		left: -10,
		top: -10,
		position: "absolute",
		zIndex: 99,
	},
	iconRight: {
		width: 70,
		height: 70,
		borderRadius: 999,
		display: "flex",
		alignItems: "center",
		justifyContent: "center",
		right: -10,
		top: -10,
		position: "absolute",
		zIndex: 99,
	},
	container: {},
	footer: {},
});
