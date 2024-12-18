import { Octicons } from "@expo/vector-icons";
import useAppTheme from "@hooks/useAppTheme";
import useColors from "@hooks/useColors";
import { Toggle } from "@ui-kitten/components";
import i18n from "@utils/i18n";
import { HStack, Switch, Text } from "native-base";
import { useEffect, useState } from "react";
import { TouchableOpacity } from "react-native";

export default function ({ type, style }: { type: "light" | "dark" | "system"; style?: any }) {
	const [, toggleTheme] = useAppTheme();
	const colors = useColors();

	const [isDarkMode, setIsDarkMode] = useState(false);

	useEffect(() => {
		setIsDarkMode(type === "dark");
	}, [type]);

	return (
		<TouchableOpacity onPress={toggleTheme} style={{ ...style }}>
			<HStack alignItems="center" justifyContent="space-between">
				<Text>{i18n.get("darkMode")}</Text>
				<Switch size="md" onToggle={toggleTheme} isChecked={isDarkMode} />
			</HStack>

			{/* <Octicons name={type === "dark" ? "sun" : "moon"} color={colors.text} size={32} /> */}

			{/* {type === "dark" && (
				<WhiteText style={textStyle}>{appTheme === "dark" ? `☀️ ${i18n.get("lightTheme")}` : `🌑 ${i18n.get("darkTheme")}`}</WhiteText>
			)}

			{type === "light" && (
				<BlackText style={textStyle}>{appTheme === "dark" ? `☀️ ${i18n.get("lightTheme")}` : `🌑 ${i18n.get("darkTheme")}`}</BlackText>
			)}

			{type === "system" && (
				<Text style={{ ...(textStyle as any) }}>
					{appTheme === "dark" ? `☀️ ${i18n.get("lightTheme")}` : `🌑 ${i18n.get("darkTheme")}`}
				</Text>
			)} */}
		</TouchableOpacity>
	);
}
