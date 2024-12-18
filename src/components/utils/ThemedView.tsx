import useColors from "@hooks/useColors";
import { View, StyleSheet } from "react-native";
import * as Animatable from "react-native-animatable";

interface IProps {
	style?: Record<string, any>;
	children?: React.ReactNode;
	isRoot?: boolean;
	fadeIn?: boolean;
	bgColor?: string;
	transparent?: boolean;
	absolute?: boolean;
	tabBarPadding?: boolean;
}

export default (props: IProps) => {
	const colors = useColors();

	const customStyle = props.absolute ? { ...StyleSheet.absoluteFillObject, zIndex: 9999 } : {};

	return (
		<View
			style={{
				flex: 1,
				backgroundColor: props.bgColor ? props.bgColor : props.transparent ? "transparent" : colors.background,
				paddingBottom: props.tabBarPadding ? 80 : 0,
				...customStyle,
			}}
		>
			<Animatable.View
				animation={props.fadeIn ? "fadeIn" : undefined}
				style={{
					flex: 1,
					paddingLeft: props.isRoot ? 15 : 0,
					paddingRight: props.isRoot ? 15 : 0,
					backgroundColor: props.bgColor ? props.bgColor : props.transparent ? "transparent" : colors.background,
					...props.style,
				}}
			>
				{props.children}
			</Animatable.View>
		</View>
	);
};
