import React, { useEffect, useRef, useState } from "react";
import { View, Image } from "react-native";
import AppIntroSlider from "react-native-app-intro-slider";
import { StyleSheet } from "react-native";
import { Text, Heading, Button } from "native-base";
import PlatformButton from "@components/Wrappers/PlatformButton";
import useColors from "@hooks/useColors";
import i18n from "@utils/i18n";
import LottieView from "lottie-react-native";
import * as Animatable from "react-native-animatable";
import PlatformLottie from "@components/Wrappers/PlatformLottie";

interface IProps {
	onFinish: () => void;
}

export default function HomeAppIntro(props: IProps) {
	const colors = useColors();

	const [ref, setRef] = useState<AppIntroSlider>();
	const [currentSlide, setCurrentSlide] = useState(0);

	const [slides, setSlides] = useState<any>([]);

	useEffect(() => {
		const slides = [
			{
				key: "one",
				title: i18n.get("appIntro[0].title"),
				text: i18n.get("appIntro[0].description"),
				lottie: require("@assets/lottie/24278-pet-lovers.json"),
				lottieConfig: {
					speed: 0.1,
					duration: 1400,
					loop: true,
				},
				background: colors.secondary,
			},
			{
				key: "two",
				title: i18n.get("appIntro[1].title"),
				text: i18n.get("appIntro[1].description"),
				lottie: require("@assets/lottie/43901-cute-dog.json"),
				lottieConfig: {
					speed: 0.2,
					duration: 8500,
				},
				background: colors.primary,
			},
			{
				key: "three",
				title: i18n.get("appIntro[2].title"),
				text: i18n.get("appIntro[2].description"),
				lottie: require("@assets/lottie/47956-area-map.json"),
				lottieConfig: {
					speed: 0.5,
					duration: 5000,
				},
				background: colors.secondary,
			},
			{
				key: "four",
				title: i18n.get("appIntro[3].title"),
				text: i18n.get("appIntro[3].description"),
				lottie: require("@assets/lottie/18199-location-pin-on-a-map.json"),
				lottieConfig: {
					speed: 0.2,
					duration: 4000,
				},
				background: colors.primary,
			},
		];

		setSlides(slides);
	}, []);

	const renderItem = ({ item }: { item: any }) => {
		return (
			<View style={[styles.slide, { backgroundColor: item.background ?? colors.primary }]}>
				<View style={styles.texts}>
					<Heading style={styles.title} size="2xl">
						{item.title}
					</Heading>
					<Text style={styles.text}>{item.text}</Text>
				</View>
				{item.lottie && <PlatformLottie lottie={item.lottie} {...item.lottieConfig} />}
				<Image source={item.image} style={styles.image} resizeMethod="resize" resizeMode="contain" />
				<View style={{ height: 150 }} />
			</View>
		);
	};

	const renderPagination = () => {
		return (
			<View style={styles.paginationContainer}>
				<Button
					onPress={() => {
						if (slides.length - 1 === currentSlide) return props.onFinish();

						(ref as any).goToSlide(currentSlide + 1);
						setCurrentSlide(currentSlide + 1);
					}}
					style={{ ...styles.paginationButton, backgroundColor: colors.white }}
				>
					<Text style={{ color: colors.black }}>
						{currentSlide >= slides.length - 1 ? i18n.get("finish") : i18n.get("next")}
					</Text>
				</Button>
				<PlatformButton
					onPress={props.onFinish}
					style={{ ...styles.paginationButton, marginTop: 8 }}
					useDefaultStyle={true}
				>
					<Text style={{ color: colors.white }}>{i18n.get("skip")}</Text>
				</PlatformButton>
			</View>
		);
	};

	return (
		<Animatable.View animation="fadeIn" style={{ flex: 1 }}>
			<AppIntroSlider
				ref={(ref) => setRef(ref as any)}
				data={slides}
				onDone={props.onFinish}
				renderItem={renderItem}
				renderPagination={renderPagination}
				renderPrevButton={() => null}
				renderNextButton={() => null}
				renderDoneButton={() => null}
				onSlideChange={(index) => setCurrentSlide(index)}
			/>
		</Animatable.View>
	);
}

const styles = StyleSheet.create({
	slide: {
		flex: 1,
		alignItems: "center",
	},
	texts: {
		marginTop: 128,
	},
	title: {
		color: "white",
		textAlign: "center",
		fontFamily: "Inter",
	},
	text: {
		color: "white",
		textAlign: "center",
		fontFamily: "Inter",
		marginTop: 16,
		paddingHorizontal: 30,
	},
	image: {
		width: 256,
		height: 256,
		transform: [{ scale: 1 }],
		marginTop: "auto",
		marginBottom: "auto",
	},

	paginationContainer: {
		position: "absolute",
		display: "flex",
		flexDirection: "column",
		justifyContent: "space-between",
		alignItems: "center",
		bottom: 25,
		width: "100%",
		paddingHorizontal: 20,
		gap: 10,
	},
	paginationButton: {
		width: "80%",
	},
});
