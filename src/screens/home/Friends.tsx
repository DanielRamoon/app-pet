import Loader from "@components/Loader";
import ThemedView from "@components/utils/ThemedView";
import { FontAwesome5, Ionicons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import { FlashList } from "@shopify/flash-list";
import i18n from "@utils/i18n";
import { goBack } from "@utils/navigator";
import { supabase } from "@utils/supabase/client";
import followService, { IUserFollow } from "@utils/supabase/services/follow.service";
import { Image } from "expo-image";
import { DateTime } from "luxon";
import { Box, HStack, Pressable, Text } from "native-base";
import React, { useEffect, useState } from "react";
import ContentLoader, { Rect } from "react-content-loader/native";
import { Alert, Dimensions, RefreshControl, StyleSheet, TouchableOpacity, View } from "react-native";

export default function ({ navigation }: NativeStackScreenProps<any, "MainTabs">) {
	const colors = useColors();
	const windowWidth = Dimensions.get("window").width;

	const [loading, setLoading] = useState(true);

	const [currentPage, setCurrentPage] = useState(0);
	const [follows, setFollows] = useState<IUserFollow[]>([]);
	const [endReached, setEndReached] = useState(false);
	const [gettingMore, setGettingMore] = useState(true);
	const [userId, setUserId] = useState<string | null>(null);

	async function startup(refresh = false) {
		setLoading(true);

		const { data: userAuthenticated } = await supabase.auth.getUser();

		if (!userAuthenticated || !userAuthenticated.user) return goBack();

		setUserId(userAuthenticated.user?.id!);

		if (refresh) {
			setCurrentPage(0);
			setEndReached(false);
			await new Promise((resolve) => setTimeout(resolve, 1000));
		}

		const allRequests = await followService.getUserFollows(0, { getUserData: true, all: true });

		if (allRequests.status !== 200) return Alert.alert(i18n.get("error"), i18n.get("errorGettingFollows"));

		setFollows(allRequests.data!);

		setTimeout(() => {
			setGettingMore(false);
		}, 1000);
	}

	async function getNextPage() {
		if (gettingMore || endReached) return;

		setGettingMore(true);

		let page = currentPage;
		setCurrentPage((c) => c + 1);

		const newFollows = await followService.getUserFollows(page + 1, { getUserData: true, all: true });

		if (newFollows.status !== 200)
			return Alert.alert(i18n.get("error"), i18n.get("errorGettingFollows"), [{ text: "OK", onPress: goBack }]);

		if (!newFollows.data || newFollows.data!.length === 0) {
			setEndReached(true);
			setGettingMore(false);
			return;
		}

		setFollows([...follows, ...newFollows.data!]);
		setGettingMore(false);
	}

	async function acceptOrRemove(item: IUserFollow, forceRemove = false) {
		if (item.accepted || forceRemove) {
			Alert.alert(i18n.get("removeFriend"), i18n.get("removeFriendQuestion"), [
				{
					text: i18n.get("cancel"),
					onPress: () => {},
					style: "cancel",
				},
				{
					text: i18n.get("remove"),
					onPress: () => removeFriendRequest(item),
					style: "destructive",
				},
			]);
		} else {
			Alert.alert(i18n.get("acceptFriend"), i18n.get("acceptFriendQuestion"), [
				{
					text: i18n.get("cancel"),
					onPress: () => {},
					style: "cancel",
				},
				{
					text: i18n.get("accept"),
					onPress: () => acceptFriendRequest(item),
				},
			]);
		}
	}

	const removeFriendRequest = async (item: IUserFollow) => {
		setLoading(true);

		try {
			const removed = await followService.deleteFollow({
				requested: item.requested_data!.id,
				requester: item.requester_data!.id,
			});

			if (removed.status !== 200) return Alert.alert(i18n.get("error"), i18n.get("errorRemovingFriend"));

			const newFollows = follows.filter((f) => f.id !== item.id);

			setFollows(newFollows);
		} catch (error: any) {
			Alert.alert(i18n.get("error"), error.message);
		} finally {
			setLoading(false);
		}
	};

	const acceptFriendRequest = async (item: IUserFollow) => {
		setLoading(true);

		try {
			const accepted = await followService.acceptFollowRequest(item.requester_data!.id);

			if (accepted.status !== 200) return Alert.alert(i18n.get("error"), i18n.get("errorAcceptingFriend"));

			const newFollows = follows.map((f) => {
				if (f.id === item.id) {
					f.accepted = true;
				}
				return f;
			});

			setFollows(newFollows);
		} catch (error: any) {
			Alert.alert(i18n.get("error"), error.message);
		} finally {
			setLoading(false);
		}
	};

	const getUserAvatar = (item: IUserFollow["requested_data"]) => {
		const bucketUrl = `${item!.avatar_url}?${DateTime.now().toFormat("dd/MM HH:mm")}`;

		if (item!.avatar_url?.includes("ui-avatars")) {
			return item!.avatar_url;
		}

		return bucketUrl;
	};

	useEffect(() => {
		startup().finally(() => setTimeout(() => setLoading(false), 1000));
	}, []);

	const renderItem = ({ item, index }: { item: IUserFollow; index: number }) => {
		const friend = item.requested === userId ? item.requester_data : item.requested_data;
		const previousIsSentByMe = follows[index - 1]?.requester === userId;
		const sentByMe = item.requester === userId;

		return (
			<>
				{/* {index === 0 && !item.accepted && (
					<Text style={[Styles.cardTitle, { color: colors.text }]}>{i18n.get("pending")}</Text>
				)} */}

				{index === 0 && follows[0] && !follows[0].accepted && sentByMe && !previousIsSentByMe && (
					<Text style={[Styles.cardTitle, { color: colors.text }]}>{i18n.get("sentByMe")}</Text>
				)}

				{follows[index - 1] &&
					!follows[index - 1].accepted &&
					!follows[index].accepted &&
					sentByMe &&
					!previousIsSentByMe && <Text style={[Styles.cardTitle, { color: colors.text }]}>{i18n.get("sentByMe")}</Text>}

				{follows[index - 1] &&
					!follows[index - 1].accepted &&
					!follows[index].accepted &&
					!sentByMe &&
					previousIsSentByMe && (
						<Text style={[Styles.cardTitle, { color: colors.text }]}>{i18n.get("receivedByMe")}</Text>
					)}

				{follows[index - 1] && !follows[index - 1].accepted && item.accepted && (
					<Text style={[Styles.cardTitle, { color: colors.text }]}>{i18n.get("accepted")}</Text>
				)}

				<Pressable
					style={{
						position: "relative",
						marginLeft: "auto",
						marginRight: "auto",
						marginTop: 15,
						width: "95%",
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
							}}
							paddingLeft={2}
							paddingRight={2}
							paddingTop={2}
							paddingBottom={2}
						>
							<HStack alignItems="center">
								<Image
									source={{
										uri: getUserAvatar(friend),
									}}
									// placeholder={
									// 	"|rF?hV%2WCj[ayj[a|j[az_NaeWBj@ayfRayfQfQM{M|azj[azf6fQfQfQIpWXofj[ayj[j[fQayWCoeoeaya}j[ayfQa{oLj?j[WVj[ayayj[fQoff7azayj[ayj[j[ayofayayayj[fQj[ayayj[ayfjj[j[ayjuayj["
									// }
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

								<View style={{ display: "flex", flexDirection: "column", paddingLeft: 15, width: "70%" }}>
									<Text
										style={{ marginTop: 5 }}
										color={colors.text}
										fontWeight="medium"
										fontSize="xl"
										numberOfLines={1}
										lineHeight={27}
										ellipsizeMode="tail"
										// maxWidth={Dimensions.get("window").width - 150}
									>
										{friend!.user_name}
									</Text>
								</View>
							</HStack>

							<View
								style={{
									display: "flex",
									flexDirection: "row",
									height: "100%",
									justifyContent: "space-between",
									alignItems: "center",
									marginLeft: "auto",
									marginRight: 5,
									gap: 15,
								}}
							>
								{!item.accepted && (
									<TouchableOpacity onPress={() => acceptOrRemove(item, true)}>
										<FontAwesome5 name={"user-minus"} size={22} color={colors.danger} />
									</TouchableOpacity>
								)}

								{!item.accepted && !sentByMe && (
									<TouchableOpacity onPress={() => acceptOrRemove(item)}>
										<FontAwesome5
											name={item.accepted ? "user-minus" : "user-check"}
											size={22}
											color={item.accepted ? colors.danger : colors.primary}
										/>
									</TouchableOpacity>
								)}

								{item.accepted && (
									<TouchableOpacity onPress={() => acceptOrRemove(item)}>
										<FontAwesome5
											name={item.accepted ? "user-minus" : "user-check"}
											size={22}
											color={item.accepted ? colors.danger : colors.primary}
										/>
									</TouchableOpacity>
								)}
							</View>
						</Box>
					</Box>
				</Pressable>

				{follows[index] && follows[index + 1] && follows[index + 1].accepted && !follows[index].accepted && (
					<View
						style={{
							width: "95%",
							marginLeft: "auto",
							marginRight: "auto",
							marginTop: 15,
							borderBottomWidth: 1,
							borderBottomColor: colors.text,
						}}
					/>
				)}
			</>
		);
	};
	if (loading) {
		return (
			<ThemedView>
				<View
					style={{
						flex: 1,
						justifyContent: "flex-start",
						alignItems: "center",
					}}
				>
					<ContentLoader
						viewBox={`0 0 ${Dimensions.get("window").width} ${Dimensions.get("window").height}`}
						backgroundColor={colors.loaderBackColor}
						foregroundColor={colors.loaderForeColor}
					>
						<Rect width={Dimensions.get("window").width} height={60} x={0} y={40} rx={5} ry={5} />
					</ContentLoader>
				</View>
			</ThemedView>
		);
	}

	return (
		<ThemedView>
			<View style={{ flex: 1, backgroundColor: colors.background }}>
				<FlashList
					showsVerticalScrollIndicator={false}
					// refreshing={refreshing}
					// onRefresh={() => startup().then(() => setRefreshing(false))}
					refreshControl={
						<RefreshControl
							refreshing={loading}
							onRefresh={() => startup(true).finally(() => setTimeout(() => setLoading(false), 1000))}
							tintColor={colors.primary}
							colors={[colors.white]}
							progressBackgroundColor={colors.lightGreen}
						/>
					}
					contentContainerStyle={{ paddingTop: 10 }}
					// ListHeaderComponent={renderHeader}
					alwaysBounceVertical={true}
					data={follows}
					renderItem={renderItem}
					ListFooterComponent={
						gettingMore ? (
							<View
								style={{
									width: Dimensions.get("window").width,
									height: Dimensions.get("window").height,
									display: "flex",
									justifyContent: "center",
									backgroundColor: colors.background,
									alignItems: "center",
								}}
							>
								<ContentLoader
									viewBox={`0 0 ${Dimensions.get("window").width * 0.95} ${Dimensions.get("window").height}`}
									backgroundColor={colors.loaderBackColor}
									foregroundColor={colors.loaderForeColor}
								>
									<Rect width={Dimensions.get("window").width * 0.95} height={60} x={0} y={20} rx={5} ry={5} />
								</ContentLoader>
							</View>
						) : !gettingMore && follows.length === 0 ? (
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
						) : (
							<Box height={100} />
						)
					}
					onEndReached={() => getNextPage()}
					onEndReachedThreshold={0.25}
					estimatedItemSize={100}
					// extraData={selectedWalks}
				/>
			</View>
		</ThemedView>
	);
}

const Styles = StyleSheet.create({
	cardTitle: {
		fontSize: 18,
		marginLeft: 10,
		marginTop: 15,
	},
});
