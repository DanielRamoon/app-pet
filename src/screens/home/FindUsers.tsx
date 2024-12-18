import Input from "@components/Wrappers/Input";
import ThemedView from "@components/utils/ThemedView";
import { Ionicons, MaterialCommunityIcons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import { FlashList } from "@shopify/flash-list";
import i18n from "@utils/i18n";
import userService, { IUser } from "@utils/supabase/services/user.service";
import { DateTime } from "luxon";
import { Avatar, Box, Button, HStack, Pressable, Spacer, Text, View } from "native-base";
import React, { useCallback, useEffect, useState } from "react";
import { Alert, Dimensions, TouchableOpacity } from "react-native";
import { RefreshControl } from "react-native-gesture-handler";
import Loader from "@components/Loader";
import LoadingModal from "@components/Modals/LoadingModal";
import { supabase } from "@utils/supabase/client";
import QuestionModal from "@components/Modals/QuestionModal";
import followService, { IUserFollow } from "@utils/supabase/services/follow.service";
import SuccessModal from "@components/Modals/SuccessModal";
import { Image } from "expo-image";
import { useRoute } from "@react-navigation/native";

export default function ({ navigation }: NativeStackScreenProps<any, "MainTabs">) {
	const colors = useColors();
	const { params } = useRoute();

	const [userId, setUserId] = useState<string>("");
	const [search, setSearch] = useState("");
	const [users, setUsers] = useState<Partial<IUser>[]>([]);
	const [friendsIds, setFriendsIds] = useState<string[]>([]);
	const [sent, setSent] = useState<IUserFollow[]>([]);
	const [refreshing, setRefreshing] = useState(false);
	const [gettingMore, setGettingMore] = useState(false);

	const [currentPage, setCurrentPage] = useState(0);
	const [endReached, setEndReached] = useState(false);
	const [loading, setLoading] = useState(false);
	const [success, setSuccess] = useState(false);

	const [adding, setAdding] = useState<{ id: string; name: string }>();
	const [removing, setRemoving] = useState<{ requested?: string; requester?: string; name?: string }>();

	async function startup(refresh = false, noSearch = false) {
		if (refresh) {
			const user = await supabase.auth.getUser();
			setUserId(user.data.user?.id ?? "");

			setLoading(true);
			setCurrentPage(0);
			setUsers([]);
			setEndReached(false);

			getUserAlreadySent().finally(() => setLoading(false));
		}

		if (params && (params as any).userId) {
			getNextUsers(null, -1, (params as any).userId);
		}
	}

	useEffect(() => {
		startup();
	}, []);

	useEffect(() => {
		if (search === "") return;
		if (currentPage === 0 && users.length === 0 && endReached === false) getNextUsers(search, 0);
	}, [currentPage, users, endReached]);

	async function sendFollowRequest() {
		if (!adding) return;
		setLoading(true);

		const { messages, trace } = await followService.sendFollowRequest(adding.id);

		if (messages) {
			console.log(trace);
			Alert.alert(i18n.get("alert"), i18n.get("errorSendFollowRequest"));
		}

		setLoading(false);
		setAdding(undefined);

		if (!messages) {
			setSuccess(true);
			setTimeout(() => setSuccess(false), 3000);

			// Mock
			setSent(
				(sent) =>
					[
						...sent,
						{
							requested: adding.id,
							requester: userId,
						},
					] as any
			);
		}
	}

	async function removeFollowRequest() {
		if (!removing) return;
		setLoading(true);

		const { data, messages, trace } = await followService.deleteFollow(removing);

		if (messages) {
			console.log(trace);
			Alert.alert(i18n.get("alert"), i18n.get("errorRemoveFollowRequest"));
		}

		setLoading(false);
		setRemoving(undefined);

		if (!messages) {
			setSuccess(true);
			setTimeout(() => setSuccess(false), 3000);

			if (removing.requested) setSent((sent) => sent.filter((x) => x.requested !== removing.requested));
			else setSent((sent) => sent.filter((x) => x.requester !== removing.requester));
		}
	}

	const getUserAlreadySent = async () => {
		const { data, messages, trace } = await followService.getUserFollows(undefined, { getUserData: false, all: true });

		if (messages) {
			console.log(trace);
			Alert.alert(i18n.get("alert"), i18n.get("getUserAlreadySentError"));
		}

		if (data) setSent(data);
	};

	const getToRemove = useCallback(
		(id: string, name?: string) => {
			const sentUser = sent.find((x) => x.requested === id || x.requester === id);

			if (sentUser?.requested === id) return { requested: id, name };

			return { requester: id, name: name ?? undefined };
		},
		[sent]
	);

	const getNextUsers = useCallback(
		async (username: string | null, page?: number, userId?: string) => {
			// Previnindo buscas iniciais duplicadas
			if (users.length > 0 && page === 0) return;
			if (!username && !userId) return;
			if (endReached) return;
			if (gettingMore) return;

			setGettingMore(true);
			const _users = await userService.getUsers(username ?? String(userId), page ?? currentPage, !!userId);
			setGettingMore(false);

			if (_users.messages) {
				Alert.alert(i18n.get("alert"), i18n.get("profile.errorLoadingProfiles"));
			}

			if (!_users.data) {
				Alert.alert(i18n.get("alert"), i18n.get("profile.errorLoadingProfiles"));
			}

			if (_users?.data?.length === 0) return setEndReached(true);

			setUsers((users) => [...users, ...(_users.data ?? [])]);
			setCurrentPage((currentPage) => (page ?? currentPage) + 1);

			setRefreshing(false);
		},
		[currentPage, users, endReached]
	);

	const renderHeader = () => (
		<Box
			style={{
				display: "flex",
				flexDirection: "row",
				columnGap: 5,
				maxWidth: "100%",
				// paddingHorizontal: 10,
				marginTop: 5,
			}}
		>
			<Input
				value={search}
				label={i18n.get("search")}
				w="83%"
				onChangeText={(text) => setSearch(text)}
				clearable
				onClearText={() => {
					setSearch("");

					startup(true, true);
				}}
				onSubmitEditing={() => startup(true)}
				type="text"
			/>

			<Button w="15%" height={46} onPress={() => startup(true)} style={{ marginTop: "auto" }} bgColor={colors.primary}>
				<MaterialCommunityIcons name={"magnify"} size={24} color={"white"} />
			</Button>
		</Box>
	);

	const getUserAvatar = (item: IUser) => {
		const bucketUrl = `${item.avatar_url}?${DateTime.now().toFormat("dd/MM HH:mm")}`;

		if (item.avatar_url?.includes("ui-avatars")) {
			return item.avatar_url;
		}

		return bucketUrl;
	};

	const renderItem = ({ item, index }: { item: Partial<IUser>; index: number }) => {
		if (item.id === userId) return null;

		return (
			<Pressable
				style={{
					position: "relative",
					marginLeft: "auto",
					marginRight: "auto",
					marginTop: 15,
					width: "100%",
					height: 60,
				}}
				onPress={() => {}}
				delayLongPress={200}
			>
				<Box
					bg={colors.cardColor}
					style={{
						width: "100%",
						flex: 1,
						flexDirection: "row",
					}}
					rounded="5"
				>
					<Box
						style={{
							flex: 1,
							flexDirection: "row",
							justifyContent: "space-between",
						}}
						paddingLeft={2}
						paddingRight={2}
						paddingTop={2}
						paddingBottom={2}
						position="relative"
					>
						<HStack alignItems="center">
							<Image
								source={{
									uri: getUserAvatar(item as any),
								}}
								placeholder={
									"|rF?hV%2WCj[ayj[a|j[az_NaeWBj@ayfRayfQfQM{M|azj[azf6fQfQfQIpWXofj[ayj[j[fQayWCoeoeaya}j[ayfQa{oLj?j[WVj[ayayj[fQoff7azayj[ayj[j[ayofayayayj[fQj[ayayj[ayfjj[j[ayjuayj["
								}
								style={{
									width: 42,
									height: 42,
									borderRadius: 21,
									borderWidth: 1,
									borderColor: colors.cardColor,
									// fallback for ios
									backgroundColor: colors.cardColor,
								}}
							/>

							<View style={{ display: "flex", flexDirection: "column", paddingLeft: 15 }}>
								<Text
									style={{ marginTop: 5 }}
									color={colors.text}
									fontWeight="medium"
									fontSize="xl"
									numberOfLines={1}
									lineHeight={27}
									ellipsizeMode="tail"
									maxWidth={Dimensions.get("window").width - 150}
								>
									{item.user_name}
								</Text>
							</View>
						</HStack>

						{sent.find((x) => x.requested === item.id || x.requester === item.id) ? (
							<TouchableOpacity
								style={{ marginTop: "auto", marginBottom: "auto" }}
								onPress={() => setRemoving(getToRemove(item?.id!, item?.user_name ?? undefined))}
							>
								<Ionicons name="person-remove" size={24} color={colors.danger} />
							</TouchableOpacity>
						) : (
							<TouchableOpacity
								style={{ marginTop: "auto", marginBottom: "auto" }}
								onPress={() => setAdding({ id: item.id!, name: String(item.user_name) })}
							>
								<Ionicons name="person-add" size={24} color={colors.primary} />
							</TouchableOpacity>
						)}

						{/* <HStack alignItems="center">
							<Spacer />

							<Text fontSize={10} color={colors.text} style={{ ...flex.myAuto }}>
								{getPetDuration(item.birth_date)}
							</Text>
						</HStack> */}
					</Box>
				</Box>
			</Pressable>
		);
	};

	const renderEmpty = () => (
		<Box
			style={{
				display: "flex",
				flexDirection: "column",
				alignItems: "center",
				justifyContent: "center",
				marginTop: 50,
			}}
		>
			<Text color={colors.text} fontSize="xl" fontWeight="bold">
				{search === "" || currentPage === 0 ? i18n.get("noUsers") : i18n.get("noUsersFound")}
			</Text>
		</Box>
	);

	return (
		<>
			{loading && <LoadingModal />}
			{adding && (
				<QuestionModal
					title={i18n.get("sendFollowRequestTitle")}
					customBody={
						<Text style={{ padding: 10 }}>{i18n.get("sendFollowRequest").replace("$USER", adding.name)}</Text>
					}
					confirm={() => sendFollowRequest()}
					cancel={() => setAdding(undefined)}
					customHeight={180}
				/>
			)}
			{removing && (
				<QuestionModal
					title={i18n.get("removeFollowRequestTitle")}
					customBody={
						<Text style={{ padding: 10 }}>{i18n.get("removeFollowRequest").replace("$USER", removing.name)}</Text>
					}
					confirm={() => removeFollowRequest()}
					cancel={() => setRemoving(undefined)}
				/>
			)}
			{success && <SuccessModal />}

			<ThemedView isRoot>
				{renderHeader()}
				<FlashList
					showsVerticalScrollIndicator={false}
					// ListHeaderComponent={renderHeader}
					refreshControl={
						<RefreshControl
							refreshing={refreshing}
							onRefresh={() => (setRefreshing(true), startup(true).then(() => setRefreshing(false)))}
							tintColor={colors.primary}
							colors={[colors.white]}
							progressBackgroundColor={colors.lightGreen}
						/>
					}
					contentContainerStyle={{ paddingTop: 10 }}
					alwaysBounceVertical={true}
					data={users}
					renderItem={renderItem}
					ListFooterComponent={
						users.length === 0 ? (
							renderEmpty
						) : gettingMore ? (
							<Loader onlyDog bgColor={colors.background} />
						) : (
							<Box height={100} />
						)
					}
					estimatedItemSize={200}
					onEndReached={() => {
						if (currentPage === 0) return;
						getNextUsers(search);
					}}
					extraData={[sent]}
					// onEndReachedThreshold={0.25}
				/>
			</ThemedView>
		</>
	);
}
