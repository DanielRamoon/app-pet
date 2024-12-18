import UserAddress from "@components/FirstAccess/Forms/UserAddress";
import UserInfo from "@components/FirstAccess/Forms/UserInfo";
import SuccessModal from "@components/Modals/SuccessModal";
import ProfileAvatarUpload from "@components/ProfileAvatarUpload";
import SplashScreen from "@components/SplashScreen";
import LogoutButton from "@components/utils/LogoutButton";
import ThemedView from "@components/utils/ThemedView";
import { Ionicons } from "@expo/vector-icons";
import useAppTheme from "@hooks/useAppTheme";
import useColors from "@hooks/useColors";
import { PostgrestError } from "@supabase/supabase-js";
import i18n from "@utils/i18n";
import { goBack, navigate } from "@utils/navigator";
import { logOut } from "@utils/supabase/client";
import userService from "@utils/supabase/services/user.service";
import { StatusBar } from "expo-status-bar";
import { DateTime } from "luxon";
import { Button, Text } from "native-base";
import React, { useEffect, useState } from "react";
import { ActivityIndicator, Alert, DeviceEventEmitter, ScrollView, StyleSheet, View } from "react-native";
import { useDispatch } from "react-redux";
import { IUserInfo } from "src/@types/User";
import { toogleBar } from "src/store/features/walkSlice";

interface IProps {
	checkFirstAccess?: boolean;
	initialValues?: Partial<IFormValues>;
}

interface IFormValues {
	personalData: Partial<IUserInfo>;
	address: Record<string, any>;
	avatarUrl?: string;
}

export default function (props: IProps) {
	const [checked, setChecked] = useState(false);
	const [appTheme, , setAppTheme] = useAppTheme();
	const colors = useColors();

	const [saving, setSaving] = useState(false);
	const [success, setSuccess] = useState(false);

	const [isFirstAccess, setIsFirstAccess] = useState(false);

	const dispatch = useDispatch();

	const checkIfFirstAccess = async () => {
		const isFirstAccess = await userService.isUserFirstAccess();

		if (!isFirstAccess.data) {
			dispatch(toogleBar({ value: false }));
			return navigate("Home", { screen: "Home" });
		} else {
			DeviceEventEmitter.emit("hideAppBar");
			setIsFirstAccess(true);
		}

		setChecked(true);
	};

	useEffect(() => {
		DeviceEventEmitter.emit("hideTabBar");
		const closeScreenListener = DeviceEventEmitter.addListener("closeScreen", () => {
			DeviceEventEmitter.emit("showTabBar");
		});
		if (props.checkFirstAccess) checkIfFirstAccess();
		else setChecked(true);
		return () => {
			closeScreenListener.remove();
			DeviceEventEmitter.emit("showTabBar");
		};
	}, []);

	const [userInfo, setUserInfo] = useState<IFormValues>(
		props.initialValues ? { ...(props.initialValues as any) } : { personalData: {}, address: {} }
	);

	const [userTempAvatar, setuserTempAvatar] = useState(props.initialValues?.avatarUrl ?? "");

	const salvarDados = async () => {
		if (!userInfo.personalData.name) return Alert.alert(i18n.get("alert"), i18n.get("firstAccess.userInfo.fillName"));
		if (!userInfo.personalData.username)
			return Alert.alert(i18n.get("alert"), i18n.get("firstAccess.userInfo.fillUsername"));
		if (!userInfo.personalData.birthDate)
			return Alert.alert(i18n.get("alert"), i18n.get("firstAccess.userInfo.fillBithdate"));
		if (!userInfo.personalData.gender)
			return Alert.alert(i18n.get("alert"), i18n.get("firstAccess.userInfo.fillGender"));

		// if (!userInfo.address.country) return Alert.alert(i18n.get("alert"), i18n.get("firstAccess.userInfo.fillCountry"));
		// if (!userInfo.address.state) return Alert.alert(i18n.get("alert"), i18n.get("firstAccess.userInfo.fillState"));
		// if (!userInfo.address.city) return Alert.alert(i18n.get("alert"), i18n.get("firstAccess.userInfo.fillCity"));

		const birthdate = DateTime.fromISO(userInfo.personalData.birthDate);
		if (!birthdate.isValid) return Alert.alert(i18n.get("alert"), i18n.get("firstAccess.userInfo.invalidBirthdate"));

		setSaving(true);

		const saved = await userService.updateUserProfile({
			avatar_url: userTempAvatar,
			birth_date: userInfo.personalData.birthDate,
			full_name: userInfo.personalData.name + " " + userInfo.personalData.surname,
			user_name: userInfo.personalData.username,
			gender: userInfo.personalData.gender,
			address: userInfo.address,
			completed: true,
		} as any);

		if (saved.trace) return Alert.alert(i18n.get("error"), (saved.trace as PostgrestError).message);
		else {
			setSaving(false);
			setSuccess(true);

			dispatch(toogleBar({ value: true }));

			setTimeout(() => {
				if (props.checkFirstAccess) navigate("Home", { screen: "Home" });
				else navigate("ProfileIndex", { reload: Math.random(), firstL: false });
			}, 2000);
		}
	};

	if (!checked && !props.initialValues)
		return (
			<>
				{/* <StatusBar backgroundColor="transparent" /> */}
				{/* StatusBar PRINCIPAL */}
				<StatusBar backgroundColor={"transparent"} style={appTheme === "light" ? "dark" : "inverted"} />
				<SplashScreen loop />
			</>
		);

	return (
		<ThemedView>
			{isFirstAccess && (
				<Button
					onPress={() => logOut()}
					style={{
						position: "absolute",
						top: 0,
						right: 0,
						zIndex: 9999,

						marginLeft: "auto",
						marginRight: 10,
						marginBottom: 10,
						marginTop: 30,
						backgroundColor: colors.danger,
						width: 150,
					}}
					leftIcon={<Ionicons name="log-out" size={24} color={colors.white} />}
				>
					<Text color="white">{i18n.get("logout")}</Text>
				</Button>
			)}

			<ScrollView
				style={{ flex: 1 }}
				contentContainerStyle={{ paddingTop: 50, paddingBottom: 80, backgroundColor: colors.background }}
				keyboardShouldPersistTaps="always"
			>
				{props.checkFirstAccess && (
					<LogoutButton
						style={{
							position: "absolute",
							top: 50,
							right: 10,
							zIndex: 999,
						}}
					/>
				)}

				<ProfileAvatarUpload
					style={{ marginTop: props.checkFirstAccess ? 50 : 10 }}
					onImageChange={(avatar) => {
						setuserTempAvatar(avatar);
					}}
					initialImage={userTempAvatar}
				/>

				<View style={[styles.container, { backgroundColor: colors.background }]}>
					<View style={{ marginVertical: 15 }} />

					<UserInfo
						onChange={(info) => setUserInfo({ ...userInfo, personalData: info })}
						initialValues={userInfo.personalData}
					/>
				</View>

				{/* <View style={{ backgroundColor: colors.background }}>
					<View style={{ marginVertical: 15 }} />

					<UserAddress
						isFirstAccess={isFirstAccess}
						onChange={(address) => setUserInfo((prevUserInfo) => ({ ...prevUserInfo, address }))}
						initialValues={userInfo.address}
					/>
				</View> */}

				<View style={{ backgroundColor: colors.background }}>
					<View style={{ marginVertical: 15 }} />

					<Button
						style={{ marginHorizontal: 15 }}
						onPress={salvarDados}
						leftIcon={saving ? <ActivityIndicator color="white" size={20} /> : undefined}
					>
						{!saving ? i18n.get("save") : i18n.get("saving")}
					</Button>

					<View style={{ marginVertical: 100 }} />
				</View>

				{success && <SuccessModal />}
			</ScrollView>
		</ThemedView>
	);
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
		marginTop: 15,
		borderTopLeftRadius: 15,
		borderTopRightRadius: 15,
	},
});
