import PressableCard from "@components/PressableCard";
import ThemedView from "@components/utils/ThemedView";
import { Feather, Ionicons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import i18n from "@utils/i18n";
import { navigate } from "@utils/navigator";
import { ScrollView } from "native-base";

const icons = [
	(color: string) => <Feather name="shopping-bag" size={24} color={color} />,
	(color: string) => <Feather name="activity" size={24} color={color} />,
	(color: string) => <Feather name="check-circle" size={24} color={color} />,
	(color: string) => <Feather name="circle" size={24} color={color} />,
];

export default function ({ navigation }: NativeStackScreenProps<any, "MainTabs">) {
	const colors = useColors();

	return (
		<ThemedView isRoot fadeIn>
			<ScrollView showsVerticalScrollIndicator={false}>
				{Array.from({ length: 4 }).map((_, i) => (
					<PressableCard
						title={i18n.get(`places.options[${i}]`)}
						key={i}
						onPress={() => navigate("Search", { queryType: i })}
						leftIcon={icons[i](colors.text)}
						rightIcon={<Ionicons name="chevron-forward" size={24} color={colors.text} />}
					/>
				))}
			</ScrollView>
		</ThemedView>
	);
}
