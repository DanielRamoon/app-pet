import ErrorModal from "@components/Modals/ErrorModal";
import LoadingModal from "@components/Modals/LoadingModal";
import QuestionModal from "@components/Modals/QuestionModal";
import { logOut } from "@utils/supabase/client";
import SuccessModal from "@components/Modals/SuccessModal";
import LocaleToggler from "@components/Togglers/LocaleToggler";
import PrivateAccountToggler from "@components/Togglers/PrivateAccountToggler";
import RememberToWalk from "@components/Togglers/RememberToWalk";
import ThemeToggler from "@components/Togglers/ThemeToggler";
import ThemedView from "@components/utils/ThemedView";
import useAppTheme from "@hooks/useAppTheme";
import useColors from "@hooks/useColors";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import i18n from "@utils/i18n";
import userService, { IUser } from "@utils/supabase/services/user.service";
import { Divider, SectionList, Text } from "native-base";
import React, { useEffect, useState } from "react";
import * as WebBrowser from "expo-web-browser";
import { Alert, View, TouchableOpacity, DeviceEventEmitter, Dimensions } from "react-native";
import ContentLoader, { Rect } from "react-content-loader/native";

export default function ({ navigation }: NativeStackScreenProps<any, "MainTabs">) {
	const colors = useColors();
	const [theme] = useAppTheme();

	const [profile, setProfile] = useState<Pick<IUser, "private">>({ private: false });
	const [rememberWhen, setRememberWhen] = useState<number>(0);
	const [expoTokenBackup, setExpoTokenBackup] = useState<string | null>(null);
	const [language, setLanguage] = useState<string | null>(null);
	const [skeletonLoading, setSkeletonLoading] = useState<boolean>(true);
	const [reloading, setReloading] = useState<boolean>(false);
	const [changingProfileVisibility, setChangingProfileVisibility] = useState<boolean>(false);
	const [loading, setLoading] = useState<boolean>(false);
	const [success, setSuccess] = useState<boolean>(false);
	const [error, setError] = useState<boolean>(false);

	function deleteAccount() {
		Alert.alert(i18n.get("deleteAccount"), i18n.get("deleteAccountMessage"), [
			{
				text: i18n.get("cancel"),
				onPress: () => {},
				style: "cancel",
			},
			{
				text: i18n.get("delete"),
				onPress: async () => {
					await logOut();

					// Open "https://petvidade.lgtng.com" on a browser

					await WebBrowser.openBrowserAsync("https://petvidade.lgtng.com");
				},
			},
		]);
	}

	useEffect(() => {
		const eventLogout = DeviceEventEmitter.addListener("logoutAccount", () => {
			logOut();
		});
		return () => {
			eventLogout.remove();
		};
	}, []);

	async function startup() {
		const { data }: any = await userService.getLoggedUserProfile("private,settings");

		setProfile({ private: data?.private ?? false });

		if (data?.settings) {
			if (data?.settings?.remember_walk) setRememberWhen(data?.settings?.remember_walk);
			if (data?.settings?.exponent_push_token) setExpoTokenBackup(data?.settings?.exponent_push_token);
			if (data?.settings?.language) setLanguage(data?.settings?.language);

			if (data?.settings?.language !== i18n.locale || !data?.settings?.language) {
				await userService.updateUserProfile({ settings: { ...data?.settings, language: i18n.locale } });
			}
		}

		setSkeletonLoading(false);
	}

	useEffect(() => {
		startup();
	}, []);

	async function reload() {
		setReloading(true);

		setTimeout(() => {
			setReloading(false);
		}, 1000);

		await startup();
	}

	async function changeProfileVisibility() {
		setChangingProfileVisibility(false);
		setLoading(true);

		try {
			await userService.updateUserProfile({ private: !profile.private });
			setSuccess(true);
		} catch (error) {
			setError(true);
		} finally {
			setLoading(false);
		}

		setTimeout(() => {
			setSuccess(false);
			setError(false);
		}, 1250);

		setProfile({ private: !profile.private });
	}

	async function toggleWalkReminder(n?: number) {
		if (Number(n) < 0) return Alert.alert(i18n.get("error"), i18n.get("invalidRemember"));

		setLoading(true);
		const json = {
			remember_walk: Number(!Number.isNaN(n) ? n : rememberWhen === 0 ? 1 : 0),
			exponent_push_token: expoTokenBackup,
		};

		try {
			await userService.updateUserProfile({ settings: json });
			setSuccess(true);
		} catch (error) {
			console.log(error);
			setError(true);
		} finally {
			setLoading(false);
		}

		setTimeout(() => {
			setSuccess(false);
			setError(false);
		}, 1250);

		setRememberWhen(json.remember_walk);
	}

	const data = [
		{
			title: i18n.get("profile.config.general"),
			data: [
				<LocaleToggler list onPress={reload} style={{ marginBottom: 20 }} />,
				<ThemeToggler type={theme as any} />,
			],
		},
		{
			title: i18n.get("profile.config.account"),
			data: [
				<PrivateAccountToggler privateProfile={profile.private} toggle={() => setChangingProfileVisibility(true)} />,
				<RememberToWalk rememberWhen={rememberWhen} toggle={(n) => toggleWalkReminder(n)} />,
				<View style={{ height: 100 }} />,
			],
		},
	];

	return (
		<>
			{loading && <LoadingModal />}
			{success && <SuccessModal />}
			{error && <ErrorModal errorMessage={i18n.get("profile.togglePrivateProfileError")} />}

			{changingProfileVisibility && (
				<QuestionModal
					title={i18n.get("profile.togglePrivateProfile")}
					confirm={changeProfileVisibility}
					cancel={() => setChangingProfileVisibility(false)}
					customBody={
						<Text color={colors.text} fontSize="md" textAlign="left" m="5" mr="1">
							{i18n.get("profile.togglePrivateProfileDescription")}
						</Text>
					}
				/>
			)}
			{reloading || skeletonLoading ? (
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
							<Rect width={180} height={50} x={20} y={10} rx={5} ry={5} />
							<Rect width={Dimensions.get("window").width * 0.9} height={30} x={20} y={80} rx={3} ry={3} />
							<Rect width={Dimensions.get("window").width * 0.9} height={30} x={20} y={130} rx={3} ry={3} />

							<Rect width={180} height={50} x={20} y={230} rx={5} ry={5} />
							<Rect width={Dimensions.get("window").width * 0.9} height={30} x={20} y={300} rx={3} ry={3} />
							<Rect width={Dimensions.get("window").width * 0.9} height={30} x={20} y={350} rx={3} ry={3} />
							<Rect width={Dimensions.get("window").width * 0.9} height={50} x={20} y={400} rx={3} ry={3} />

							
							<Rect width={140} height={50} x={20} y={550} rx={5} ry={5} />
						</ContentLoader>
					</View>
				</ThemedView>
			) : (
				<ThemedView isRoot fadeIn>
					<SectionList
						style={{ flex: 1, backgroundColor: colors.background, paddingLeft: 15, paddingRight: 15 }}
						sections={data}
						keyExtractor={(_, index) => String(index)}
						renderItem={({ item }) => item}
						renderSectionHeader={({ section: { title } }) => (
							<View>
								{title !== data[0].title && <Divider mt="4" mb="2" />}
								<Text
									style={{ marginTop: 15, marginBottom: 10 }}
									color={colors.text}
									fontWeight="medium"
									fontSize="xl"
									numberOfLines={1}
									lineHeight={27}
									ellipsizeMode="tail"
								>
									{title}
								</Text>
							</View>
						)}
					/>
					<View
						style={{
							display: "flex",
							height: "42%",
							alignItems: "flex-start",
							justifyContent: "flex-start",
						}}
					>
						<Divider mt="4" mb="2" />
						<TouchableOpacity
							style={{
								width: "auto",
								height: "auto",
								display: "flex",
								flexDirection: "row",
								justifyContent: "center",
								alignItems: "center",
								backgroundColor: colors.danger,
								marginTop: 30,
								padding: 10,
								paddingHorizontal: 8,
								borderRadius: 10,
								right: 0,
							}}
							onPress={deleteAccount}
						>
							<Text style={{ color: colors.white, fontSize: 16 }}>{i18n.get("deleteAccount")}</Text>
						</TouchableOpacity>
					</View>
				</ThemedView>
			)}
		</>
	);
}
