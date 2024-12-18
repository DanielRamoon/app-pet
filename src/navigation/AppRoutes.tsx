import ClearNotificationsIcon from "@components/Navigation/Bar/ClearNotificationButtons";
import EditNDeleteAccount from "@components/Navigation/Bar/EditNDeleteAccount";
import EditReminder from "@components/Navigation/Bar/EditReminder";
import MapLeft from "@components/Navigation/Bar/MapLeft";
import PetEdit from "@components/Navigation/Bar/PetEdit";
import PetListOptions from "@components/Navigation/Bar/PetListOptions";
import SearchFriend from "@components/Navigation/Bar/SearchFriend";
import TabBar from "@components/Navigation/index";
import ThemedView from "@components/utils/ThemedView";
import { Ionicons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import { createStackNavigator } from "@react-navigation/stack";
import FirstAccess from "@screens/FirstAccess";
import NotificationList from "@screens/NotificationList";
import AllFriendWalks from "@screens/posts/AllWalks";
import Config from "@screens/home/Config";
import FindUsers from "@screens/home/FindUsers";
import Friends from "@screens/home/Friends";
import Home from "@screens/home/Home";
import NewPost from "@screens/home/NewPost";
import MapView from "@screens/map/Index";
import PetScreens from "@screens/pets/screens";
import PlaceDescription from "@screens/places/PlaceDescription";
import PlacesSearchView from "@screens/places/Search";
import Suggest from "@screens/places/Suggest";
import ProfileScreens from "@screens/profile/screens";
import AddReminder from "@screens/reminder/AddReminder";
import Note from "@screens/reminder/Note";
import Reminder from "@screens/reminder/Reminder";
import flex from "@styles/flex";
import i18n from "@utils/i18n";
import { goBack, navigate } from "@utils/navigator";
import * as Notifications from "expo-notifications";
import React, { useEffect, useRef } from "react";
import { Animated, DeviceEventEmitter, StatusBar, StyleProp, TouchableOpacity, View, ViewStyle } from "react-native";
import { useSelector } from "react-redux";
import { RootState } from "src/store/store";
import { Route, SceneInterpolatorProps } from "types/navigation";
import MyAllPosts from "@screens/home/MyAllPosts";
import SeeUserLikes from "@screens/home/SeeUserLikes";
import { Text } from "react-native";
import { openURL } from "expo-linking";
import { Platform } from "react-native";

const horizontalPageAnimation = {
	// gestureEnabled: true,
	// gestureDirection: "horizontal" as const,
	transitionSpec: {
		open: {
			animation: "timing",
			config: {
				duration: 300,
			},
		},
		close: {
			animation: "timing",
			config: {
				duration: 300,
			},
		},
	},
	cardStyleInterpolator: <T extends Route>(
		props: SceneInterpolatorProps<T>
	): {
		cardStyle: Animated.WithAnimatedValue<StyleProp<ViewStyle>>;
		overlayStyle?: Animated.WithAnimatedValue<StyleProp<ViewStyle>>;
	} => {
		const { current, layouts } = props;
		return {
			cardStyle: {
				transform: [
					{
						translateX: current.progress.interpolate({
							inputRange: [0, 1],
							outputRange: [layouts.screen.width, 0],
						}),
					},
				],
			},
			// overlayStyle: {
			// 	opacity: current.progress.interpolate({
			// 		inputRange: [0, 1],
			// 		outputRange: [0, 0.5],
			// 	}),
			// },
		};
	},
};

const InvisibleButton = ({ key }: any) => (
	<TouchableOpacity style={{ display: "none" }} key={key}>
		<View style={{ width: 0, height: 0 }} />
	</TouchableOpacity>
);

const BackButton = (props: { customOnPress?: () => void } | any) => {
	const colors = useColors();

	return (
		<TouchableOpacity
			onPress={() => (props.customOnPress ? props.customOnPress() : goBack())}
			style={{ display: "flex", justifyContent: "center", width: 50, height: "100%", paddingLeft: 15 }}
		>
			<Ionicons name="chevron-back" size={24} color={colors.text} style={{ ...flex.mxAuto }} />
		</TouchableOpacity>
	);
};

const AppStack = createStackNavigator();
const AppTab = createBottomTabNavigator();

function GlobalStack(props: any) {
	return (
		<AppStack.Navigator
			initialRouteName="FirstAccess"
			screenOptions={{
				headerTitleAlign: "center",
				headerBackTitleVisible: false,
				cardStyle: { backgroundColor: props.colors.background },
				...(horizontalPageAnimation as any),
			}}
		>
			<AppStack.Screen
				name="FirstAccess"
				options={{
					headerShown: false,
					headerTitle: "Petvidade - " + i18n.get("firstAccess.title"),
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
					},
					headerTintColor: props.colors.text,
					headerLeft: () => <BackButton />,
				}}
				component={FirstAccess}
			/>
		</AppStack.Navigator>
	);
}

function HomeStack(props: any) {
	return (
		<AppStack.Navigator
			initialRouteName="Index"
			screenOptions={{
				cardStyleInterpolator: ({ current, next, layouts }: any) => {
					const opacity = current.progress.interpolate({
						inputRange: [0, 1],
						outputRange: [0, 1],
					});

					return {
						cardStyle: {
							opacity,
							transform: [
								{
									translateY: current.progress.interpolate({
										inputRange: [0, 1],
										outputRange: [layouts.screen.height, 0],
									}),
								},
							],
						},
						overlayStyle: {
							opacity: current.progress.interpolate({
								inputRange: [0, 1],
								outputRange: [0, 0.5],
							}),
						},
					};
				},
			}}
		>
			<AppStack.Screen
				name="Index"
				options={{
					headerShown: false,
				}}
				component={Home}
			/>

			<AppStack.Screen
				name="Friends"
				options={{
					title: i18n.get("screens.friends"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					headerRight: () => <SearchFriend />,
					headerLeft: () => <BackButton />,
				}}
				component={Friends}
			/>

			<AppStack.Screen
				name="FindUsers"
				options={{
					title: i18n.get("screens.findUsers"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					// headerRight: () => <ProfileSearch />,
					headerLeft: () => <BackButton />,
				}}
				component={FindUsers}
			/>

			<AppStack.Screen
				name="MyAllPosts"
				options={{
					title: i18n.get("screens.myAllPosts"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					// headerRight: () => <ProfileSearch />,
					headerLeft: () => <BackButton />,
				}}
				component={MyAllPosts}
			/>

			<AppStack.Screen
				name="SeeUserLikes"
				options={{
					title: i18n.get("screens.seeLikes"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					// headerRight: () => <ProfileSearch />,
					headerLeft: () => <BackButton />,
				}}
				component={SeeUserLikes}
			/>

			<AppStack.Screen
				name="Config"
				options={{
					title: i18n.get("screens.config"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					headerLeft: BackButton,

					// headerRight: () => <ProfileOptionsButton />,
				}}
				component={Config}
			/>

			<AppStack.Screen
				name="NewPost"
				options={{
					title: i18n.get("home.newPost"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					headerLeft: BackButton,

					// headerRight: () => <ProfileOptionsButton />,
				}}
				component={NewPost}
			/>

			<AppStack.Screen
				name="AddReminder"
				options={{
					title: i18n.get("screens.addReminder"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					headerLeft: BackButton,
				}}
				component={AddReminder}
			/>

			<AppStack.Screen
				name="BoasVindas"
				options={{
					headerShown: false,
				}}
				component={ThemedView}
			/>

			<AppStack.Screen
				name="Search"
				options={{
					title: i18n.get("screens.places"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					// headerLeft: () => <MapLeft backButton={BackButton} />,
					headerLeft: () => <BackButton />,
				}}
				component={PlacesSearchView}
			/>
			<AppStack.Screen
				name="Suggest"
				options={{
					title: i18n.get("screens.places"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					// headerLeft: () => <MapLeft backButton={BackButton} />,
					headerLeft: () => <BackButton />,
				}}
				component={Suggest}
			/>

			<AppStack.Screen
				name="PlaceDescription"
				options={{
					title: i18n.get("screens.description"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
				}}
				component={PlaceDescription}
			/>

			<AppStack.Screen
				name="NotificationList"
				options={{
					title: i18n.get("screens.notifications"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					headerRight: () => <ClearNotificationsIcon />,
					headerLeft: () => <BackButton />,
				}}
				component={NotificationList}
			/>

			<AppStack.Screen
				name="Reminders"
				options={{
					title: i18n.get("home.reminder"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					headerLeft: BackButton,
				}}
				component={Reminder}
			/>

			<AppStack.Screen
				name="Note"
				options={{
					title: "",
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					headerRight: () => <EditReminder />,
				}}
				component={Note}
			/>

			<AppStack.Screen
				name="ProfileIndex"
				options={{
					title: i18n.get("screens.profile"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					headerLeft: () => <BackButton />,
					headerRight: () => <EditNDeleteAccount />,
				}}
				component={ProfileScreens.Index}
			/>

			<AppStack.Screen
				name="Edit"
				options={{
					title: i18n.get("screens.editProfile"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					headerLeft: BackButton,

					// headerRight: () => <ProfileOptionsButton />,
				}}
				component={ProfileScreens.Edit}
			/>
		</AppStack.Navigator>
	);
}

function FriendsPostsStack(props: any) {
	return (
		<AppStack.Navigator initialRouteName="Index" screenOptions={horizontalPageAnimation as any}>
			<AppStack.Screen
				name="Index"
				options={{
					title: i18n.get("posts.title"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
				}}
				component={AllFriendWalks}
			/>
		</AppStack.Navigator>
	);
}

function PetsStack(props: any) {
	return (
		<AppStack.Navigator initialRouteName="Index" screenOptions={horizontalPageAnimation as any}>
			<AppStack.Screen
				name="Index"
				options={{
					title: i18n.get("pets.screens.list"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					headerRight: () => <PetListOptions />,
				}}
				component={PetScreens.Home}
			/>

			<AppStack.Screen
				name="New"
				options={{
					title: i18n.get("pets.screens.add"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					headerLeft: BackButton,
				}}
				component={PetScreens.New}
			/>

			<AppStack.Screen
				name="Profile"
				options={{
					title: i18n.get("pets.screens.profile"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					headerLeft: BackButton,
					headerRight: () => <PetEdit />,
				}}
				component={PetScreens.Profile}
			/>

			<AppStack.Screen
				name="Edit"
				options={{
					title: i18n.get("pets.screens.edit"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					headerLeft: BackButton,
					// headerRight: () => <PetEdit />,
				}}
				component={PetScreens.Edit}
			/>

			<AppStack.Screen
				name="EditMedicine"
				options={{
					title: i18n.get("pets.screens.editMedicine"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					headerLeft: BackButton,
					// headerRight: () => <PetEdit />,
				}}
				component={PetScreens.EditMedicine}
			/>

			<AppStack.Screen
				name="Vaccines"
				options={{
					title: i18n.get("pets.screens.vaccines"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					headerLeft: BackButton,
					// headerRight: () => <PetEdit />,
				}}
				component={PetScreens.Vaccines}
			/>

			<AppStack.Screen
				name="Medicines"
				options={{
					title: i18n.get("pets.screens.medicines"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					headerLeft: BackButton,
					// headerRight: () => <PetEdit />,
				}}
				component={PetScreens.Medicines}
			/>

			<AppStack.Screen
				name="Products"
				options={{
					title: i18n.get("pets.screens.products"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					headerLeft: BackButton,
					// headerRight: () => <PetEdit />,
				}}
				component={PetScreens.Products}
			/>
		</AppStack.Navigator>
	);
}

function MapStack(props: any) {
	return (
		<AppStack.Navigator initialRouteName="Index" screenOptions={horizontalPageAnimation as any}>
			<AppStack.Screen
				name="Index"
				options={{
					title: i18n.get("screens.map"),
					headerShown: props.headerShown ?? true,
					headerStyle: {
						backgroundColor: props.colors.tabBarColor,
						borderBottomColor: "transparent",
						shadowOpacity: 0,
						shadowColor: "transparent",
						elevation: 0,
					},
					headerTintColor: props.colors.text,
					headerTransparent: false,
					headerLeft: () => <MapLeft backButton={BackButton} />,
					headerRight: () => (
						<TouchableOpacity
							style={{ paddingRight: 15 }}
							onPress={() =>
								openURL(
									Platform.OS === "ios"
										? "https://support.apple.com/102515"
										: "https://support.google.com/maps/answer/2839911?co=GENIE.Platform%3DAndroid"
								)
							}
						>
							<Text style={{ color: props.colors.text }}>{i18n.get("walkingAlone")}</Text>
						</TouchableOpacity>
					),
				}}
				component={MapView}
			/>
		</AppStack.Navigator>
	);
}

const AppRoutes: React.FC<{ startHidden?: boolean }> = (props) => {
	const colors = useColors();

	const notification = useRef<Notifications.NotificationResponse>();
	const currentWalk = useSelector((state: RootState) => state.currentWalk) as any;

	useEffect(() => {
		async function processParams() {
			const params = await AsyncStorage.getItem("params");

			if (!params) return;

			if (params.includes("userId")) {
				const userId = params.split("userId=")[1];

				navigate("Home", {
					screen: "FindUsers",
					params: {
						userId,
					},
				});
			}
		}

		const onUrlOpen = DeviceEventEmitter.addListener("onUrlOpen", (url: string) => {
			AsyncStorage.removeItem("params");

			if (url.includes("userId")) {
				const userId = url.split("userId=")[1];

				navigate("Home", {
					screen: "FindUsers",
					params: {
						userId,
					},
				});
			}
		});

		processParams();

		return () => onUrlOpen.remove();
	}, []);

	useEffect(() => {
		DeviceEventEmitter.addListener("notificationTap", (notificationReceived: Notifications.NotificationResponse) => {
			notification.current = notificationReceived;
		});
	}, []);

	return (
		<>
			<StatusBar hidden={false} backgroundColor={"#f67f31"} barStyle={"light-content"} />
			<AppTab.Navigator
				initialRouteName="Global"
				tabBar={(props) => <TabBar {...props} hidden={currentWalk.hideTabBar} />}
			>
				<AppTab.Screen name="Global" options={{ tabBarButton: InvisibleButton, headerShown: false }}>
					{(props) => <GlobalStack {...props} colors={colors} headerShown={false} />}
				</AppTab.Screen>

				<AppTab.Screen
					name="Home"
					options={{
						title: "Home",
						headerShown: false,
						tabBarLabel: i18n.get("screens.home"),
					}}
				>
					{(props) => <HomeStack {...props} colors={colors} headerShown={!currentWalk.hideAppBar} />}
				</AppTab.Screen>

				<AppTab.Screen
					name="AllFriendWalks"
					options={{
						title: "Posts",
						tabBarLabel: i18n.get("screens.posts"),
						headerShown: false,
						unmountOnBlur: false,
					}}
				>
					{(props) => <FriendsPostsStack {...props} colors={colors} headerShown={!currentWalk.hideAppBar} />}
				</AppTab.Screen>

				<AppTab.Screen
					name="Pets"
					options={{
						title: "Pets",
						headerShown: false,
						tabBarLabel: i18n.get("screens.pets"),
						tabBarHideOnKeyboard: true,
						unmountOnBlur: false,
					}}
				>
					{(props) => <PetsStack {...props} colors={colors} headerShown={!currentWalk.hideAppBar} />}
				</AppTab.Screen>

				{/* <AppTab.Screen
					name="MiddleButton"
					options={{
						title: "MiddleButton",
						headerShown: false,
						// tabBarLabel: i18n.get("screens.home"),
					}}
				>
					{(props) => <MapStack {...props} colors={colors} headerShown={showAppBar} />}
				</AppTab.Screen> */}

				<AppTab.Screen
					name="Map"
					options={{
						title: "Map",
						tabBarLabel: i18n.get("screens.map"),
						headerShown: false,
						unmountOnBlur: true,
					}}
				>
					{(props) => <MapStack {...props} colors={colors} headerShown={!currentWalk.hideAppBar} />}
				</AppTab.Screen>
			</AppTab.Navigator>
		</>
	);
};

export default AppRoutes;
