import LocaleToggler from "@components/Togglers/LocaleToggler";
import ButtonIcon from "@components/utils/ButtonIcon";
import LoadingIndicator from "@components/utils/LoadingIndicator";
import WhiteText from "@components/utils/Text/WhiteText";
import { Ionicons } from "@expo/vector-icons";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import { Input } from "@ui-kitten/components";
import i18n from "@utils/i18n";
import { StatusBar } from "expo-status-bar";
import { Button } from "native-base";
import React, { useState } from "react";
import { Alert, KeyboardAvoidingView, Platform, ScrollView, StyleSheet, TouchableOpacity, View } from "react-native";
import { supabase } from "../../utils/supabase/client";

// import background from "@assets/images/auth/forgot.jpg";
import SplashScreen from "@components/SplashScreen";
import useColors from "@hooks/useColors";
import LoadingModal from "@components/Modals/LoadingModal";

export default function ({ navigation }: NativeStackScreenProps<any, "ForgetPassword">) {
	const [email, setEmail] = useState<string>("");
	const [loading, setLoading] = useState<boolean>(false);
	const [reloading, setReloading] = useState<boolean>(false);

	//control
	const [invalidEmail, setInvalidEmail] = useState<boolean>(false);

	const colors = useColors();

	async function reload() {
		setReloading(true);

		setTimeout(() => {
			setReloading(false);
		}, 1000);
	}

	async function forgotPassword() {
		if (!email || email.length === 0) {
			setInvalidEmail(true);
			Alert.alert(i18n.get("emailEmpty"));
			return;
		}

		setLoading(true);

		try {
			const { error } = await supabase.auth.resetPasswordForEmail(email, {
				redirectTo: `https://petvidade.lgtng.com/auth/reset-password`,
			});

			if (!error) {
				Alert.alert(i18n.get("auth.emailSent"));
			} else {
				Alert.alert(i18n.get("auth.error-title"), error.message);
			}
		} finally {
			setLoading(false);
		}
	}

	if (reloading) {
		return <SplashScreen loop />;
	} else {
		return (
			<View style={styles.container}>
				<StatusBar backgroundColor="transparent" style="light" />
				<View style={styles.overlay} />

				{loading && <LoadingModal />}

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
								{i18n.get("auth.forgotPassword")}
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
								selectionColor={colors.primary}
								cursorColor={colors.primary}
							/>

							<Button
								disabled={loading}
								onPress={() => {
									forgotPassword();
								}}
								style={{
									marginTop: 30,
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
									{loading ? i18n.get("loading") + "..." : i18n.get("auth.sendEmail")}
								</WhiteText>
							</Button>

							<View
								style={{
									flexDirection: "row",
									alignItems: "center",
									marginTop: 10,
									justifyContent: "center",
								}}
							>
								<TouchableOpacity
									style={{ display: "flex", flexDirection: "row", alignItems: "center" }}
									onPress={() => {
										navigation.navigate("Login");
									}}
								>
									<Ionicons name="arrow-back" size={20} color="white" />
									<WhiteText style={{ fontWeight: "bold" }}>{i18n.get("getBack")}</WhiteText>
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
