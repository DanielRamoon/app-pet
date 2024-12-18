import Loader from "@components/Loader";
import ThemedView from "@components/utils/ThemedView";
import { Ionicons, MaterialCommunityIcons } from "@expo/vector-icons";
import useAppTheme from "@hooks/useAppTheme";
import useColors from "@hooks/useColors";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import { FlashList } from "@shopify/flash-list";
import i18n from "@utils/i18n";
import { supabase } from "@utils/supabase/client";
import followService, { IUserFollow } from "@utils/supabase/services/follow.service";
import { DateTime } from "luxon";
import { Avatar, Box, Button, HStack, Pressable, Spacer, Text, View } from "native-base";
import React, { useCallback, useEffect, useState } from "react";
import { Alert, Dimensions, RefreshControl, StyleSheet } from "react-native";
import { TouchableOpacity } from "react-native-gesture-handler";
import flex from "@styles/flex";
import QuestionModal from "@components/Modals/QuestionModal";
import SuccessModal from "@components/Modals/SuccessModal";

export default function ({ navigation }: NativeStackScreenProps<any, "MainTabs">) {
	const colors = useColors();

	const [refreshing, setRefreshing] = useState(false);
	const [loading, setLoading] = useState(true);

	const [notifications, setNotifications] = useState<IUserFollow[]>([]);
	const [currentPage, setCurrentPage] = useState(0);
	const [gettingMore, setGettingMore] = useState(false);

	const [endReached, setEndReached] = useState(false);

	const [success, setSuccess] = useState(false);
	const [accepting, setAccepting] = useState({ requesterId: -1, requesterName: "" });
	const [deleting, setDeleting] = useState({ requesterId: -1, requesterName: "" });

	async function startup(refresh?: boolean) {
		if (refresh) {
			setCurrentPage(0);
			setNotifications(() => []);
			setEndReached(false);

			await new Promise((resolve) => setTimeout(() => (getNextNotifications(0, true), resolve(true)), 3000));
		}

		if (!refresh) setLoading(true);
		else setRefreshing(true);

		if (!refresh) await getNextNotifications(0);
	}

	useEffect(() => {
		const unsubscribe = navigation.addListener("focus", () => {
			startup().finally(() => setTimeout(() => setLoading(false), 1000));
		});

		return () => unsubscribe();
	}, []);

	const getNextNotifications = useCallback(
		async (page?: number, force?: boolean) => {
			// Previnindo buscas iniciais duplicadas
			if (notifications.length > 0 && page === 0 && !force) return;
			if (endReached) return;
			if (gettingMore) return;

			setGettingMore(true);
			const _notifications = await followService.getUserFollows(page ?? currentPage, { getUserData: true });
			setGettingMore(false);

			if (_notifications.messages) {
				Alert.alert(i18n.get("alert"), i18n.get("profile.errorLoadingNotifications"));
			}

			if (!_notifications.data && !_notifications.messages) {
				Alert.alert(i18n.get("alert"), i18n.get("profile.errorLoadingNotifications"));
			}

			if (_notifications?.data?.length === 0) return setEndReached(true);

			if (force) setNotifications((_) => [...(_notifications.data ?? [])]);
			else setNotifications((notifications) => [...notifications, ...(_notifications.data ?? [])]);

			setCurrentPage((currentPage) => (page ?? currentPage) + 1);

			setRefreshing(false);
		},
		[currentPage, notifications, endReached]
	);

	if (loading) {
		return (
			<ThemedView fadeIn>
				<Loader bgColor={colors.background} />
			</ThemedView>
		);
	}

	const renderItem = ({ item, index }: { item: IUserFollow; index: number }) => {
		return (
			<Pressable
				style={{
					marginLeft: "auto",
					marginRight: "auto",
					marginTop: 15,
					width: "100%",
					marginBottom: index === (notifications?.length || 1) - 1 ? 15 : 0,
					minHeight: 100,
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
							position: "relative",
							flex: 1,
							flexDirection: "column",
							justifyContent: "space-between",
						}}
						paddingLeft={2}
						paddingRight={2}
						paddingTop={2}
						paddingBottom={2}
					>
						<View style={{ flexDirection: "row", justifyContent: "flex-end", gap: 5 }}>
							<Text style={{ marginRight: "auto", ...flex.myAuto }}>{i18n.get("followRequest")}</Text>

							<TouchableOpacity
								onPress={() => {
									setAccepting({
										requesterId: item.requester_data?.id as unknown as number,
										requesterName: item.requester_data?.user_name || "",
									});
								}}
								style={{ marginLeft: "auto" }}
							>
								<Ionicons name="checkmark" size={26} color={colors.primary} />
							</TouchableOpacity>
							<TouchableOpacity
								onPress={() =>
									setDeleting({
										requesterId: item.requester_data?.id as unknown as number,
										requesterName: item.requester_data?.user_name || "",
									})
								}
								style={{ marginLeft: "auto" }}
							>
								<Ionicons name="trash-bin-outline" size={24} color={colors.danger} />
							</TouchableOpacity>
						</View>

						<HStack alignItems="center" style={{ marginBottom: 15 }}>
							<Avatar
								bg={colors.primary}
								source={{
									uri: `${item.requester_data?.avatar_url}?${DateTime.now().toFormat("dd/MM HH:mm")}`,
									cache: "reload",
								}}
								// defaultSource={{
								// 	uri: petBucket.getPetPhoto().data,
								// }}
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
									{item.requester_data?.user_name}
								</Text>
							</View>
						</HStack>

						<HStack alignItems="center">
							<Spacer />

							<Text fontSize={10} color={colors.text} style={{ ...flex.myAuto }}>
								{DateTime.fromISO(item.created_at).toLocaleString(DateTime.DATE_MED)}
							</Text>
						</HStack>
					</Box>
				</Box>
			</Pressable>
		);
	};

	const renderHeader = () => (
		<View />
		// <Box
		// 	style={{
		// 		display: "flex",
		// 		flexDirection: "row",
		// 		columnGap: 5,
		// 		maxWidth: "100%",
		// 		// paddingHorizontal: 10,
		// 		marginTop: 5,
		// 	}}
		// >
		// 	<Button w="15%" height={46} onPress={() => startup(true)} style={{ marginTop: "auto" }} bgColor={colors.primary}>
		// 		<MaterialCommunityIcons name={"magnify"} size={24} color={"white"} />
		// 	</Button>
		// </Box>
	);

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
				{i18n.get("noNotifications")}
			</Text>
		</Box>
	);

	return (
		<>
			{success && <SuccessModal />}
			{accepting.requesterId !== -1 && (
				<QuestionModal
					title={i18n.get("acceptFollowRequest")}
					// inputMessage={i18n.get("pets.questions.medicineName")}
					customBody={<Text style={{ padding: 10 }}>{accepting.requesterName}</Text>}
					confirm={() => {
						followService
							.acceptFollowRequest(accepting.requesterId)
							.then(() => {
								startup(true).then(() => setRefreshing(false));
								setAccepting({ requesterId: -1, requesterName: "" });

								setSuccess(true);

								setTimeout(() => setSuccess(false), 3000);
							})
							.catch(() => {
								Alert.alert(i18n.get("alert"), i18n.get("errorAcceptingFollowRequest"));
							});
					}}
					cancel={() => setAccepting({ requesterId: -1, requesterName: "" })}
				/>
			)}

			{deleting.requesterId !== -1 && (
				<QuestionModal
					title={i18n.get("deleteFollowRequest")}
					// inputMessage={i18n.get("pets.questions.medicineName")}
					customBody={<Text style={{ padding: 10 }}>{deleting.requesterName}</Text>}
					confirm={() => {
						followService
							.deleteFollowRequest(deleting.requesterId)
							.then(() => {
								startup(true).then(() => setRefreshing(false));
								setDeleting({ requesterId: -1, requesterName: "" });

								setSuccess(true);

								setTimeout(() => setSuccess(false), 3000);
							})
							.catch(() => {
								Alert.alert(i18n.get("alert"), i18n.get("errorDeletingFollowRequest"));
							});
					}}
					cancel={() => setDeleting({ requesterId: -1, requesterName: "" })}
				/>
			)}

			<ThemedView isRoot fadeIn tabBarPadding>
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
					data={notifications}
					renderItem={renderItem}
					ListFooterComponent={
						notifications.length === 0 ? (
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
						getNextNotifications();
					}}
					// extraData={[sent]}
					// onEndReachedThreshold={0.25}
				/>
			</ThemedView>
		</>
	);
}

const styles = StyleSheet.create({});
