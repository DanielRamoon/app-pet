import LottieView from "lottie-react-native";
import React, { useEffect, useRef } from "react";
import { StyleSheet, View } from "react-native";

export default function SplashScreen(props: {
	onAnimationFinish?: () => void;
	bgColor?: string;
	absolute?: boolean;
	onlyDog?: boolean;
	customStyle?: any;
}) {
	const animationRef = useRef<LottieView | null>();

	useEffect(() => {
		animationRef.current?.play();
	}, []);

	useEffect(() => {
		if (props.onAnimationFinish) setTimeout(props.onAnimationFinish, 1500);
	}, []);

	return (
		<View
			style={[
				styles.animationContainer,
				props.bgColor ? { backgroundColor: props.bgColor } : {},
				props.absolute ? { ...StyleSheet.absoluteFillObject, zIndex: 9999 } : {},
				props.onlyDog ? { height: 140, width: "100%", marginBottom: 25 } : {},
				props.customStyle ? props.customStyle : {},
			]}
		>
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
				source={require("@assets/lottie/33645-happy-dog.json")}
				// source={require("@assets/lottie/127575-happy-dog.json")}
				// source={require("@assets/lottie/65014-dog-walking.json")}
				// source={require("@assets/lottie/dog-walking.json")}
				duration={5000}
				speed={0.2}
				loop
			/>
		</View>
	);
}

const styles = StyleSheet.create({
	animationContainer: {
		flex: 1,
		alignItems: "center",
		justifyContent: "center",
	},
	buttonContainer: {
		paddingTop: 20,
	},
});
