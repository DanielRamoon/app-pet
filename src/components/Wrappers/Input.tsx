import { Octicons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import {
	Input as NBInput,
	IInputProps,
	IFormControlLabelProps,
	FormControl,
	WarningOutlineIcon,
	Text,
} from "native-base";

type IProps = IInputProps & {
	label?: string;
	errorMessage?: string;
	clearable?: boolean;
	onClearText?: () => void;
	labelProps?: IFormControlLabelProps;
};

export default function Input(props: IProps) {
	const colors = useColors();

	return (
		<FormControl
			w={props.w ?? "100%"}
			isReadOnly={props.isReadOnly ?? false}
			isInvalid={props.isInvalid ?? false}
			isDisabled={props.isDisabled ?? false}
		>
			{props.label && (
				<FormControl.Label
					_text={{ fontFamily: "Inter", fontWeight: 800, fontSize: 14, color: props.labelProps?.color ?? colors.text }}
					{...props.labelProps}
				>
					{props.label}

					{props.isRequired && (
						<Text color={colors.danger} fontSize={14} fontFamily="Inter" fontWeight={800} ml={2}>
							*
						</Text>
					)}
				</FormControl.Label>
			)}
			<NBInput
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
				autoCapitalize="none"
				{...{ ...props, w: "100%" }}
			/>
			{props.isInvalid && (
				<FormControl.ErrorMessage leftIcon={<WarningOutlineIcon size="xs" />}>
					{props.errorMessage}
				</FormControl.ErrorMessage>
			)}

			{props.clearable && props.onClearText && (
				<Octicons
					name="x"
					size={20}
					color={colors.text}
					onPress={() => props.onClearText && props.onClearText()}
					style={{ position: "absolute", right: 5, bottom: 2, display: props.value ? "flex" : "none", padding: 10 }}
				/>
			)}
		</FormControl>
	);
}

export function WrappedInput(props: IProps) {
	return Input(props);
}
