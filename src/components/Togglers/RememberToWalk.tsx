import { WrappedInput } from "@components/Wrappers/Input";
import useAppTheme from "@hooks/useAppTheme";
import useColors from "@hooks/useColors";
import i18n from "@utils/i18n";
import { Button, HStack, Switch, Text } from "native-base";
import { useEffect, useState } from "react";
import { TouchableOpacity, View } from "react-native";

export default function ({
	rememberWhen,
	toggle,
}: {
	rememberWhen: number;
	toggle: (number?: number) => void;
	style?: any;
}) {
	const [currentToggle, setCurrentToggle] = useState(rememberWhen);
	const [unsaved, setUnsaved] = useState(false);
	const [loaded, setLoaded] = useState(-1);

	const colors = useColors();

	useEffect(() => {
		setCurrentToggle(rememberWhen);
	}, [rememberWhen]);

	useEffect(() => {
		if (loaded > 0) {
			if (currentToggle != rememberWhen) setUnsaved(true);
			else setUnsaved(false);
		} else {
			setLoaded((l) => l + 1);
		}

		if (isNaN(currentToggle)) setCurrentToggle(0);
	}, [currentToggle]);

	return (
		<View>
			<TouchableOpacity onPress={() => toggle()}>
				<HStack alignItems="center" justifyContent="space-between">
					<View style={{ display: "flex", flexDirection: "row", flexWrap: "wrap", gap: 5 }}>
						<Text>{i18n.get("profile.rememberToWalk")}</Text>
						<Text>{i18n.get("inDays")}</Text>
					</View>
					<Switch size="md" onToggle={toggle} isChecked={rememberWhen != 0} />
				</HStack>
			</TouchableOpacity>

			{rememberWhen != 0 && (
				<View>
					<WrappedInput
						label={""}
						w="100%"
						mb={30}
						value={currentToggle.toString()}
						onChangeText={(text) => setCurrentToggle(parseInt(text))}
						isRequired
					/>

					{unsaved && (
						<Button
							backgroundColor={colors.primary}
							// isDisabled={loading || loadingGeocode}
							onPress={() => {
								setUnsaved(false);
								toggle(Number(currentToggle));
							}}
							width={"100%"}
							ml="auto"
						>
							<View
								style={{
									display: "flex",
									flexDirection: "row",
									alignItems: "center",
									gap: 10,
									width: "100%",
								}}
							>
								<Text color="white">{i18n.get("saveReminderDays")}</Text>
							</View>
						</Button>
					)}
				</View>
			)}
		</View>
	);
}
