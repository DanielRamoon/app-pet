import i18n from "@utils/i18n";
import { HStack, Switch, Text } from "native-base";
import { TouchableOpacity } from "react-native";

export default function ({
	privateProfile,
	toggle,
	style,
}: {
	privateProfile: boolean;
	toggle: () => void;
	style?: any;
}) {
	return (
		<TouchableOpacity onPress={toggle} style={{ ...style }}>
			<HStack alignItems="center" justifyContent="space-between">
				<Text>{i18n.get("profile.privateProfile")}</Text>
				<Switch size="md" onToggle={toggle} isChecked={privateProfile} />
			</HStack>
		</TouchableOpacity>
	);
}
