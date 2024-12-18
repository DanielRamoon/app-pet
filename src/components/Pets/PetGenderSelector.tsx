import useColors from "@hooks/useColors";
import { FormControl, IFormControlProps } from "native-base";
import React from "react";
import { StyleSheet, View } from "react-native";

type IProps = IFormControlProps & {
	label: string;
	errorMessage?: string;
};

export default function PetGenderSelector(props: IProps) {
	const colors = useColors();

	return (
		<FormControl w={props.w ?? "100%"} {...props}>
			<FormControl.Label _text={{ fontFamily: "Inter", fontWeight: 800, fontSize: 14, color: colors.text }}>
				{props.label}
			</FormControl.Label>
		</FormControl>
	);
}

const styles = StyleSheet.create({});
