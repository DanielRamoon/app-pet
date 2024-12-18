import Loader from "@components/Loader";
import Input from "@components/Wrappers/Input";
import ThemedView from "@components/utils/ThemedView";
import { Ionicons, MaterialCommunityIcons, Octicons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import { NativeStackScreenProps } from "@react-navigation/native-stack";
import { FlashList } from "@shopify/flash-list";
import i18n from "@utils/i18n";
import { navigate } from "@utils/navigator";
import petTypes from "@utils/petTypes";
import petBucket from "@utils/supabase/buckets/pets";
import petsService, { IPet } from "@utils/supabase/services/pets/pets.service";
import { getPetDuration } from "@utils/utilities";
import { DateTime } from "luxon";
import { Avatar, Badge, Box, Button, Fab, HStack, Pressable, Spacer, Text } from "native-base";
import React, { useEffect, useRef, useState } from "react";
import ContentLoader, { Rect } from "react-content-loader/native";
import { DeviceEventEmitter, Dimensions, RefreshControl, View, Image, BackHandler, ToastAndroid } from "react-native";

export default function ({ navigation }: NativeStackScreenProps<any, "MainTabs">) {
	const colors = useColors();

	const [loading, setLoading] = useState(true);
	const [refreshing, setRefreshing] = useState(false);
	const [pets, setPets] = useState<IPet[]>();
	const [sorting, setSorting] = useState<"asc" | "desc">("asc");
	const [search, setSearch] = useState("");

	const [selectedPets, setSelectedPets] = useState<string[]>([]);

	const clicks = useRef(0);
	const isFocused = useRef(false);

	async function startup(refresh = false, noSearch = false) {
		setSelectedPets([]);

		if (!refresh) setLoading(true);
		else setRefreshing(true);

		// setSorting(sorting === "asc" ? "desc" : "asc");

		const result = await petsService.getPets(sorting, search === "" || noSearch ? undefined : search);

		setPets(result.data);

		if (!refresh) setLoading(false);
		else setRefreshing(false);
	}

	useEffect(() => {
		// check for navigation focus and run startup
		const unsubscribe = navigation.addListener("focus", () => {
			setLoading(true);

			startup().finally(() => setTimeout(() => setLoading(false), 1000));
		});

		const refreshPets = DeviceEventEmitter.addListener("refreshPets", () =>
			startup().finally(() => setTimeout(() => setLoading(false), 1000))
		);

		const cancelPets = DeviceEventEmitter.addListener("cancelPets", () => setSelectedPets([]));

		return () => {
			unsubscribe();
			refreshPets.remove();
			cancelPets.remove();
		};
	}, []);

	useEffect(() => {
		startup();

		const unsubscribeBlur = navigation.addListener("blur", () => {
			isFocused.current = false;
		});

		const unsubscribeFocus = navigation.addListener("focus", () => {
			isFocused.current = true;
		});

		const backHandler = BackHandler.addEventListener("hardwareBackPress", () => {
			if (!isFocused.current) return false;

			if (clicks.current === 1) {
				BackHandler.exitApp();
				return true;
			}

			ToastAndroid.show(i18n.get("pressQuit"), ToastAndroid.SHORT);

			clicks.current += 1;

			setTimeout(() => {
				clicks.current = 0;
			}, 2000);

			return true;
		});

		return () => {
			backHandler.remove(), unsubscribeBlur(), unsubscribeFocus();
		};
	}, []);

	useEffect(() => {
		if (!loading) startup(true);
	}, [sorting]);

	useEffect(() => {
		DeviceEventEmitter.emit("selectedPetsUpdate", [...selectedPets]);
	}, [selectedPets]);

	const renderHeader = () => (
		<Box
			style={{
				display: "flex",
				flexDirection: "row",
				columnGap: 5,
				maxWidth: "100%",
				// paddingHorizontal: 10,
				marginTop: 5,
			}}
		>
			<Input
				value={search}
				label={i18n.get("search")}
				w="68%"
				onChangeText={(text) => setSearch(text)}
				clearable
				onClearText={() => {
					setSearch("");

					startup(true, true);
				}}
			/>

			<Button w="15%" height={46} onPress={() => startup(true)} style={{ marginTop: "auto" }} bgColor={colors.primary}>
				<MaterialCommunityIcons name={"magnify"} size={24} color={"white"} />
			</Button>

			<Button
				w="14%"
				height={46}
				onPress={() => {
					setSorting(sorting === "asc" ? "desc" : "asc");
					// startup(true);
				}}
				style={{ marginTop: "auto" }}
				bgColor={colors.primary}
			>
				<MaterialCommunityIcons
					name={sorting === "asc" ? "sort-alphabetical-ascending" : "sort-alphabetical-descending"}
					size={24}
					color={"white"}
				/>
			</Button>
		</Box>
	);

	const renderItem = ({ item, index }: { item: IPet; index: number }) => (
		<Pressable
			style={{
				marginLeft: "auto",
				marginRight: "auto",
				marginTop: 15,
				width: "100%",
				marginBottom: index === (pets?.length || 1) - 1 ? 15 : 0,
				minHeight: 100,
			}}
			onPress={() => {
				if (selectedPets.length > 0) {
					if (selectedPets.includes(item.id)) {
						setSelectedPets((selectedPets: string[]) => [...selectedPets].filter((x) => x !== item.id));
					} else {
						setSelectedPets((selectedPets: string[]) => [...selectedPets, item.id]);
					}
				} else {
					navigate("Profile", { id: item.id });
				}
			}}
			onLongPress={() => {
				if (selectedPets.includes(item.id)) {
					setSelectedPets((selectedPets: string[]) => [...selectedPets].filter((x) => x !== item.id));
				} else {
					setSelectedPets((selectedPets: string[]) => [...selectedPets, item.id]);
				}
			}}
			delayLongPress={200}
		>
			{({ isPressed }: { isPressed: boolean }) => {
				return (
					<Box
						bg={
							selectedPets.includes(item.id)
								? colors.cardColorSelected
								: isPressed
								? colors.cardColorPressed
								: colors.cardColor
						}
						style={{
							width: "100%",
							borderRadius: 15,
							padding: Dimensions.get("window").width < 340 ? 3 : 10,
							transform: [
								{
									scale: isPressed ? 0.96 : 1,
								},
							],
							flex: 1,
							flexDirection: "row",
						}}
						rounded="5"
					>
						<Box
							style={{
								flex: 1,
								flexDirection: "column",
								justifyContent: "space-between",
							}}
							paddingLeft={2}
							paddingRight={2}
							paddingTop={2}
							paddingBottom={2}
						>
							<HStack alignItems="center">
								<Avatar
									bg={colors.primary}
									source={{
										uri: `${petBucket.getPetPhoto(item.id, item.user_id).data}`,
										cache: "reload",
									}}
								>
									<Image
										source={{ uri: petBucket.getPetPhoto().data }}
										style={{ width: "100%", height: "100%", borderRadius: 9999 }}
									/>

									{selectedPets.includes(item.id) && (
										<Avatar.Badge
											bg="green.500"
											bgColor={colors.primary}
											h={32}
											w={32}
											style={{ display: "flex", justifyContent: "center", alignItems: "center" }}
										>
											<Ionicons name="checkmark-sharp" size={8} color="white" />
										</Avatar.Badge>
									)}
								</Avatar>

								<View style={{ display: "flex", flexDirection: "column", paddingLeft: 15 }}>
									<Text
										style={{ marginTop: 5 }}
										color={colors.text}
										fontWeight="medium"
										fontSize="xl"
										numberOfLines={1}
										lineHeight={27}
										ellipsizeMode="tail"
										maxWidth={Dimensions.get("window").width - 250}
									>
										{item.name.length > 15 ? item.name.substring(0, 15) + "..." : item.name}
									</Text>

									{/* <Text style={{ marginTop: 4 }} color={colors.text}>
										{item.breed ?? i18n.get((item as any).breed_relation ?? "pets.noBreed")}
									</Text> */}

									<Text style={{ marginTop: 4 }} fontSize={10} color={colors.text}>
										{getPetDuration(item.birth_date)}
									</Text>

									<Text style={{ marginTop: 4 }} color={colors.text}>
										{petTypes[item.type ?? 6]()}
									</Text>
								</View>

								<Spacer />

								<View style={{ display: "flex", height: "100%", alignItems: "flex-start" }}>
									<Badge
										mb="auto"
										ml="auto"
										mt="7px"
										bgColor={item.gender === 1 ? colors.male : colors.female}
										_text={{
											color: "white",
										}}
										variant="solid"
										rounded="4"
									>
										{item.gender === 1 ? i18n.get("pets.male") : i18n.get("pets.female")}
									</Badge>

									<View style={{ display: "flex", flexDirection: "row" }}>
										<Text style={{ marginTop: 4 }} color={colors.text}>
											{item.breed && item.type ? "," : ""}
										</Text>

										<Text style={{ marginTop: 4, marginLeft: 5, fontSize: 12 }} color={colors.text}>
											{item.breed ?? i18n.get((item as any).breed_relation ?? "pets.noBreed")}
										</Text>
									</View>
								</View>
							</HStack>
						</Box>
					</Box>
				);
			}}
		</Pressable>
	);

	return (
		<ThemedView isRoot>
			{renderHeader()}
			{loading || refreshing ? (
				<View
					style={{
						width: "100%",
						height: 120,
						marginTop: 20,
						display: "flex",
						justifyContent: "center",
						alignItems: "center",
					}}
				>
					<ContentLoader
						viewBox={`0 0 ${Dimensions.get("window").width} 120`}
						backgroundColor={colors.loaderBackColor}
						foregroundColor={colors.loaderForeColor}
					>
						<Rect width={Dimensions.get("window").width} height={120} x={0} y={0} rx={13} ry={13} />
					</ContentLoader>
				</View>
			) : (
				<>
					<FlashList
						// refreshing={refreshing}
						// onRefresh={() => startup().then(() => setRefreshing(false))}
						refreshControl={
							<RefreshControl
								refreshing={refreshing}
								onRefresh={() => startup(true).then(() => setRefreshing(false))}
								tintColor={colors.primary}
								colors={[colors.white]}
								progressBackgroundColor={colors.lightGreen}
							/>
						}
						contentContainerStyle={{ paddingTop: 10 }}
						// ListHeaderComponent={renderHeader}
						alwaysBounceVertical={true}
						data={pets}
						renderItem={renderItem}
						ListFooterComponent={<Box height={100} />}
						estimatedItemSize={200}
						extraData={selectedPets}
					/>

					<Fab
						onPressOut={() => navigate("New")}
						bgColor={colors.primary}
						position="absolute"
						bottom="85px"
						android_ripple={{ color: colors.background }}
						_ios={{ _pressed: { backgroundColor: colors.active } }}
						style={{ paddingLeft: 16, paddingRight: 16, paddingTop: 12, paddingBottom: 12 }}
						renderInPortal={false}
						shadow={2}
						size="xs"
						icon={<Octicons name="plus" size={24} color="white" />}
					/>
				</>
			)}
		</ThemedView>
	);
}
