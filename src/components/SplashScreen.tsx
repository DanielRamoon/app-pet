import React, { useRef, useEffect } from "react";
import { Button, StyleSheet, View, Alert } from "react-native";
import LottieView from "lottie-react-native";
import useColors from "@hooks/useColors";

export default function SplashScreen(props: { onAnimationFinish?: () => void; loop?: boolean }) {
	const colors = useColors();

	const animationRef = useRef<LottieView | null>();

	useEffect(() => {
		animationRef.current?.play();
	}, []);

	useEffect(() => {
		if (props.onAnimationFinish) setTimeout(props.onAnimationFinish, 1500);
	}, []);

	return (
		<View style={[styles.animationContainer, { backgroundColor: colors.primary }]}>
			<LottieView
				ref={(animation) => {
					animationRef.current = animation;
				}}
				onLayout={() => {
					animationRef.current?.play();
				}}
				autoPlay
				style={{
					width: 400,
					height: 400,
				}}
				// source={require("@assets/lottie/dog.json")}
				source={require("@assets/lottie/127157-moody-dog.json")}
				// source={require("@assets/lottie/127575-happy-dog.json")}
				// source={require("@assets/lottie/65014-dog-walking.json")}
				// source={require("@assets/lottie/dog-walking.json")}
				duration={5000}
				speed={0.2}
				loop={props.loop ?? false}
			/>
		</View>
	);
}

const styles = StyleSheet.create({
	animationContainer: {
		position: "absolute",
		alignItems: "center",
		justifyContent: "center",
		flex: 1,
		height: "100%",
		width: "100%",
	},
	buttonContainer: {
		paddingTop: 20,
	},
});
