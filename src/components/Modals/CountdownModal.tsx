import LottieView from "lottie-react-native";
import { Modal } from "native-base";
import { useEffect, useRef, useState } from "react";
import { StyleSheet, Vibration } from "react-native";

export default function CountdownModal({ onAnimationFinish }: { onAnimationFinish: () => void }) {
	const [showModal, setShowModal] = useState(true);
	const [layouted, setLayouted] = useState(false);

	const animationRef = useRef<LottieView | null>();

	useEffect(() => {
		animationRef.current?.play();
	}, []);

	const onAnimationFinishEvent = () => {
		if (showModal) {
			setTimeout(() => {
				setShowModal(false);
			}, 250);
			onAnimationFinish();
			Vibration.vibrate(550);
		}
	};

	return (
		<Modal isOpen={showModal} onClose={() => setShowModal(false)} closeOnOverlayClick={false}>
			<Modal.Content width="5/6">
				<Modal.Body style={{ display: "flex", justifyContent: "center", alignItems: "center", height: "100%" }}>
					<LottieView
						ref={(animation) => {
							animationRef.current = animation;
						}}
						onLayout={() => {
							if (layouted) return;
							else setLayouted(true);

							animationRef.current?.play();
						}}
						style={{
							width: 200,
							height: 200,
						}}
						// source={require("@assets/lottie/dog.json")}
						source={require("@assets/lottie/134509-purple-countdown.json")}
						// source={require("@assets/lottie/127575-happy-dog.json")}
						// source={require("@assets/lottie/65014-dog-walking.json")}
						// source={require("@assets/lottie/dog-walking.json")}
						speed={1}
						onAnimationFinish={onAnimationFinishEvent}
						loop={false}
					/>
				</Modal.Body>
			</Modal.Content>
		</Modal>
	);
}

const styles = StyleSheet.create({});
