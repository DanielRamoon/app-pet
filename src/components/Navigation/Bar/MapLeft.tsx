import { navigate } from "@utils/navigator";
import { View } from "react-native";
import { useSelector } from "react-redux";
import { RootState } from "src/store/store";

export default function MapLeft(props: {
	backButton: (props: { customOnPress?: () => void } | any) => React.JSX.Element;
}) {
	const currentWalk = useSelector((state: RootState) => state.currentWalk);

	const status = ["idle", "finished"];
	return (
		<View style={{ display: status.includes(currentWalk.status) ? "flex" : "none" }}>
			{props.backButton({
				customOnPress: () => {
					navigate("Home");
				},
			})}
		</View>
	);
}
