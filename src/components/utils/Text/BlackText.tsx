import { Text } from "@ui-kitten/components";

export default function ({ style, children }: { style?: Record<string, any>; children: React.ReactElement | string }) {
	return <Text style={{ color: "black", ...style }}>{children}</Text>;
}
