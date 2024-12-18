import LottieView from "lottie-react-native";
import { Modal } from "native-base";
import { useEffect, useRef, useState } from "react";
import { StyleSheet } from "react-native";

export default function SuccessModal() {
	const [showModal, setShowModal] = useState(true);
	const [layouted, setLayouted] = useState(false);

	const animationRef = useRef<LottieView | null>();

	const onAnimationFinish = () => {
		if (showModal) {
			setTimeout(() => setShowModal(false), 250);
		}
	};

	return (
		<Modal isOpen={showModal} onClose={() => setShowModal(false)} closeOnOverlayClick={false}>
			<Modal.Content width="5/6">
				{/* <Modal.CloseButton /> */}
				{/* <Modal.Header>{i18n.get("success")}!</Modal.Header> */}
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
						source={require("@assets/lottie/1127-success.json")}
						// source={require("@assets/lottie/127575-happy-dog.json")}
						// source={require("@assets/lottie/65014-dog-walking.json")}
						// source={require("@assets/lottie/dog-walking.json")}
						speed={1}
						onAnimationFinish={onAnimationFinish}
						loop={false}
					/>
				</Modal.Body>
			</Modal.Content>
		</Modal>
	);
}

const styles = StyleSheet.create({});
