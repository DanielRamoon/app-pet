import LottieView from "lottie-react-native";
import React, { useEffect, useRef } from "react";
import { StyleProp, ViewStyle } from "react-native";

interface IProps {
	key: string;
	title: string;
	text: string;
	lottie: typeof require;
	lottieConfig: {
		speed: number;
		duration: number;
		loop: boolean;
	};
	background: string;
	style?: StyleProp<ViewStyle>;
}

export default function PlatformLottie(props: IProps) {
	const animationRef = useRef<LottieView | null>();

	useEffect(() => {
		animationRef.current?.play();
	}, []);

	return (
		<LottieView
			ref={(animation) => {
				animationRef.current = animation;
			}}
			onLayout={() => {
				animationRef.current?.play();
			}}
			autoPlay
			style={
				props.style ?? {
					width: 256,
					height: 256,
					transform: [{ scale: 1 }],
					marginBottom: "auto",
					marginTop: 35,
				}
			}
			// source={require("@assets/lottie/dog.json")}
			source={props.lottie as any}
			// source={require("@assets/lottie/127575-happy-dog.json")}
			// source={require("@assets/lottie/65014-dog-walking.json")}
			// source={require("@assets/lottie/dog-walking.json")}
			{...props.lottieConfig}
		/>
	);
}
