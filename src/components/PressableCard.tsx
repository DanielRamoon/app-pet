import useColors from "@hooks/useColors";
import { Box, HStack, Pressable, Text } from "native-base";
import {
	IPressableProps,
	InterfacePressableProps,
} from "native-base/lib/typescript/components/primitives/Pressable/types";
import React from "react";
import { Dimensions, StyleProp, View, ViewStyle } from "react-native";

interface ICustomProps {
	title: string;
	leftIcon?: React.ReactNode;
	rightIcon?: React.ReactNode;
	style?: StyleProp<ViewStyle>;
}

type IProps = ICustomProps & InterfacePressableProps<IPressableProps>;

export default (props: IProps) => {
	const colors = useColors();

	return (
		<Pressable
			{...props}
			style={[
				{
					marginLeft: "auto",
					marginRight: "auto",
					marginTop: 15,
					width: "100%",
					minHeight: 75,
				},
				props.style,
			]}
			delayLongPress={200}
		>
			{({ isPressed }) => {
				return (
					<Box
						bg={isPressed ? colors.cardColorPressed : colors.cardColor}
						style={{
							width: "100%",
							transform: [
								{
									scale: isPressed ? 0.96 : 1,
								},
							],
							flex: 1,
							flexDirection: "row",
						}}
						rounded="5"
					>
						<Box
							style={{
								flex: 1,
								flexDirection: "column",
								justifyContent: "space-between",
							}}
							paddingLeft={2}
							paddingRight={2}
							paddingTop={2}
							paddingBottom={2}
						>
							<HStack
								style={{ display: "flex", flexDirection: "row", alignItems: "center", height: "100%" }}
								alignItems="center"
							>
								<View
									style={{
										display: "flex",
										flexDirection: "row",
										alignItems: "center",
										gap: 15,
										paddingLeft: 15,
									}}
								>
									{props.leftIcon}
									<Text
										color={colors.text}
										fontWeight="medium"
										fontSize="xl"
										numberOfLines={1}
										ellipsizeMode="tail"
										maxWidth={Dimensions.get("window").width - 150}
									>
										{props.title}
									</Text>
								</View>

								<View style={{ marginLeft: "auto" }}>{props.rightIcon}</View>
							</HStack>

							{/* <HStack alignItems="center">
						<Spacer />

						<Text fontSize={10} color={colors.text} style={{ ...flex.myAuto }}>
							{getPetDuration(item.birth_date)}
						</Text>
					</HStack> */}
						</Box>
					</Box>
				);
			}}
		</Pressable>
	);
};
