import Loader from "@components/Loader";
import WalkInfoModal from "@components/Modals/Fullscreen/WalkInfoModal";
import QuestionModal from "@components/Modals/QuestionModal";
import ThemedView from "@components/utils/ThemedView";
import { FontAwesome5, Ionicons, MaterialIcons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import { FlashList } from "@shopify/flash-list";
import i18n from "@utils/i18n";
import petBucket from "@utils/supabase/buckets/pets";
import petsService, { IPet } from "@utils/supabase/services/pets/pets.service";
import userService, { IUser } from "@utils/supabase/services/user.service";
import walkService, { IPetWalk } from "@utils/supabase/services/walk/walk.service";
import { DateTime, Duration } from "luxon";
import { Avatar, Box, HStack, Pressable, Spacer, Text } from "native-base";
import React, { useCallback, useEffect, useState } from "react";
import ContentLoader, { Rect } from "react-content-loader/native";
import { Alert, DeviceEventEmitter, Dimensions, Image, StyleSheet, View } from "react-native";

interface IProps {
	pet: Partial<IPet>;
	userId: string;
	colors: ReturnType<typeof useColors>;

	openingModal?: () => void;
	closingModal?: () => void;
}

export default function Walks(props: IProps) {
	const [walks, setWalks] = useState<IPetWalk[]>([]);
	const [endReached, setEndReached] = useState(false);
	const [gettingMore, setGettingMore] = useState(false);
	const [currentPage, setCurrentPage] = useState(0);
	const [deleting, setDeleting] = useState(false);
	const [profile, setProfile] = useState<IUser>();

	const [toSeeWalk, setToSeeWalk] = useState<IPetWalk & { pet_name: string; pet_image: string }>();
	const [selectedWalks, setSelectedWalks] = useState<any[]>([]);

	const [userId] = useState<string>(props.userId);

	useEffect(() => {
		setWalks([]);
		setEndReached(false);
		setGettingMore(false);
		setCurrentPage(0);

		(async () => {
			const profileData: any = await userService.getLoggedUserProfile();
			setProfile(profileData.data);
		})();
	}, []);

	useEffect(() => {
		if (toSeeWalk) props.openingModal?.();
		else props.closingModal?.();
	}, [toSeeWalk]);

	useEffect(() => {
		if (props.pet?.id) {
			// Garantir a primeira busca
			getNextWalks([props.pet.id!], 0);
		}
	}, [props.pet]);

	const getNextWalks = useCallback(
		async (ids: string[], page?: number) => {
			if (!ids || ids.length === 0) return;

			if (page === 0) {
				setWalks([]);
				await new Promise((resolve) => setTimeout(resolve, 300));
			}

			try {
				if (endReached) return;

				setGettingMore(true);
				const _walks = await walkService.getWalks(ids, page ?? currentPage);
				setGettingMore(false);

				if (_walks.messages) {
					Alert.alert(i18n.get("alert"), i18n.get("profile.errorLoadingWalks"));
				}

				if (!_walks.data) {
					Alert.alert(i18n.get("alert"), i18n.get("profile.errorLoadingWalks"));
				}

				if (_walks?.data?.length === 0) return setEndReached(true);

				const _walksData = _walks.data ?? [];

				setWalks((walks: any[]) => [...walks, ..._walksData]);
				setCurrentPage((currentPage: number) => currentPage + 1);
			} catch (error) {
				console.log(error);
				Alert.alert(i18n.get("alert"), i18n.get("profile.errorLoadingWalks"));
			}
		},
		[currentPage, props, endReached]
	);

	const renderItem = ({ item, index }: { item: IPetWalk; index: number }) => (
		<Pressable
			style={{
				marginLeft: "auto",
				marginRight: "auto",
				marginTop: 15,
				width: "100%",
				marginBottom: index === (walks?.length || 1) - 1 ? 15 : 0,
				minHeight: 100,
			}}
			onPress={async () => {
				const pet = await petsService.getPet(item.pet_id);
				setToSeeWalk({
					...item,
					pet_name: pet.data?.name ?? "",
					pet_image: petBucket.getPetPhoto(item.pet_id, userId).data ?? "",
				});
			}}
		>
			{({ isPressed }: { isPressed: boolean }) => {
				return (
					<Box
						bg={
							selectedWalks.includes(item.id)
								? props.colors.cardColorSelected
								: isPressed
								? props.colors.cardColorPressed
								: props.colors.cardColor
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
									bg={props.colors.primary}
									source={{
										uri: `${petBucket.getPetPhoto(item.pet_id, userId).data}`,
										cache: "reload",
									}}
								>
									{/* <ActivityIndicator size="large" color={props.colors.text} /> */}
									<Image
										source={{ uri: petBucket.getPetPhoto().data }}
										style={{ width: "100%", height: "100%", borderRadius: 9999 }}
									/>
									{selectedWalks.includes(item.id) && (
										<Avatar.Badge
											bg="green.500"
											bgColor={props.colors.primary}
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
										color={props.colors.text}
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
										<FontAwesome5 name="walking" size={12} color={props.colors.text} />{" "}
										{(item.total_distance as any)?.humanDistance} |{" "}
										<MaterialIcons name="pets" size={12} color={props.colors.text} style={{ marginTop: 5 }} />{" "}
										{(item.total_distance as any)?.animalDistance as any}
									</Text>
								</View>

								<Spacer />
							</HStack>
						</Box>
					</Box>
				);
			}}
		</Pressable>
	);

	const deleteWalk = async (id?: string) => {
		if (!id) return;

		try {
			if (!id) return;

			const result = await walkService.deleteWalk(id as any);

			if (result.messages) {
				Alert.alert(i18n.get("alert"), i18n.get("profile.errorDeletingWalk"));
				return;
			}

			setToSeeWalk(undefined);

			setWalks((walks: any[]) => walks.filter((walk) => walk.id !== id));
		} catch (error) {
		} finally {
			setDeleting(false);

			DeviceEventEmitter.emit("showAppBar");
			DeviceEventEmitter.emit("showTabBar");
		}
	};

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
			{deleting && (
				<QuestionModal
					hideCancel
					title={i18n.get("deleteWalk")}
					cancel={() => setDeleting(false)}
					confirm={() => deleteWalk(toSeeWalk?.id)}
					customBody={(() => undefined) as any}
				/>
			)}

			<ThemedView isRoot>
				{!userId && (
					<View
						style={{
							width: "100%",
							height: 120,
							marginTop: 20,
							display: "flex",
							justifyContent: "center",
							alignItems: "center",
						}}
					>
						<ContentLoader
							viewBox={`0 0 ${Dimensions.get("window").width} 120`}
							backgroundColor={props.colors.loaderBackColor}
							foregroundColor={props.colors.loaderForeColor}
						>
							<Rect width={Dimensions.get("window").width} height={110} x={0} y={0} rx={8} ry={8} />
						</ContentLoader>
					</View>
				)}

				<FlashList
					showsVerticalScrollIndicator={false}
					contentContainerStyle={{ paddingTop: 10 }}
					alwaysBounceVertical={true}
					data={walks}
					renderItem={renderItem}
					ListFooterComponent={
						gettingMore ? (
							<View
								style={{
									width: "100%",
									height: 120,
									marginTop: 20,
									display: "flex",
									justifyContent: "center",
									alignItems: "center",
								}}
							>
								<ContentLoader
									viewBox={`0 0 ${Dimensions.get("window").width} 120`}
									backgroundColor={props.colors.loaderBackColor}
									foregroundColor={props.colors.loaderForeColor}
								>
									<Rect width={Dimensions.get("window").width} height={110} x={0} y={0} rx={8} ry={8} />
								</ContentLoader>
							</View>
						) : (
							<Box height={100} />
						)
					}
					estimatedItemSize={200}
					onEndReached={() => getNextWalks}
					onEndReachedThreshold={0.25}
					extraData={selectedWalks}
				/>
			</ThemedView>
		</>
	);
}
