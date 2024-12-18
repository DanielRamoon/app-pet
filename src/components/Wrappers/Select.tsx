import { Ionicons } from "@expo/vector-icons";
import useAppTheme from "@hooks/useAppTheme";
import useColors from "@hooks/useColors";
import { ISelectProps, Select, Text, View } from "native-base";
import React from "react";

interface IProps extends ISelectProps {
	style?: Record<string, any>;
	isRequired?: boolean;
}

export default (props: IProps) => {
	const [theme] = useAppTheme();
	const colors = useColors();

	return (
		<View style={[{ flex: 1 }, props.w ? { width: props.w as any } : {}]}>
			<Text style={{ fontFamily: "Inter", fontSize: 14, color: colors.text }} my={"4px"} fontWeight={800}>
				{props.accessibilityLabel} {props.isRequired ? <Text style={{ color: colors.danger }}>*</Text> : ""}
			</Text>
			<Select
				fontFamily="Inter"
				fontSize={15}
				dropdownIcon={
					<View
						style={{
							height: 40,
							display: "flex",
							justifyContent: "center",
							alignItems: "center",
						}}
					>
						<Ionicons name="chevron-down" size={24} color={colors.primary} style={{ marginRight: 7.5 }} />
					</View>
				}
				{...props}
			>
				{props.children}
			</Select>
		</View>
	);
};
