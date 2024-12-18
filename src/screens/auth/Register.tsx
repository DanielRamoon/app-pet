import GoogleLogo from "@assets/icons/google.png";
import PasswordToggle from "@components/PasswordToggle";
import LocaleToggler from "@components/Togglers/LocaleToggler";
import ButtonIcon from "@components/utils/ButtonIcon";
import LoadingIndicator from "@components/utils/LoadingIndicator";
import WhiteText from "@components/utils/Text/WhiteText";
import { Ionicons } from "@expo/vector-icons";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import { Input } from "@ui-kitten/components";
import i18n from "@utils/i18n";
import * as Linking from "expo-linking";
import { StatusBar } from "expo-status-bar";
import * as WebBrowser from "expo-web-browser";
import { Button } from "native-base";
import React, { useState } from "react";
import { Alert, KeyboardAvoidingView, Platform, ScrollView, StyleSheet, TouchableOpacity, View } from "react-native";

import { supabase } from "../../utils/supabase/client";

import SplashScreen from "@components/SplashScreen";
import useColors from "@hooks/useColors";
import { Image } from "expo-image";

export default function ({ navigation }: NativeStackScreenProps<any, "Register">) {
	const [email, setEmail] = useState<string>("");
	const [password, setPassword] = useState<string>("");
	const [passwordConfirm, setPasswordConfirm] = useState<string>("");
	const [loading, setLoading] = useState<boolean>(false);
	const [reloading, setReloading] = useState<boolean>(false);

	//control
	const [invalidEmail, setInvalidEmail] = useState<boolean>(false);
	const [invalidPassword, setInvalidPassword] = useState<boolean>(false);
	const [invalidPasswordConfirm, setInvalidPasswordConfirm] = useState<boolean>(false);
	const [showPassword, setShowPassword] = useState<boolean>(false);
	const [showPasswordConfirm, setShowPasswordConfirm] = useState<boolean>(false);

	const colors = useColors();

	async function register() {
		setInvalidEmail(false);
		setInvalidPassword(false);

		setLoading(true);
		const { data, error } = await supabase.auth.signUp({
			email: email,
			password: password,
		});

		if (!error && !data.user) {
			setLoading(false);
		}

		if (error) {
			if (error.message.includes("already")) Alert.alert(i18n.get("auth.emailAlreadyInUse"));
			else if (error.message.includes("should be"))
				Alert.alert(i18n.get("auth.atLeast").replace("{X}", (error.message.match(/\d+/) as any)[0]));
			else Alert.alert(i18n.get("auth.invalid"));

			setInvalidEmail(true);
			setInvalidPassword(true);

			setLoading(false);

			return;
		}

		setLoading(false);
		// Alert.alert(i18n.get("auth.success"), i18n.get("auth.confirmationEmailSent"));

		navigation.navigate("Login");

		return;
	}

	async function loginWithGoogle() {
		// setLoading(true);

		const { error, data } = await supabase.auth.signInWithOAuth({
			provider: "google",
			options: {
				redirectTo: Linking.createURL("/auth/callback"),
				skipBrowserRedirect: true,
			},
		});

		if (!data.url) {
			// setLoading(false);
			return;
		}

		await WebBrowser.openBrowserAsync(data.url);

		Linking.addEventListener("url", async (event) => {
			const params = event.url.split("#")[1].split("&");

			const access_token = params.find((param) => param.includes("access_token"))?.split("=")[1] || null;
			const refresh_token = params.find((param) => param.includes("refresh_token"))?.split("=")[1] || null;

			if (!access_token || !refresh_token) {
				setLoading(false);
				return;
			}

			await supabase.auth.setSession({
				access_token,
				refresh_token,
			});
		});

		if (!error) {
			setLoading(false);
		}

		if (error) {
			setLoading(false);
			Alert.alert(i18n.get("auth.invalid"));
		}
	}

	async function reload() {
		setReloading(true);

		setTimeout(() => {
			setReloading(false);
		}, 1000);
	}

	if (reloading) {
		return <SplashScreen loop />;
	} else {
		return (
			<View style={styles.container}>
				<StatusBar backgroundColor="transparent" style="light" />
				<View style={styles.overlay} />

				<KeyboardAvoidingView behavior={Platform.OS === "ios" ? "padding" : "height"} enabled style={{ flex: 1 }}>
					<ScrollView
						contentContainerStyle={{
							display: "flex",
							height: "100%",
							paddingLeft: 20,
							paddingRight: 20,
						}}
						keyboardShouldPersistTaps="always"
					>
						<View style={{ marginTop: "auto", marginBottom: "auto" }}>
							<WhiteText
								style={{
									alignSelf: "center",
									padding: 30,
									fontWeight: "bold",
									fontSize: 20,
								}}
							>
								{i18n.get("auth.register")}
							</WhiteText>
							<WhiteText style={{ marginBottom: 5 }}>Email</WhiteText>
							<Input
								placeholder={i18n.get("auth.emailInput")}
								value={email}
								autoCapitalize="none"
								autoCorrect={false}
								keyboardType="email-address"
								onChangeText={(text) => setEmail(text)}
								status={invalidEmail ? "danger" : "basic"}
								style={styles.inputStyle}
								textStyle={{ color: "black" }}
								selectionColor={colors.primary}
								cursorColor={colors.primary}
							/>

							<WhiteText style={{ marginTop: 15, marginBottom: 5 }}>{i18n.get("auth.password")}</WhiteText>
							<View
								style={{
									display: "flex",
									width: "100%",
									flexDirection: "column",
									justifyContent: "center",
									alignItems: "center",
									gap: 20,
								}}
							>
								<Input
									placeholder={i18n.get("auth.passwordInput")}
									value={password}
									autoCapitalize="none"
									autoCorrect={false}
									secureTextEntry={showPassword ? false : true}
									onChangeText={(text) => setPassword(text)}
									status={invalidPassword ? "danger" : "basic"}
									accessoryRight={<PasswordToggle show={showPassword} onPress={() => setShowPassword(!showPassword)} />}
									returnKeyType="send"
									onSubmitEditing={() => {
										register();
									}}
									style={styles.inputStyle}
									textStyle={{ color: "black" }}
									selectionColor={colors.primary}
									cursorColor={colors.primary}
								/>

								<Input
									placeholder={i18n.get("auth.passwordConfirm")}
									autoCapitalize="none"
									autoCorrect={false}
									secureTextEntry={showPasswordConfirm ? false : true}
									onChangeText={(text) => {
										setPasswordConfirm(text);
										if (text == password) {
											setInvalidPasswordConfirm(false);
										} else setInvalidPasswordConfirm(true);
									}}
									status={invalidPasswordConfirm ? "danger" : "basic"}
									accessoryRight={
										<PasswordToggle
											show={showPasswordConfirm}
											onPress={() => setShowPasswordConfirm(!showPasswordConfirm)}
										/>
									}
									returnKeyType="send"
									onSubmitEditing={() => {
										register();
									}}
									style={styles.inputStyle}
									textStyle={{ color: "black" }}
									selectionColor={colors.primary}
									cursorColor={colors.primary}
								/>
							</View>

							<Button
								onPress={() => {
									if (loading) return;
									if (invalidPasswordConfirm) {
										Alert.alert(i18n.get("auth.passwordsDontMatch"));
										return;
									}
									register();
								}}
								style={{
									marginTop: 30,
									maxHeight: 46,
									backgroundColor: colors.primary
								}}
								leftIcon={
									loading ? (
										(LoadingIndicator as any)
									) : (
										<ButtonIcon>
											<Ionicons name="log-in" size={20} color="white" />
										</ButtonIcon>
									)
								}
							>
								<WhiteText style={{ fontWeight: "bold", fontFamily: "Inter" }}>
									{loading ? i18n.get("loading") + "..." : i18n.get("continue")}
								</WhiteText>
							</Button>
							<Button
								leftIcon={
									// <Ionicons name="logo-google" size={18} color="white" style={flex.myAuto} />
									<Image source={GoogleLogo} style={{ width: 18, height: 18 }} />
								}
								onPressOut={() => loginWithGoogle()}
								style={{
									marginTop: 20,
									backgroundColor: "#fff",
									borderColor: "#fff",
									maxHeight: 46,
								}}
							>
								<View>
									<WhiteText style={{ color: "#7f7f7f", fontWeight: "bold", fontFamily: "Inter" }}>
										{loading ? i18n.get("loading") + "..." : i18n.get("auth.google")}
									</WhiteText>
								</View>
							</Button>

							<View
								style={{
									flexDirection: "row",
									alignItems: "center",
									marginTop: 35,
									justifyContent: "center",
								}}
							>
								<WhiteText>{i18n.get("auth.haveAccount")}</WhiteText>
								<TouchableOpacity
									onPress={() => {
										navigation.navigate("Login");
									}}
								>
									<WhiteText
										style={{
											marginLeft: 5,
											fontWeight: "bold",
										}}
									>
										{i18n.get("auth.loginHere")}
									</WhiteText>
								</TouchableOpacity>
							</View>
							<View
								style={{
									flexDirection: "row",
									alignItems: "center",
									marginTop: 10,
									justifyContent: "center",
								}}
							>
								<TouchableOpacity
									onPress={() => {
										navigation.navigate("ForgetPassword");
									}}
								>
									<WhiteText style={{ fontWeight: "bold" }}>{i18n.get("auth.forgotPassword")}</WhiteText>
								</TouchableOpacity>
							</View>
						</View>
					</ScrollView>
					<View style={styles.togglers}>
						{/* <ThemeToggle type="light" /> */}

						<LocaleToggler onPress={reload} />
					</View>
				</KeyboardAvoidingView>
			</View>
		);
	}
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
		justifyContent: "center",
		backgroundColor: "transparent",
	},
	overlay: {
		...StyleSheet.absoluteFillObject,
		backgroundColor: "rgba(0, 0, 0, 0.5)",
	},
	togglers: {
		position: "absolute",
		bottom: 0,
		width: "100%",
		flexDirection: "row",
		alignItems: "center",
		marginTop: "auto",
		justifyContent: "center",
		paddingBottom: 10,
		paddingLeft: 10,
		paddingRight: 15,
	},
	inputStyle: {
		backgroundColor: "white",
		borderColor: "white",
		color: "black",
	},
});
