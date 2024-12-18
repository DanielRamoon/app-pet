// // Old methods

// const colors = useColors();
// const currentWalk = useCurrentWalk();
// const [appTheme] = useAppTheme();

// const [starting, setStarting] = useState<boolean>(false);
// const [ending, setEnding] = useState<boolean>(false);
// const [deleting, setDeleting] = useState<boolean>(false);
// const [loading, setLoading] = useState<boolean>(true);
// const [show, setShow] = useState<boolean>(false);
// const [permission, setPermission] = useState<boolean>(false);
// const [listVisible, setListVisible] = useState<boolean>(true);
// const [showWalkInfo, setShowWalkInfo] = useState<boolean>(false);

// const [petsIds, setPetIds] = useState<petProps[]>([]);

// const [pets, setPets] = useState<IPet[]>();

// const isFocused = useRef(false);

// function togglePetList() {
// 	setListVisible(!listVisible);
// }

// async function startup() {
// 	const result = await petsService.getPets("asc", undefined);
// 	setPets(result.data);
// }

// async function checkPermission() {
// 	const { status } = await Location.requestForegroundPermissionsAsync();
// 	if (status !== "granted") {
// 		setPermission(true);
// 		return null;
// 	}
// }

// useEffect(() => {
// 	checkPermission();
// 	// check for navigation focus and run startup
// 	const unsubscribe = navigation.addListener("focus", () => {
// 		isFocused.current = true;

// 		setLoading(true);
// 		startup().finally(() => setTimeout(() => setLoading(false), 1000));
// 	});

// 	const unsubscribeBlur = navigation.addListener("blur", () => {
// 		isFocused.current = false;
// 	});

// 	const unsubscribeBack = BackHandler.addEventListener("hardwareBackPress", () => {
// 		// unsubscribeBack.remove();

// 		// navigate("Home", { screen: "Home" });

// 		// return true;

// 		if (!isFocused.current) return false;

// 		return true;
// 	});

// 	return () => {
// 		unsubscribe();
// 		unsubscribeBack.remove();
// 		unsubscribeBlur();
// 	};
// }, []);

// useEffect(() => {
// 	if (!currentWalk.walk.walking) Location.stopLocationUpdatesAsync(LOCATION_TASK_NAME).catch(() => 0);
// }, [currentWalk.walk.walking]);

// async function manageWalkInfoClose(action: WalkInfoActions) {
// 	if (action === "end") {
// 		setEnding(true);
// 	} else if (action === "delete") {
// 		setDeleting(true);
// 	}
// }

// const beginWalk = async (pet: petProps[]) => {
// 	if (starting) return;

// 	setStarting(true);

// 	let seconds = 3;
// 	const countdown = setInterval(async () => {
// 		if (seconds-- <= 0) {
// 			togglePetList();
// 			setStarting(false);
// 			setShow(true);
// 			clearInterval(countdown);

// 			// await mapRef.current?.beginWalk(pet)!;
// 			Alert.alert("PRECISA FAZER O INÍCIO DA CAMINHADA!");

// 			return;
// 		}
// 	}, 750);
// };

// const preparedToWalk = (petId: string, name: string) => {
// 	const isIncluded = petsIds.some((pet) => pet.id === petId && pet.name === name);

// 	if (isIncluded) {
// 		setPetIds((petsIds) => petsIds.filter((pet) => pet.id !== petId || pet.name !== name));
// 		return;
// 	}

// 	setPetIds((petsIds) => [...petsIds, { name: name, id: petId }]);
// };

// const endWalk = async () => {
// 	setShowWalkInfo(false);
// 	setEnding(false);
// 	setShow(false);

// 	// const success = await mapRef.current?.endWalk(petsIds)!;
// 	Alert.alert("PRECISA FAZER A FINALIZAÇÃO DA CAMINHADA!");
// 	const success = Number.NEGATIVE_INFINITY;

// 	if (success === Number.NEGATIVE_INFINITY) return togglePetList();

// 	setShowWalkInfo(true);

// 	togglePetList();
// };

// const deleteWalk = async () => {
// 	setDeleting(false);

// 	try {
// 		// await mapRef.current?.deleteWalk()!;
// 		Alert.alert("PRECISA FAZER A EXCLUSÃO DA CAMINHADA!");

// 		setListVisible(true);
// 		setShowWalkInfo(false);

// 		currentWalk.setWalk({ finished: false });

// 		DeviceEventEmitter.emit("showAppBar");
// 		DeviceEventEmitter.emit("showTabBar");
// 	} catch (e) {
// 		console.log("Error END WALK: ", e);
// 	}
// };

// const showInfoScreen = () => {
// 	setShowWalkInfo(true);
// };
