import { RouteProp } from "@react-navigation/native";
import { StackNavigationProp } from "@react-navigation/stack";
import { Animated, StyleProp, ViewStyle } from "react-native";

export type RootStackParamList = {
	Home: { foo: string };
	Details: { id: number };
};

export type HomeScreenNavigationProp = StackNavigationProp<RootStackParamList, "Home">;
export type DetailsScreenRouteProp = RouteProp<RootStackParamList, "Details">;

export type Props = {
	navigation: HomeScreenNavigationProp;
	route: DetailsScreenRouteProp;
};

export type AnimatedValue = Animated.AnimatedValue;
export type AnimatedValueXY = Animated.AnimatedValueXY;

export type Route = {
	key: string;
	params?: object;
};

export type Scene<T extends Route> = {
	route: T;
	progress: AnimatedValue;
};

export type SceneInterpolatorProps<T extends Route> = {
	current: Scene<T>;
	previous?: Scene<T>;
	next?: Scene<T>;
	layouts: {
		screen: {
			width: number;
			height: number;
		};
	};
};

export type CardStyleInterpolator<T extends Route> = (props: SceneInterpolatorProps<T>) => {
	cardStyle: Animated.WithAnimatedValue<StyleProp<ViewStyle>>;
	overlayStyle?: Animated.WithAnimatedValue<StyleProp<ViewStyle>>;
};
