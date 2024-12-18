import ThemedView from "@components/utils/ThemedView";
import { MaterialCommunityIcons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import { useRoute } from "@react-navigation/native";
import { FlashList } from "@shopify/flash-list";
import i18n from "@utils/i18n";
import avatars from "@utils/supabase/buckets/avatars";
import userService from "@utils/supabase/services/user.service";
import walkService from "@utils/supabase/services/walk/walk.service";
import { getRandomHexColor } from "@utils/utilities";
import environment from "environment";
import { Box } from "native-base";
import { useEffect, useState } from "react";
import ContentLoader, { Rect } from "react-content-loader/native";
import { View, Text, Image, StyleSheet, Dimensions } from "react-native";

interface UserData {
	name: string;
	fullName: string;
	userAvatar: string | undefined;
}

interface LikeData {
	created_at: Date;
	user_id: string;
	walk_id: string;
	id: string;
}

interface Props {
	petWalkId: string;
}

export default function SeeUserLikes() {
	const route = useRoute();
	const colors = useColors();
	const params = route.params as Props;

	const [userData, setUserData] = useState<UserData[]>([]);
	const [loading, setLoading] = useState<boolean>(true);

	useEffect(() => {
		(async () => {
			const likesQ: any = await walkService.getMyWalksLikes(params.petWalkId);

			if (likesQ.data.length > 0) {
				await likesQ.data.map(async (res: LikeData) => {
					const userResponse: any = await userService.getUserName(res.user_id);
					if (userResponse.data) {
						const { userName, fullName } = userResponse.data;
						const newUser: UserData = {
							name: userName ?? "",
							fullName: fullName ?? "",
							userAvatar: avatars.getUserAvatarById(params.petWalkId).data,
						};
						setUserData((prevUserData) => [...prevUserData, newUser]);
					}
				});
			}
			setLoading(false);
		})();
	}, []);

	const generateAvatar = (initials: string) => {
		return `${
			environment.UIAVATARS_URL ?? "https://ui-avatars.com/api/"
		}?name=${initials}&size=256&rounded=true&background=${getRandomHexColor({
			removeHash: true,
		})}&color=ffffff&format=png`;
	};

	const renderItem = ({ item, index }: { item: UserData; index: number }) => (
		<View
			style={{
				marginTop: 30,
				width: "100%",
				display: "flex",
				alignItems: "center",
				justifyContent: "center",
			}}
		>
			<View
				style={{
					width: "95%",
					display: "flex",
					justifyContent: "space-between",
					alignItems: "center",
					height: 100,
					flexDirection: "row",
					backgroundColor: colors.cardColorPressed,
					borderRadius: 12,
				}}
			>
				<View
					style={{
						display: "flex",
						flexDirection: "row",
						justifyContent: "flex-start",
						alignItems: "center",
						marginLeft: 5,
					}}
				>
					<View style={{ ...styles.icon, backgroundColor: "transparent" }}>
						{/* {item.userAvatar ? (
						<Image source={{ uri: item.userAvatar, cache: "only-if-cached" }} style={styles.image} />
					) : ( */}
						<Image source={{ uri: generateAvatar(item.fullName!?.slice(0, 2)) }} style={styles.image} />
						{/* )} */}
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
							@{item.name}
						</Text>
						<Text numberOfLines={1} style={{ color: colors.secondaryText, fontSize: 16 }}>
							{item.fullName}
						</Text>
					</View>
				</View>
				<View style={{ width: 40, marginRight: 5 }}>
					<MaterialCommunityIcons name="paw" color={colors.likeButton} size={30} />
				</View>
			</View>
		</View>
	);

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
						<Rect width={Dimensions.get("window").width} height={120} x={0} y={50} rx={12} ry={12} />
					</ContentLoader>
				</View>
			</ThemedView>
		);
	}

	return (
		<ThemedView>
			<FlashList
				showsVerticalScrollIndicator={false}
				estimatedItemSize={10}
				contentContainerStyle={{
					paddingTop: userData.length === 0 ? 0 : 20,
				}}
				alwaysBounceVertical={true}
				data={userData}
				renderItem={renderItem}
			/>
		</ThemedView>
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
