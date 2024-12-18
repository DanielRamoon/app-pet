import useColors from "@hooks/useColors";
import { IInputProps, FormControl, WarningOutlineIcon, Text, TextArea as NBTextArea } from "native-base";

type IProps = IInputProps & {
	label?: string;
	errorMessage?: string;
};

export default function TextArea(props: IProps) {
	const colors = useColors();

	return (
		<FormControl
			w={props.w ?? "100%"}
			isReadOnly={props.isReadOnly ?? false}
			isInvalid={props.isInvalid ?? false}
			isDisabled={props.isDisabled ?? false}
		>
			{props.label && (
				<FormControl.Label _text={{ fontFamily: "Inter", fontWeight: 800, fontSize: 14, color: colors.text }}>
					{props.label}

					{props.isRequired && (
						<Text color={colors.danger} fontSize={14} fontFamily="Inter" fontWeight={800} ml={2}>
							*
						</Text>
					)}
				</FormControl.Label>
			)}
			<NBTextArea
				fontSize={15}
				fontFamily="Inter"
				borderRadius={4}
				borderWidth={1}
				paddingY={7}
				paddingX={8}
				_focus={{
					borderColor: colors.primary,
					backgroundColor: colors.primary + "10",
				}}
				selectionColor={colors.primary}
				cursorColor={colors.text}
				placeholderTextColor={colors.text}
				autoCompleteType="off"
				{...{ ...props, w: "100%" }}
			/>
			{props.isInvalid && (
				<FormControl.ErrorMessage leftIcon={<WarningOutlineIcon size="xs" />}>{props.errorMessage}</FormControl.ErrorMessage>
			)}
		</FormControl>
	);
}

export function WrappedTextArea(props: IProps) {
	return TextArea(props);
}
