import Post from "@components/FriendPost";
import HomeAppIntro from "@components/Home/AppIntro";
import Loader from "@components/Loader";
import NotificationsIcon from "@components/Navigation/Bar/NotificationsIcon";
import OptionsButton from "@components/Navigation/Bar/OptionsButton";
import ProfileSearch from "@components/Navigation/Bar/ProfileSearch";
import SuggestPlace from "@components/Navigation/Bar/SuggestPlace";
import ThemedView from "@components/utils/ThemedView";
import { Ionicons, MaterialCommunityIcons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import * as Location from "expo-location";
import i18n, { PlaceType } from "@utils/i18n";
import userService, { IUser } from "@utils/supabase/services/user.service";
import walkService, { IPetWalk } from "@utils/supabase/services/walk/walk.service";
import * as Notifications from "expo-notifications";
import { StatusBar } from "expo-status-bar";
import ContentLoader, { Circle, Rect } from "react-content-loader/native";
import { Box } from "native-base";
import React, { useCallback, useEffect, useRef, useState } from "react";
import {
	Alert,
	BackHandler,
	DeviceEventEmitter,
	Dimensions,
	FlatList,
	Image,
	Platform,
	RefreshControl,
	ScrollView,
	StyleSheet,
	Text,
	ToastAndroid,
	TouchableOpacity,
	View,
} from "react-native";
import { goBack, navigate } from "@utils/navigator";
import LoactionP from "@components/Modals/LocationPermission";
import MyPosts from "@components/MyPosts";

export default function ({ navigation }: NativeStackScreenProps<any, "MainTabs">) {
	const colors = useColors();
	const [showOnboarding, setShowOnboarding] = useState(true);
	const [showApp, setShowApp] = useState(false);
	const [profile, setProfile] = useState<IUser>();
	const [permission, setPermission] = useState<boolean>(false);
	const [loading, setLoading] = useState<boolean>(true);
	const windowWidth = Dimensions.get("window").width;
	const notification = useRef<Notifications.NotificationResponse>();

	const [refreshing, setRefreshing] = useState(false);
	const [walks, setWalks] = useState<IPetWalk[]>([]);

	const clicks = useRef(0);
	const isFocused = useRef(false);

	const startup = async () => {
		setLoading(true);
		setWalks([]);

		const onBoarding = JSON.parse((await AsyncStorage.getItem("@petvidade:onBoarding")) ?? "false");

		if (onBoarding) setShowOnboarding(false);

		setShowApp(true);

		setProfile((profile) => ({ ...profile, avatar_url: undefined } as any));

		const profileData = await userService.getLoggedUserProfile();

		if (Number.isNaN(Number((profileData?.data?.settings as any)?.remember_walk!))) {
			await userService.updateUserProfile({
				settings: { ...(profileData?.data?.settings as any), remember_walk: 5 },
			});
		}

		profileData.data!.avatar_url = profileData.data?.avatar_url + "?t=" + new Date().getTime();

		setProfile(profileData.data as IUser);

		// Garantir a primeira busca
		await getMyWalks();

		setLoading(false);
	};

	useEffect(() => {
		startup();

		const unsubscribeBlur = navigation.addListener("blur", () => {
			isFocused.current = false;
		});

		const unsubscribeFocus = navigation.addListener("focus", () => {
			isFocused.current = true;
		});

		const backHandler = BackHandler.addEventListener("hardwareBackPress", () => {
			if (!isFocused.current) return false;

			if (clicks.current === 1) {
				BackHandler.exitApp();
				return true;
			}

			ToastAndroid.show(i18n.get("pressQuit"), ToastAndroid.SHORT);

			clicks.current += 1;

			setTimeout(() => {
				clicks.current = 0;
			}, 2000);

			return true;
		});

		return () => {
			backHandler.remove(), unsubscribeBlur(), unsubscribeFocus();
		};
	}, []);

	useEffect(() => {
		DeviceEventEmitter.addListener(
			"notificationTap",
			async (notificationReceived: Notifications.NotificationResponse) => {
				notification.current = notificationReceived;
			}
		);
	}, []);

	useEffect(() => {
		if (showOnboarding) {
			DeviceEventEmitter.emit("hideAppBar");
			DeviceEventEmitter.emit("hideTabBar");
		} else {
			DeviceEventEmitter.emit("showAppBar");
			DeviceEventEmitter.emit("showTabBar");
		}
	}, [showOnboarding]);

	// Walks
	const getMyWalks = useCallback(async () => {
		const _walks = await walkService.getMyWalks();

		if (_walks.messages) {
			Alert.alert(i18n.get("alert"), i18n.get("profile.errorLoadingWalks"));
		}

		if (!_walks.data) {
			Alert.alert(i18n.get("alert"), i18n.get("profile.errorLoadingWalks"));
		}

		setWalks([...(_walks.data ?? [])]);
	}, [walks]);

	const renderItem = ({ item, index }: { item: IPetWalk; index: number }) => (
		<MyPosts petWalk={item} isLast={index === walks.length - 1} />
	);

	if (!showApp) return <ThemedView />;

	if (showOnboarding)
		return (
			<ThemedView fadeIn>
				<StatusBar style="light" backgroundColor="transparent" />

				<HomeAppIntro
					onFinish={() => {
						setShowOnboarding(false);
						AsyncStorage.setItem("@petvidade:onBoarding", "true");
					}}
				/>
			</ThemedView>
		);

	const handlePermission = () => {
		setPermission(false);
		goBack();
	};

	if (loading && !profile?.avatar_url) {
		return (
			<ThemedView>
				<View
					style={{
						width: Dimensions.get("window").width,
						height: Dimensions.get("window").height,
						display: "flex",
						justifyContent: "center",
						alignItems: "center",
					}}
				>
					<ContentLoader
						viewBox={`0 0 ${Dimensions.get("window").width} ${Dimensions.get("window").height}`}
						backgroundColor={colors.loaderBackColor}
						foregroundColor={colors.loaderForeColor}
					>
						<Rect width={Dimensions.get("window").width} height={160} x={0} y={0} />
						<Circle cx={60} cy={100} r={32} />

						<Rect width={Dimensions.get("window").width * 0.9} height={40} x={20} y={190} rx={10} ry={10} />

						<Rect width={140} height={20} x={20} y={270} rx={5} ry={5} />

						<Rect width={80} height={45} x={65} y={306} rx={20} ry={20} />
						<Rect width={80} height={20} x={65} y={364} rx={5} ry={5} />
						<Rect width={80} height={45} x={175} y={306} rx={20} ry={20} />
						<Rect width={80} height={20} x={175} y={364} rx={5} ry={5} />
						<Rect width={80} height={45} x={285} y={306} rx={20} ry={20} />
						<Rect width={80} height={20} x={285} y={364} rx={5} ry={5} />

						<Rect width={80} height={45} x={60} y={428} rx={20} ry={20} />
						<Rect width={80} height={20} x={60} y={490} rx={5} ry={5} />
						<Rect width={80} height={45} x={170} y={428} rx={20} ry={20} />
						<Rect width={80} height={20} x={170} y={490} rx={5} ry={5} />
						<Rect width={80} height={45} x={280} y={428} rx={20} ry={20} />
						<Rect width={80} height={20} x={280} y={490} rx={5} ry={5} />

						<Rect width={180} height={20} x={20} y={560} rx={5} ry={5} />

						<Rect width={Dimensions.get("window").width * 0.9} height={120} x={22} y={620} rx={20} ry={20} />
					</ContentLoader>
				</View>
			</ThemedView>
		);
	}

	return (
		<ThemedView>
			{permission && <LoactionP confirm={() => setPermission(false)} />}
			<StatusBar style={Platform.OS === "ios" ? "dark" : "light"} backgroundColor={colors.primary} />
			<ScrollView
				style={{ marginTop: Platform.OS === "ios" ? 0 : 10 }}
				showsVerticalScrollIndicator={false}
				refreshControl={
					<RefreshControl
						refreshing={refreshing}
						onRefresh={() =>
							startup().then(() => {
								setRefreshing(false);
							})
						}
						tintColor={colors.primary}
						colors={[colors.white]}
						progressBackgroundColor={colors.secondary}
					/>
				}
			>
				<View style={styles.homeContainer}>
					<View
						style={{
							flex: 1,
							display: "flex",
							flexDirection: "row",
							width: "100%",
							height: 130,
							backgroundColor: colors.primary,
							alignItems: "center",
							justifyContent: "space-between",
							paddingLeft: 20,
							paddingRight: 20,
							paddingTop: 30,
						}}
					>
						<TouchableOpacity
							onPress={() => {
								navigation.navigate("ProfileIndex", {
									reload: Math.random(),
									firstL: true,
								});
							}}
						>
							<Image
								style={{
									width: 60,
									height: 60,
									borderRadius: 150,
									marginTop: "auto",
									display: loading ? "none" : "flex",
								}}
								fadeDuration={0}
								source={{ uri: profile?.avatar_url ?? "@assets/loader.gif" }}
								onLoadEnd={() => setLoading(false)}
							/>
						</TouchableOpacity>

						<View
							style={{
								display: "flex",
								flexDirection: "row",
								justifyContent: "space-between",
								alignItems: "center",
								gap: 22,
								right: 20,
								height: 60,
								width: 100,
							}}
						>
							<NotificationsIcon />
							<ProfileSearch />
							<OptionsButton />
						</View>
					</View>

					<View style={styles.container}>
						<TouchableOpacity
							style={{
								...styles.btn,
								justifyContent: "space-between",
								paddingHorizontal: 15,
								backgroundColor: colors.cardColor,
								height: 45,
								marginBottom: "auto",
							}}
							onPress={() => {
								navigation.navigate("Reminders", {
									reload: Math.random(),
								});
							}}
						>
							<View style={{ display: "flex", flexDirection: "row", gap: 10 }}>
								<Ionicons name="clipboard-outline" size={20} color={colors.text} />
								<Text style={{ color: colors.text }}>{i18n.get("home.reminder")}</Text>
							</View>
							<Ionicons name="chevron-forward" size={20} color={colors.text} />
						</TouchableOpacity>
					</View>

					<View style={{ display: "flex", flexDirection: "column", width: "100%", gap: 20, marginTop: 20 }}>
						<Text style={{ color: colors.text, fontSize: 16, marginLeft: 18 }}>{i18n.get("home.placesTitle")}</Text>
						<View
							style={{
								display: "flex",
								flexDirection: "row",
								width: "100%",
								alignItems: "flex-start",
								justifyContent: "center",
								gap: 30,
							}}
						>
							<View
								style={{
									display: "flex",
									flexDirection: "column",
									justifyContent: "center",
									alignItems: "center",
									gap: 10,
								}}
							>
								<TouchableOpacity
									style={{ ...styles.btnBox, backgroundColor: colors.darkGreen }}
									onPress={async () => {
										{
											const { status } = await Location.requestForegroundPermissionsAsync();
											if (status !== "granted") {
												setPermission(true);
												return null;
											}
											navigation.navigate("Search", { queryType: PlaceType.petshops });
										}
									}}
								>
									<View style={{ display: "flex", flexDirection: "row", gap: 10 }}>
										<MaterialCommunityIcons name="storefront-outline" size={20} color={"white"} />
									</View>
								</TouchableOpacity>
								<Text style={{ color: colors.text, width: 75, textAlign: "center" }}>
									{i18n.get(`places.options[${PlaceType.petshops}]`)}
								</Text>
							</View>

							<View
								style={{
									display: "flex",
									flexDirection: "column",
									justifyContent: "center",
									alignItems: "center",
									gap: 10,
								}}
							>
								<TouchableOpacity
									style={{ ...styles.btnBox, backgroundColor: colors.darkGreen }}
									onPress={() => navigation.navigate("Search", { queryType: PlaceType.pet_supply })}
								>
									<View style={{ display: "flex", flexDirection: "row", gap: 10 }}>
										<MaterialCommunityIcons name="store" size={25} color={"white"} />
									</View>
								</TouchableOpacity>

								<Text style={{ color: colors.text, width: 75, textAlign: "center" }}>
									{i18n.get(`places.options[${PlaceType.pet_supply}]`)}
								</Text>
							</View>

							<View
								style={{
									display: "flex",
									flexDirection: "column",
									justifyContent: "center",
									alignItems: "center",
									gap: 10,
								}}
							>
								<TouchableOpacity
									style={{ ...styles.btnBox, backgroundColor: colors.darkGreen }}
									onPress={async () => {
										{
											const { status } = await Location.requestForegroundPermissionsAsync();
											if (status !== "granted") {
												setPermission(true);
												return null;
											}
											navigation.navigate("Search", { queryType: PlaceType.pet_friendly });
										}
									}}
								>
									<View style={{ display: "flex", flexDirection: "row", gap: 10 }}>
										<MaterialCommunityIcons name="cat" size={25} color={"white"} />
									</View>
								</TouchableOpacity>
								<Text style={{ color: colors.text, width: 75, textAlign: "center" }}>
									{i18n.get(`places.options[${PlaceType.pet_friendly}]`)}
								</Text>
							</View>
						</View>

						<View
							style={{
								display: "flex",
								flexDirection: "row",
								width: "100%",
								alignItems: "flex-start",
								justifyContent: "center",
								gap: 30,
							}}
						>
							<View
								style={{
									display: "flex",
									flexDirection: "column",
									justifyContent: "center",
									alignItems: "center",
									gap: 10,
								}}
							>
								<TouchableOpacity
									style={{ ...styles.btnBox, backgroundColor: colors.darkGreen }}
									onPress={async () => {
										{
											const { status } = await Location.requestForegroundPermissionsAsync();
											if (status !== "granted") {
												setPermission(true);
												return null;
											}
											navigation.navigate("Search", { queryType: PlaceType.veterinarians });
										}
									}}
								>
									<View style={{ display: "flex", flexDirection: "row", gap: 10 }}>
										<Ionicons name="pulse-outline" size={20} color={"white"} />
									</View>
								</TouchableOpacity>

								<Text style={{ color: colors.text, width: 75, textAlign: "center" }}>
									{i18n.get(`places.options[${PlaceType.veterinarians}]`)}
								</Text>
							</View>

							<View
								style={{
									display: "flex",
									flexDirection: "column",
									justifyContent: "center",
									alignItems: "center",
									gap: 10,
								}}
							>
								<TouchableOpacity
									style={{ ...styles.btnBox, backgroundColor: colors.darkGreen }}
									onPress={() => navigation.navigate("Search", { queryType: PlaceType.others })}
								>
									<View style={{ display: "flex", flexDirection: "row", gap: 10 }}>
										<Ionicons name="apps-outline" size={20} color={"white"} />
									</View>
								</TouchableOpacity>

								<Text style={{ color: colors.text, width: 75, textAlign: "center" }}>
									{i18n.get(`places.options[${PlaceType.others}]`)}
								</Text>
							</View>

							<SuggestPlace />
						</View>
					</View>

					<View
						style={{
							display: "flex",
							flexDirection: "column",
							width: "100%",
							gap: 20,
							marginTop: 40,
							marginBottom: 100,
						}}
					>
						<View
							style={{
								display: "flex",
								justifyContent: "center",
								alignItems: "flex-start",
								flexDirection: "column",
								paddingRight: 10,
							}}
						>
							<Text style={{ color: colors.text, fontSize: 16, marginLeft: 18 }}>{i18n.get("home.friends")}</Text>
							{walks.length === 0 ? (
								<></>
							) : (
								<View style={{ width: "100%", alignItems: "flex-end", justifyContent: "center", marginTop: 12 }}>
									<TouchableOpacity onPress={() => navigate("MyAllPosts")} style={{ display: "flex" }}>
										<Text style={{ color: colors.text }}>{i18n.get("allWalks")}</Text>
									</TouchableOpacity>
								</View>
							)}
						</View>
						<FlatList
							showsVerticalScrollIndicator={false}
							showsHorizontalScrollIndicator={false}
							contentContainerStyle={{
								backgroundColor: colors.background,
							}}
							horizontal={true}
							alwaysBounceVertical={true}
							data={walks.slice(0, 10)}
							renderItem={renderItem}
							ListEmptyComponent={
								<View
									style={{
										width: windowWidth,
										marginTop: 20,
										display: "flex",
										justifyContent: "center",
										alignItems: "center",
										flexDirection: "column",
									}}
								>
									<Image
										style={{
											width: 180,
											height: 130,
											marginTop: "auto",
										}}
										source={require("@assets/icons/catIcon.png")}
									/>
									<Text style={{ color: colors.text }}>{i18n.get("nothingToSee")}</Text>
								</View>
							}
						/>
					</View>
				</View>
			</ScrollView>
		</ThemedView>
	);
}

const styles = StyleSheet.create({
	homeContainer: {
		// flex: 1,
		display: "flex",
		alignItems: "center",
		justifyContent: "flex-start",
		height: "100%",
	},
	title: {
		color: "white",
		textAlign: "center",
		fontFamily: "Inter",
		marginBottom: 50,
	},
	container: {
		marginTop: 20,
		display: "flex",
		alignItems: "center",
		justifyContent: "center",
		width: "100%",
		padding: 10,
		paddingTop: 0,
	},
	btn: {
		width: "100%",
		height: "100%",
		display: "flex",
		flexDirection: "row",
		justifyContent: "space-evenly",
		alignItems: "center",
		borderRadius: 15,
	},
	text: {
		color: "white",
		textAlign: "center",
		fontFamily: "Inter",
		marginTop: 16,
		paddingHorizontal: 30,
	},
	image: {
		width: 256,
		height: 256,
		transform: [{ scale: 1 }],
		marginTop: "auto",
		marginBottom: "auto",
	},

	paginationContainer: {
		position: "absolute",
		display: "flex",
		flexDirection: "column",
		justifyContent: "space-between",
		alignItems: "center",
		bottom: 25,
		width: "100%",
		paddingHorizontal: 20,
		gap: 10,
	},

	paginationButton: {
		width: "100%",
	},

	btnBox: {
		width: 80,
		height: 45,
		padding: 10,
		display: "flex",
		flexDirection: "row",
		justifyContent: "space-evenly",
		alignItems: "center",
		borderRadius: 20,
	},
});
