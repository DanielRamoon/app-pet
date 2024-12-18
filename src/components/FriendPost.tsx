import { FontAwesome5, MaterialCommunityIcons, MaterialIcons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import i18n from "@utils/i18n";
import walkService from "@utils/supabase/services/walk/walk.service";
import { useCallback, useEffect, useState } from "react";
import { ActivityIndicator, Alert, Dimensions, Image, StyleSheet, Text, TouchableOpacity, View } from "react-native";
import petBucket from "@utils/supabase/buckets/pets";
import petsService from "@utils/supabase/services/pets/pets.service";
import userService from "@utils/supabase/services/user.service";
import avatars from "@utils/supabase/buckets/avatars";
import environment from "environment";
import { getRandomHexColor } from "@utils/utilities";
import { navigate } from "@utils/navigator";
import { DateTime } from "luxon";

interface profileImages {
	userAvatar: string | undefined;
	petAvatar: string | undefined;
}

export default function Post(props: { petWalk: any; isLast?: boolean; isMy: boolean }) {
	const colors = useColors();
	const [petName, setPetName] = useState<string>();
	const [userName, setUserName] = useState<string>();
	const [fullName, setFullName] = useState<string>();

	const [likes, setLikes] = useState<number>(0);

	const [delay, setDelay] = useState<boolean>(false);
	const [giveLike, setGiveLike] = useState<boolean>(false);
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
		(async () => {
			const likesQ = await walkService.getMyWalksLikes(props.petWalk.id);

			if (likesQ.data.length > 0) {
				setLikes(likesQ.data.length);
			}

			if (!props.isMy) {
				const exist: any = await walkService.checkLikeExists(props.petWalk.id);
				if (exist?.data.length > 0) {
					setGiveLike(true);
				}
			}

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
			setFullName(username.fullName!);
		})();
	}, []);

	async function like() {
		if (giveLike) {
			setLikes(likes - 1);
			setGiveLike(false);
			await walkService.walkDeslike(props.petWalk.id);
			setDelay(false);
			return;
		} else {
			setLikes(likes + 1);
			await walkService.walksLikes(props.petWalk.id);
			setDelay(false);
		}
	}

	async function showUsers() {
		navigate("SeeUserLikes", {
			petWalkId: props.petWalk.id,
		});
	}

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
		<View style={{ flex: 1, justifyContent: "center", alignItems: "center" }}>
			<View
				style={{
					width: Dimensions.get("window").width,
					marginBottom: 40,
					marginTop: 0,
					backgroundColor: colors.background,
				}}
			>
				{avatar.userAvatar && avatar.petAvatar ? (
					<View
						style={{
							height: props.isMy ? 450 : 520,
						}}
					>
						<View style={{ display: "flex", flexDirection: "row", justifyContent: "flex-start", alignItems: "center" }}>
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
							<View
								style={{
									display: "flex",
									justifyContent: "flex-start",
									alignItems: "flex-start",
									flexDirection: "column",
								}}
							>
								<Text numberOfLines={1} style={{ color: colors.text, fontSize: 16 }}>
									@{userName}
								</Text>
								<Text numberOfLines={1} style={{ color: colors.secondaryText, fontSize: 16 }}>
									{fullName}
								</Text>
							</View>
						</View>

						<View style={{ flex: 1, justifyContent: "center", alignItems: "center", marginTop: 25 }}>
							<View
								style={{
									display: "flex",
									backgroundColor: colors.primary,
									height: 250,
									width: "93%",
									borderRadius: 15,
									borderBottomRightRadius: props.isMy ? 15 : 0,
									borderBottomLeftRadius: props.isMy ? 15 : 0,
									padding: 20,
								}}
							>
								<View
									style={{ flex: 1, justifyContent: "center", alignItems: "center", flexDirection: "column", gap: 10 }}
								>
									<Text style={{ color: "white", fontSize: 16, textAlign: "center" }}>
										{fullName}
										{i18n.get("posts.didWalk")} {petName} {i18n.get("on")}{" "}
										{DateTime.fromISO(props.petWalk.date_end).toLocaleString(DateTime.DATETIME_MED)}
									</Text>
									<View
										style={{ flex: 1, justifyContent: "center", alignItems: "center", flexDirection: "row", gap: 40 }}
									>
										<View style={styles.icon}>
											{!imageError ? (
												<Image
													source={{ uri: avatar.userAvatar, cache: "only-if-cached" }}
													style={styles.petImage}
													onError={handleImageError}
												/>
											) : (
												<Image source={{ uri: generateAvatar(userName!?.slice(0, 2)) }} style={styles.petImage} />
											)}
										</View>
										<View style={styles.iconRight}>
											{!petImageError ? (
												<Image
													source={{
														uri: avatar.petAvatar,
														cache: "only-if-cached",
													}}
													style={styles.petImage}
													onError={handlePetImageError}
												/>
											) : (
												<Image source={{ uri: petBucket.getPetPhoto().data }} style={styles.petImage} />
											)}
										</View>
									</View>
								</View>
								<View
									style={{
										display: "flex",
										justifyContent: "center",
										alignItems: "center",
										flexDirection: "row",
										gap: 50,
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
							{!props.isMy ? (
								<View
									style={{
										width: "93%",
										paddingHorizontal: 20,
										display: "flex",
										justifyContent: "flex-start",
										alignItems: "center",
										backgroundColor: colors.darkBlue,
										borderBottomRightRadius: 15,
										borderBottomLeftRadius: 15,
										gap: 15,
										flexDirection: "row",
										padding: 5,
									}}
								>
									<MaterialCommunityIcons name="paw-outline" color={"white"} size={22} />
									<Text style={{ color: "white", fontSize: 12 }}>{likes}</Text>
								</View>
							) : (
								<></>
							)}
						</View>
						<View
							style={{
								display: "flex",
								justifyContent: "flex-start",
								alignItems: "center",
								flexDirection: "row",
								marginBottom: 25,
								marginTop: props.isMy ? -30 : 20,
								borderRadius: 20,
								borderTopLeftRadius: 30,
								borderBottomLeftRadius: 30,
								marginLeft: props.isMy ? 15 : 0,
								gap: props.isMy ? 0 : 0,
							}}
						>
							{props.isMy ? (
								<TouchableOpacity
									onPress={() => {
										showUsers();
									}}
									style={{
										...styles.cardBtns,
										backgroundColor: colors.likeButton,
										width: 60,
										height: 60,
										borderWidth: 5,
										marginLeft: 20,
										borderColor: colors.background,
									}}
								>
									<MaterialCommunityIcons name={"paw-outline"} color={"white"} size={30} />
								</TouchableOpacity>
							) : (
								<TouchableOpacity
									disabled={delay ? true : false}
									onPress={() => {
										setGiveLike(!giveLike);
										setDelay(true);
										like();
									}}
									style={{
										...styles.cardBtns,
										backgroundColor: "transparent",
										width: 60,
										height: 60,
										borderWidth: 0,
										marginLeft: 20,
										borderColor: "transparent",
									}}
								>
									<MaterialCommunityIcons
										name={giveLike ? "paw" : "paw-outline"}
										color={giveLike ? colors.likeButton : colors.text}
										size={30}
									/>
								</TouchableOpacity>
							)}
							{!props.isMy ? (
								<Text style={{ textAlign: "center", color: colors.text }}>{i18n.get("posts.like")}</Text>
							) : (
								<></>
							)}
							{props.isMy ? (
								<View
									style={{
										display: "flex",
										justifyContent: "center",
										alignItems: "center",
									}}
								>
									<Text style={{ color: colors.text, fontSize: 16, fontWeight: "bold" }}>{likes}</Text>
								</View>
							) : (
								<></>
							)}
						</View>
						{props.isLast ? (
							<></>
						) : (
							<View style={{ width: "100%", height: 1.2, backgroundColor: colors.secondaryText }} />
						)}
					</View>
				) : (
					<View
						style={{
							width: "100%",
							display: "flex",
							justifyContent: "center",
							alignItems: "center",
						}}
					>
						<View
							style={{
								width: "90%",
								height: 350,
								borderRadius: 16,
								display: "flex",
								justifyContent: "center",
								alignItems: "center",
								flexDirection: "row",
								borderWidth: 1.5,
								borderColor: colors.cardColorSelected,
							}}
						>
							<ActivityIndicator color={colors.text} size={30} />
						</View>
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
	petImage: {
		width: 80,
		height: 80,
		borderRadius: 999,
	},
	imagemBody: {
		width: 250,
		height: 200,
		borderRadius: 15,
	},
	icon: {
		width: 80,
		height: 80,
		borderRadius: 999,
		display: "flex",
		alignItems: "center",
		justifyContent: "center",
	},
	iconRight: {
		width: 80,
		height: 80,
		borderRadius: 999,
		display: "flex",
		alignItems: "center",
		justifyContent: "center",
	},
	cardBtns: {
		backgroundColor: "transparent",
		borderRadius: 999,
		display: "flex",
		justifyContent: "center",
		alignItems: "center",
	},
});
