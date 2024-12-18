import useColors from "@hooks/useColors";
import theme from "@utils/theme";
import React from "react";
import { ActivityIndicator, View } from "react-native";

export default function () {
	const colors = useColors();

	return (
		<View
			style={{
				flex: 1,
				alignItems: "center",
				justifyContent: "center",
				backgroundColor: colors.background,
			}}
		>
			<ActivityIndicator size="large" color={theme.primary} />
		</View>
	);
}
