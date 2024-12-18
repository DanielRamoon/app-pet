import Loader from "@components/Loader";
import ThemedView from "@components/utils/ThemedView";
import useColors from "@hooks/useColors";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import ProfileEdit from "@screens/shared/ProfileEdit";
import i18n from "@utils/i18n";
import userService, { IUser } from "@utils/supabase/services/user.service";
import { DateTime } from "luxon";
import React, { useEffect, useState } from "react";
import ContentLoader, { Circle, Rect } from "react-content-loader/native";
import { Alert, Dimensions, View } from "react-native";

export default function ({ navigation }: NativeStackScreenProps<any, "MainTabs">) {
	const colors = useColors();

	const [loading, setLoading] = useState(true);
	const [profile, setProfile] = useState<Partial<IUser>>();

	async function startup() {
		const profileData = await userService.getLoggedUserProfile();

		if (profileData.messages) {
			Alert.alert(i18n.get("alert"), i18n.get("profile.errorLoadingProfile"));
			return navigation.navigate("Home");
		}

		setProfile(profileData.data as any);
	}

	useEffect(() => {
		startup().finally(() => setTimeout(() => setLoading(false), 1000));
	}, []);

	if (loading) {
		return (
			<ThemedView>
				<View
					style={{
						width: Dimensions.get("window").width,
						height: Dimensions.get("window").height,
						display: "flex",
						justifyContent: "center",
						backgroundColor: colors.background,
						alignItems: "center",
						padding: 20,
					}}
				>
					<ContentLoader
						viewBox={`0 0 ${Dimensions.get("window").width} ${Dimensions.get("window").height}`}
						backgroundColor={colors.loaderBackColor}
						foregroundColor={colors.loaderForeColor}
					>
						<Circle x={210} y={140} cx={7} cy={7} r={78} />
						<Rect width={Dimensions.get("window").width} height={45} x={0} y={290} rx={10} ry={10} />
						<Rect width={Dimensions.get("window").width} height={45} x={0} y={380} rx={10} ry={10} />
						<Rect width={Dimensions.get("window").width} height={45} x={0} y={480} rx={10} ry={10} />
					</ContentLoader>
				</View>
			</ThemedView>
		);
	}

	return (
		<ProfileEdit
			checkFirstAccess={false}
			initialValues={{
				personalData: {
					birthDate: DateTime.fromISO(profile?.birth_date ?? "").toFormat("dd/MM/yyyy") ?? "",
					gender: (profile?.gender as any) ?? 0,
					username: profile?.user_name ?? "",
					name: (profile?.full_name ?? "").split(" ")[0] ?? "",
					surname: (profile?.full_name ?? "").split(" ")[1] ?? "",
				},
				address: profile?.address as Record<string, any>,
				avatarUrl: (profile?.avatar_url ?? "") + "?t=" + new Date().getTime(),
			}}
		/>
	);
}
