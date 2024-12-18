import { View } from "native-base";
import React, { useEffect, useState } from "react";
import Input from "./Input";

interface IProps {
	label: string;
	style?: Record<string, any>;
	value: string;
	onChangeText: (value: string) => void;
	mask: "date";
	w?: string | number;
	mb?: string | number;
	isRequired?: boolean;
}

function maskDate(text: string) {
	if (text.length < 8) return text;

	// Prevents the user from entering more than 8 characters
	if (text.length > 8) return text.substring(0, 10);

	const pattern = /\d{2}(\d{2})?(\d{4})/g;
	const matches = text.match(pattern);
	if (matches) {
		for (const match of matches) {
			let day, month, year;
			if (match.length === 8) {
				day = match.substring(0, 2);
				month = match.substring(2, 4);
				year = match.substring(4);
			} else {
				day = match.substring(0, 1);
				month = match.substring(1, 3);
				year = match.substring(3);
			}
			const formattedDate = `${day.padStart(2, "0")}/${month.padStart(2, "0")}/${year}`;
			text = text.replace(match, formattedDate);
		}
	}
	return text;
}

export default (props: IProps) => {
	function mask(value: string) {
		if (props.mask === "date") {
			value = maskDate(value);
		}

		return props.onChangeText(value);
	}

	useEffect(() => {
		mask(props.value);
	}, []);

	return (
		<View style={[{ width: props.w ?? "100%" }, { marginBottom: props.mb ?? 0 }]}>
			<Input
				label={props.label}
				onChangeText={(_) => mask(_)}
				value={props.value}
				keyboardType="numeric"
				isRequired={props.isRequired ?? false}
			/>
		</View>
	);
};
