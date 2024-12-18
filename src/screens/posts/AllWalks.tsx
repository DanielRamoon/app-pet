import ThemedView from "@components/utils/ThemedView";
import { View, Text, Image, Dimensions, DeviceEventEmitter, Alert, RefreshControl, FlatList } from "react-native";
import walkService, { IPetWalk } from "@utils/supabase/services/walk/walk.service";
import i18n from "@utils/i18n";
import { useCallback, useEffect, useState } from "react";
import Post from "@components/FriendPost";
import { FlashList } from "@shopify/flash-list";
import useColors from "@hooks/useColors";
import { Box } from "native-base";
import ContentLoader, { Rect, Circle } from "react-content-loader/native";
import Loader from "@components/Loader";

export default function AllFriendWalks() {
	// Walks
	const [refreshing, setRefreshing] = useState(false);
	const [loading, setLoading] = useState(true);
	const [walks, setWalks] = useState<IPetWalk[]>([]);
	const [currentPage, setCurrentPage] = useState<number>(0);
	const [endReached, setEndReached] = useState(false);
	const colors = useColors();

	useEffect(() => {
		getNextFriendsWalks();
	}, []);

	const getNextFriendsWalks = useCallback(
		// async (page?: number) => {
		// 	if (endReached) return;
		// 	if (page === 0) {
		// 		setCurrentPage(0);
		// 		setWalks([]);
		// 	}
		// 	setGettingMore(true);
		// 	const _walks = await walkService.getFriendsWalks(page || 0);
		// 	setGettingMore(false);

		// 	if (_walks.messages) {
		// 		Alert.alert(i18n.get("alert"), i18n.get("profile.errorLoadingWalks"));
		// 	}

		// 	if (!_walks.data) {
		// 		Alert.alert(i18n.get("alert"), i18n.get("profile.errorLoadingWalks"));
		// 	}

		// 	const newArray = [...walks, ...(_walks.data ?? [])];

		// 	// Remove os itens duplicados pelo .id
		// 	const filtered = Array.from(new Set(newArray.map((objeto) => objeto.id))).map((id) => {
		// 		return newArray.find((objeto) => objeto.id === id);
		// 	});

		// 	setWalks(filtered as IPetWalk[]);
		// 	setCurrentPage(currentPage + 1);
		// },
		// [walks]

		async () => {
			const _walks = await walkService.getFriendsWalks();

			if (_walks.messages) {
				Alert.alert(i18n.get("alert"), i18n.get("profile.errorLoadingWalks"));
			}

			if (!_walks.data) {
				Alert.alert(i18n.get("alert"), i18n.get("profile.errorLoadingWalks"));
			}

			const newArray = [...walks, ...(_walks.data ?? [])];

			// Remove os itens duplicados pelo .id
			const filtered = Array.from(new Set(newArray.map((objeto) => objeto.id))).map((id) => {
				return newArray.find((objeto) => objeto.id === id);
			});

			setWalks(filtered as IPetWalk[]);
			
			setLoading(false);
		},
		[walks]
	);
	const renderItem = ({ item, index }: { item: IPetWalk; index: number }) => (
		<Post petWalk={item} isLast={index === walks.length - 1} isMy={false} />
	);

	if (loading) {
		return (
			<ThemedView>
				<View
					style={{
						width: Dimensions.get("window").width,
						height: 400,
						display: "flex",
						justifyContent: "center",
						backgroundColor: colors.background,
						alignItems: "center",
					}}
				>
					<ContentLoader
						viewBox={`0 0 ${Dimensions.get("window").width} 400`}
						backgroundColor={colors.loaderBackColor}
						foregroundColor={colors.loaderForeColor}
					>
						<Circle x={20} cx={45} cy={45} r={40} />
						<Rect width={100} height={15} x={120} y={20} rx={5} ry={5} />
						<Rect width={100} height={15} x={120} y={50} rx={5} ry={5} />
						<Rect width={Dimensions.get("window").width * 0.9} height={200} x={20} y={130} rx={20} ry={20} />
					</ContentLoader>
				</View>
			</ThemedView>
		);
	}

	return (
		<ThemedView>
			<View
				style={{
					flex: 1,
					justifyContent: "center",
					alignItems: "center",
				}}
			>
				<FlatList
					showsVerticalScrollIndicator={false}
					// estimatedItemSize={10}
					refreshControl={
						<RefreshControl
							refreshing={refreshing}
							onRefresh={() => getNextFriendsWalks()}
							tintColor={colors.primary}
							colors={[colors.white]}
							progressBackgroundColor={colors.secondary}
						/>
					}
					contentContainerStyle={{
						paddingTop: walks.length === 0 ? 0 : 40,
					}}
					alwaysBounceVertical={true}
					data={walks}
					renderItem={renderItem}
					ListFooterComponent={
						walks.length === 0 ? (
							<View
								style={{
									width: Dimensions.get("screen").width,
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
					// onEndReached={() => getNextFriendsWalks(currentPage)}
					// onEndReachedThreshold={0.25}
				/>
			</View>
		</ThemedView>
	);
}
