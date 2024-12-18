import { createNativeStackNavigator } from "@react-navigation/native-stack";
import React from "react";

import ForgetPassword from "@screens/auth/ForgetPassword";
import Login from "@screens/auth/Login";
import Register from "@screens/auth/Register";

import { ImageBackground, StyleSheet } from "react-native";

const AuthStack = createNativeStackNavigator();

const Auth = () => {
	return (
		<AuthStack.Navigator
			screenOptions={{
				headerShown: false,
			}}
		>
			<AuthStack.Screen name="Login">
				{(props: any) => (
					<ImageBackground style={styles.container} source={require("@assets/images/unsplash/auth/login.jpg")}>
						<Login {...props} />
					</ImageBackground>
				)}
			</AuthStack.Screen>
			<AuthStack.Screen name="Register">
				{(props: any) => (
					<ImageBackground style={styles.container} source={require("@assets/images/unsplash/auth/register.jpg")}>
						<Register {...props} />
					</ImageBackground>
				)}
			</AuthStack.Screen>
			<AuthStack.Screen name="ForgetPassword">
				{(props: any) => (
					<ImageBackground style={styles.container} source={require("@assets/images/unsplash/auth/forgot.jpg")}>
						<ForgetPassword {...props} />
					</ImageBackground>
				)}
			</AuthStack.Screen>
		</AuthStack.Navigator>
	);
};

const styles = StyleSheet.create({
	container: {
		flex: 1,
		justifyContent: "center",
		backgroundColor: "transparent",
	},
});

export default Auth;
