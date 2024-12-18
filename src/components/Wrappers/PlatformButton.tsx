import { Button, Text } from "native-base";
import React from "react";
import { StyleSheet, TouchableOpacityProps } from "react-native";

interface IProps {
	children: React.ReactNode | string;
	onPress: () => void;
	style?: TouchableOpacityProps["style"];
	rippleColor?: string;
	useDefaultStyle?: boolean;
	radius?: number;
}

/**
 * @deprecated Função só existe para compatibilidade com o código antigo.
 */
export default function PlatformButton(props: IProps) {
	const isText = typeof props.children === "string";

	return (
		<Button
			style={[{ ...(props.style as any) }, props.useDefaultStyle ? { ...styles.baseButtonStyle, borderRadius: 5 } : {}]}
			onPress={props.onPress}
		>
			{isText ? <Text style={{ color: "white" }}>{String(props.children)}</Text> : props.children}
		</Button>
	);
}

const styles = StyleSheet.create({
	baseViewStyle: {
		alignSelf: "stretch",
		justifyContent: "center",
		borderRadius: 5,
	},
	baseButtonStyle: {
		flexDirection: "row",
		alignItems: "center",
		justifyContent: "center",
		paddingRight: 12,
		paddingLeft: 12,
		paddingTop: 10,
		paddingBottom: 10,
	},
});
