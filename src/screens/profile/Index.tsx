import ConfirmDel from "@components/Modals/ConfirmDelReminder";
import WalkInfoModal from "@components/Modals/Fullscreen/WalkInfoModal";
import QuestionModal from "@components/Modals/QuestionModal";
import ThemedView from "@components/utils/ThemedView";
import { FontAwesome5, Ionicons, MaterialCommunityIcons, MaterialIcons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import { useRoute } from "@react-navigation/native";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import flex from "@styles/flex";
import i18n from "@utils/i18n";
import petBucket from "@utils/supabase/buckets/pets";
import { logOut } from "@utils/supabase/client";
import petsService from "@utils/supabase/services/pets/pets.service";
import userService, { IUser } from "@utils/supabase/services/user.service";
import ContentLoader, { Circle, Rect } from "react-content-loader/native";
import walkService, { IPetWalk } from "@utils/supabase/services/walk/walk.service";
import { DateTime, Duration } from "luxon";
import { Avatar, Box, Divider, HStack, Pressable, Spacer, Text, View } from "native-base";
import React, { useCallback, useEffect, useRef, useState } from "react";
import {
	Alert,
	DeviceEventEmitter,
	Dimensions,
	FlatList,
	Image,
	RefreshControl,
	StyleSheet,
	TouchableOpacity,
} from "react-native";
import { Share } from "react-native";
import Loader from "@components/Loader";

interface IParams {
	reload: number;
	firstL: boolean;
}

export default function ({ navigation }: NativeStackScreenProps<any, "MainTabs">) {
	const colors = useColors();

	const { params } = useRoute() as { params: IParams };
	const [refreshing, setRefreshing] = useState(false);
	const [loading, setLoading] = useState(true);
	const [deleting, setDeleting] = useState(false);
	const [confirmDel, setConfirmDel] = useState(false);
	const [profile, setProfile] = useState<IUser | null>(null);

	const profileId = useRef<string | null>(null);

	const [petIds, setPetIds] = useState<string[] | number[]>([]);
	const [walks, setWalks] = useState<IPetWalk[]>([]);
	const [selectedWalks, setSelectedWalks] = useState<any[]>([]);
	const [currentPage, setCurrentPage] = useState(0);

	const [petQuantity, setPetQuantity] = useState(0);
	const [walkQuantity, setWalkQuantity] = useState(0);

	const [endReached, setEndReached] = useState(false);
	const [gettingMore, setGettingMore] = useState(false);

	const [toSeeWalk, setToSeeWalk] = useState<IPetWalk & { pet_name: string; pet_image: string }>();

	async function startup(refresh?: boolean) {
		if (refresh) {
			setCurrentPage(0);
			setWalks([]);
			setEndReached(false);
			setSelectedWalks([]);
			setProfile(null);
			setGettingMore(false);
			setWalkQuantity(0);
			setPetQuantity(0);
			setPetIds([]);
			setProfile((profile: IUser) => ({ ...profile, avatar_url: undefined } as any));

			profileId.current = null;
		}

		if (!refresh) setLoading(true);
		else setRefreshing(true);

		const profileData = await userService.getLoggedUserProfile();

		if (profileData.messages) {
			Alert.alert(i18n.get("alert"), i18n.get("profile.errorLoadingProfile"));
			return navigation.navigate("Home");
		}

		if (!profileData.data) {
			Alert.alert(i18n.get("alert"), i18n.get("profile.errorLoadingProfile"));
			return navigation.navigate("Home");
		}

		const pets = await petsService.getPetsMetadata();
		const walks = await walkService.countWalks(pets?.ids);

		setPetIds(pets?.ids ?? []);
		setPetQuantity(pets?.q ?? 0);
		setProfile(profileData.data as IUser);
		setWalkQuantity(walks.data ?? 0);

		if (!profileData.data?.id) Alert.alert(i18n.get("error"), i18n.get("PROFILE-ID"));
		else profileId.current = profileData.data?.id;

		setLoading(false);
	}

	const shareProfile = useCallback(async () => {
		await Share.share({
			message: i18n.get("shareTitle") + "\n" + `https://petvidade.lgtng.com/app?profileId=${profileId.current}`,
			title: i18n.get("shareTitle"),
			url: `https://petvidade.lgtng.com/app?profileId=${profileId.current}`,
		});
	}, [profile, profileId.current]);

	useEffect(() => {
		startup().finally(() => setLoading(false));

		const eventEdit = DeviceEventEmitter.addListener("editAccount", () => {
			navigation.navigate("Edit");
		});

		const shareProfileEvent = DeviceEventEmitter.addListener("shareProfile", shareProfile);

		const eventLogoutEvent = DeviceEventEmitter.addListener("logoutAccount", () => {
			logOut();
		});

		return () => {
			eventEdit.remove();
			shareProfileEvent.remove();
			eventLogoutEvent.remove();
		};
	}, []);

	async function realod() {
		setProfile((profile: IUser) => ({ ...profile, avatar_url: undefined } as any));

		setLoading(true);

		const profileData = await userService.getLoggedUserProfile();

		if (profileData.messages) {
			Alert.alert(i18n.get("alert"), i18n.get("profile.errorLoadingProfile"));
			return navigation.navigate("Home");
		}

		if (!profileData.data) {
			Alert.alert(i18n.get("alert"), i18n.get("profile.errorLoadingProfile"));
			return navigation.navigate("Home");
		}

		setProfile(profileData.data as IUser);
	}

	useEffect(() => {
		if (!params.firstL) {
			realod().finally(() => setLoading(false));
		}
	}, [params.reload]);

	const getNextWalks = async (ids: string[] | number[] | null = null, page?: number, force?: boolean) => {
		if (endReached && !force) return;
		if (petIds.length === 0 && ((ids && ids.length === 0) || !ids) && !force) return;

		if (page === 0) {
			setCurrentPage(0);
			setWalks([]);
		}

		setGettingMore(true);
		const _walks = await walkService.getWalks(ids as any, page);
		setGettingMore(false);

		if (_walks.messages) {
			Alert.alert(i18n.get("alert"), i18n.get("profile.errorLoadingWalks"));
		}

		if (!_walks.data) {
			Alert.alert(i18n.get("alert"), i18n.get("profile.errorLoadingWalks"));
		}

		if (_walks?.data?.length === 0) return setEndReached(true);

		// Junta os arrays
		const newArray = [...walks, ...(_walks.data ?? [])];

		// Remove os itens duplicados pelo .id
		const filtered = newArray.filter((objeto, index, self) => {
			return self.findIndex((item) => item.id === objeto.id) === index;
		});

		if (filtered.length > walks.length) {
			setWalks(filtered as IPetWalk[]);
		}
		setCurrentPage(currentPage + 1);
	};

	const formatUserAddress = useCallback(() => {
		const address: { city: string; country: string; state: string } = profile?.address as any;
		let addressString = [];

		if (!address) return "";

		if (address.city) addressString.push(address.city);
		if (address.state) addressString.push(address.state);
		if (address.country) addressString.push(address.country);

		return addressString.join(" - ");
	}, [profile]);

	const deleteWalk = async (id?: string) => {
		if (!id) return;

		setLoading(true);

		try {
			if (!id) return;

			await walkService.deleteWalk(id as any);

			setToSeeWalk(undefined);

			startup(true).then(() => setRefreshing(false));
		} catch (error) {
		} finally {
			setDeleting(false);
			setLoading(false);

			DeviceEventEmitter.emit("showAppBar");
			DeviceEventEmitter.emit("showTabBar");
		}
	};

	const renderItem = ({ item, index }: { item: IPetWalk; index: number }) => (
		<Pressable
			style={{
				marginLeft: "auto",
				marginRight: "auto",
				marginTop: 15,
				width: "100%",
				minHeight: 100,
			}}
			onPress={async () => {
				// console.log("click");
				// if (selectedWalks.length > 0) {
				// 	if (selectedWalks.includes(item.id)) {
				// 		setSelectedWalks((selectedWalks) => [...selectedWalks].filter((x) => x !== item.id));
				// 	} else {
				// 		setSelectedWalks((selectedWalks) => [...selectedWalks, item.id]);
				// 	}
				// } else {
				const pet = await petsService.getPet(item.pet_id);
				setToSeeWalk({
					...item,
					pet_name: pet.data?.name ?? "",
					pet_image: petBucket.getPetPhoto(item.pet_id, profile?.id).data ?? "",
				});
				// }
			}}
			// onLongPress={() => {
			// 	if (selectedWalks.includes(item.id)) {
			// 		setSelectedWalks((selectedWalks) => [...selectedWalks].filter((x) => x !== item.id));
			// 	} else {
			// 		setSelectedWalks((selectedWalks) => [...selectedWalks, item.id]);
			// 	}
			// }}
			// delayLongPress={200}
		>
			{({ isPressed }) => {
				return (
					<Box
						bg={
							selectedWalks.includes(item.id)
								? colors.cardColorSelected
								: isPressed
								? colors.cardColorPressed
								: colors.cardColor
						}
						style={{
							width: "100%",
							transform: [
								{
									scale: isPressed ? 0.96 : 1,
								},
							],
							flex: 1,
							flexDirection: "row",
						}}
						rounded="5"
					>
						<Box
							style={{
								flex: 1,
								flexDirection: "column",
								justifyContent: "space-between",
							}}
							paddingLeft={2}
							paddingRight={2}
							paddingTop={2}
							paddingBottom={2}
						>
							<HStack alignItems="center" margin="auto">
								<Avatar
									bg={colors.primary}
									source={{
										uri: `${petBucket.getPetPhoto(item.pet_id, profile?.id).data}`,
										cache: "reload",
									}}
								>
									<Image
										source={{ uri: petBucket.getPetPhoto().data }}
										style={{ width: "100%", height: "100%", borderRadius: 9999 }}
									/>
									{selectedWalks.includes(item.id) && (
										<Avatar.Badge
											bg="green.500"
											bgColor={colors.primary}
											h={32}
											w={32}
											style={{ display: "flex", justifyContent: "center", alignItems: "center" }}
										>
											<Ionicons name="checkmark-sharp" size={8} color="white" />
										</Avatar.Badge>
									)}
								</Avatar>
								<View style={{ display: "flex", flexDirection: "column", paddingLeft: 15 }}>
									<Text
										color={colors.text}
										numberOfLines={1}
										ellipsizeMode="tail"
										maxWidth={Dimensions.get("window").width - 150}
									>
										{DateTime.fromISO(item.date_start).toLocaleString({
											day: "2-digit",
											month: "2-digit",
											year: "numeric",
											hour: "2-digit",
											minute: "2-digit",
											hour12: false,
										})}{" "}
										- {Duration.fromObject({ seconds: item.duration }).toFormat("hh:mm:ss")}
									</Text>

									<Text>
										{Number((item?.total_distance as any)?.km).toFixed(2)}km |{" "}
										<FontAwesome5 name="walking" size={12} color={colors.text} />{" "}
										{(item.total_distance as any)?.humanDistance} |{" "}
										<MaterialIcons name="pets" size={12} color={colors.text} style={{ marginTop: 5 }} />{" "}
										{(item.total_distance as any)?.animalDistance as any}
									</Text>
								</View>

								<Spacer />

								{/* <TouchableWithoutFeedback style={{ display: "flex", justifyContent: "center", flex: 1 }} onPress={console.log}>
								<Ionicons name="ellipsis-vertical" size={24} color={colors.text} />
							</TouchableWithoutFeedback> */}
							</HStack>

							{/* <HStack alignItems="center">
							<Spacer />

							<Text fontSize={10} color={colors.text} style={{ ...flex.myAuto }}>
								{getPetDuration(item.birth_date)}
							</Text>
						</HStack> */}
						</Box>
					</Box>
				);
			}}
		</Pressable>
	);

	return (
		<>
			{toSeeWalk && toSeeWalk.id && (
				<WalkInfoModal
					onClose={() => setToSeeWalk(undefined)}
					onAction={(action) => {
						if (action === "delete") {
							setDeleting(true);
						}
					}}
					fixedWalk={{
						...toSeeWalk,
						user_id: String(profile?.id),
						user_name: String(profile?.user_name),
						user_image: String(profile?.avatar_url),
					}}
				/>
			)}
			{confirmDel && (
				<ConfirmDel message={i18n.get("confirmLogOut")} cancel={() => setConfirmDel(false)} confirm={logOut} />
			)}
			{deleting && (
				<QuestionModal
					hideCancel
					title={i18n.get("deleteWalk")}
					cancel={() => setDeleting(false)}
					confirm={() => deleteWalk(toSeeWalk?.id)}
					customBody={(() => undefined) as any}
				/>
			)}

			<ThemedView isRoot fadeIn tabBarPadding>
				{profile?.private && (
					<MaterialIcons
						name="local-parking"
						size={24}
						color="black"
						style={{ position: "absolute", right: 12, top: 0, zIndex: 999 }}
					/>
				)}

				<ThemedView>
					<FlatList
						showsVerticalScrollIndicator={false}
						ListHeaderComponent={() => (
							<>
								<View
									style={{
										display: "flex",
										flexDirection: "row",
										marginLeft: 5,
										marginRight: 15,
										marginTop: 20,
									}}
								>
									{profile?.avatar_url && !loading ? (
										<TouchableOpacity
											style={{
												width: "auto",
												height: "auto",
												display: "flex",
												justifyContent: "center",
												alignItems: "center",
											}}
											onPress={() => navigation.navigate("Edit")}
										>
											<Image
												style={{
													width: 100,
													height: 100,
													borderRadius: 150,
													marginTop: "auto",
												}}
												source={{ uri: profile.avatar_url }}
											/>
											<View
												style={{
													backgroundColor: colors.background,
													borderRadius: 90,
													padding: 8,
													position: "absolute",
													top: 70,
													left: 65,

													display: "flex",
													justifyContent: "center",
													alignItems: "center",
												}}
											>
												<MaterialCommunityIcons name="pencil" color={colors.text} size={20} />
											</View>
										</TouchableOpacity>
									) : (
										<View
											style={{
												width: 100,
												height: 100,
												display: "flex",
												justifyContent: "center",
												alignItems: "center",
											}}
										>
											<ContentLoader
												viewBox={`0 0 80 80`}
												backgroundColor={colors.loaderBackColor}
												foregroundColor={colors.loaderForeColor}
											>
												<Circle cx={40} cy={40} r={40} />
											</ContentLoader>
										</View>
									)}

									{profile?.full_name && profile.user_name && !loading ? (
										<View style={{ width: "100%", marginLeft: 15, ...flex.myAuto }}>
											<Text style={{ ...flex.myAuto, fontSize: 18 }} selectable>
												@{profile?.user_name}
											</Text>

											<Text
												style={{
													color: colors.secondaryText,
													...flex.myAuto,
													fontSize: 15,
													maxWidth: Dimensions.get("screen").width - 150,
												}}
												numberOfLines={2}
											>
												{profile?.full_name}
											</Text>

											<Text style={{ color: colors.secondaryText, width: "90%" }} selectable>
												{formatUserAddress()}
											</Text>
										</View>
									) : (
										<View
											style={{
												width: 100,
												height: 100,
												display: "flex",
												justifyContent: "center",
												alignItems: "center",
											}}
										>
											<ContentLoader
												viewBox={`0 0 ${Dimensions.get("window").width} 80`}
												backgroundColor={colors.loaderBackColor}
												foregroundColor={colors.loaderForeColor}
											>
												<Rect width={300} height={42} x={42} y={170} rx={20} ry={20} />
											</ContentLoader>
											<ContentLoader
												viewBox={`0 0 ${Dimensions.get("window").width} 400`}
												backgroundColor={colors.loaderBackColor}
												foregroundColor={colors.loaderForeColor}
											>
												<Rect width={350} height={42} x={42} y={0} rx={20} ry={20} />
											</ContentLoader>
										</View>
									)}
								</View>

								<View
									style={{
										display: "flex",
										paddingTop: 10,
										flexDirection: "row",
										justifyContent: "space-evenly",
										marginTop: 20,
									}}
								>
									{petQuantity && !loading ? (
										<View
											style={{
												display: "flex",
												flexDirection: "column",
												justifyContent: "center",
												alignItems: "center",
												gap: 10,
											}}
										>
											<Text>{i18n.get("profile.tooltips[0]")}</Text>
											<Text>{petQuantity}</Text>
										</View>
									) : (
										<View
											style={{
												width: 100,
												height: 100,
												display: "flex",
												justifyContent: "center",
												alignItems: "center",
											}}
										>
											<ContentLoader
												viewBox={`0 0 150 10`}
												backgroundColor={colors.loaderBackColor}
												foregroundColor={colors.loaderForeColor}
											>
												<Rect width={150} height={19} x={0} y={50} rx={6} ry={6} />
											</ContentLoader>
											<ContentLoader
												viewBox={`0 0 120 120`}
												backgroundColor={colors.loaderBackColor}
												foregroundColor={colors.loaderForeColor}
											>
												<Rect width={30} height={12} x={45} y={15} rx={6} ry={6} />
											</ContentLoader>
										</View>
									)}

									{walkQuantity && !loading ? (
										<View
											style={{
												display: "flex",
												flexDirection: "column",
												justifyContent: "center",
												alignItems: "center",
												gap: 10,
											}}
										>
											<Text>{i18n.get("profile.tooltips[1]")}</Text>
											<Text>{walkQuantity}</Text>
										</View>
									) : (
										<View
											style={{
												width: 100,
												height: 100,
												display: "flex",
												justifyContent: "center",
												alignItems: "center",
											}}
										>
											<ContentLoader
												viewBox={`0 0 150 10`}
												backgroundColor={colors.loaderBackColor}
												foregroundColor={colors.loaderForeColor}
											>
												<Rect width={150} height={19} x={0} y={50} rx={6} ry={6} />
											</ContentLoader>
											<ContentLoader
												viewBox={`0 0 120 120`}
												backgroundColor={colors.loaderBackColor}
												foregroundColor={colors.loaderForeColor}
											>
												<Rect width={30} height={12} x={45} y={15} rx={6} ry={6} />
											</ContentLoader>
										</View>
									)}
								</View>

								<Divider my={5} />

								<Text style={{ marginLeft: 1, fontWeight: "bold", fontSize: 18 }}>
									{i18n.get("pets.profile.walks")}
								</Text>
							</>
						)}
						refreshControl={
							<RefreshControl
								refreshing={refreshing}
								onRefresh={() => startup(true).then(() => setRefreshing(false))}
								tintColor={colors.primary}
								colors={[colors.white]}
								progressBackgroundColor={colors.lightGreen}
							/>
						}
						contentContainerStyle={{ paddingTop: 10 }}
						// ListHeaderComponent={renderHeader}
						alwaysBounceVertical={true}
						data={walks}
						renderItem={renderItem}
						ListFooterComponent={
							gettingMore ? (
								walks.length > 0 ? (
									<View
										style={{
											width: "100%",
											display: "flex",
											justifyContent: "center",
											alignItems: "center",
											marginLeft: 18,
											top: 20,
										}}
									>
										<Loader onlyDog bgColor={colors.background} customStyle={{ transform: [{ translateX: -20 }] }} />
									</View>
								) : (
									<View
										style={{
											width: "100%",
											height: 100,
											marginTop: 15,
											display: "flex",
											justifyContent: "center",
											alignItems: "center",
										}}
									>
										<ContentLoader
											viewBox={`0 0 ${Dimensions.get("window").width} 100`}
											backgroundColor={colors.loaderBackColor}
											foregroundColor={colors.loaderForeColor}
										>
											<Rect width={Dimensions.get("window").width} height={100} x={0} y={0} rx={6} ry={6} />
										</ContentLoader>
									</View>
								)
							) : (
								<Box height={100} />
							)
						}
						onEndReached={() => getNextWalks(petIds, currentPage)}
						onEndReachedThreshold={0.25}
						extraData={selectedWalks}
					/>
				</ThemedView>
			</ThemedView>
		</>
	);
}

const styles = StyleSheet.create({
	container: {
		height: "100%",
		flex: 1,
		marginTop: 15,
		borderTopLeftRadius: 15,
		borderTopRightRadius: 15,
	},
	profilePreview: {
		display: "flex",
		flexDirection: "column",
		justifyContent: "center",
		alignContent: "center",
		alignItems: "center",
	},
	profilePreviewIcon: {
		display: "flex",
		justifyContent: "center",
		alignItems: "center",
		alignContent: "center",
		textAlign: "center",
		verticalAlign: "middle",
		height: 48,
		width: 48,
	},
});
