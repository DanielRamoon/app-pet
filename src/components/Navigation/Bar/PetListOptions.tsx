import PlatformButton from "@components/Wrappers/PlatformButton";
import { Ionicons, Octicons } from "@expo/vector-icons";
import useColors from "@hooks/useColors";
import i18n from "@utils/i18n";
import { AlertDialog, Button, Menu } from "native-base";
import { StyleSheet, View, DeviceEventEmitter, TouchableOpacity } from "react-native";
import { Text } from "@ui-kitten/components";
import { logOut } from "@utils/supabase/client";
import { navigate } from "@utils/navigator";
import { useEffect, useRef, useState } from "react";
import flex from "@styles/flex";
import LoadingModal from "@components/Modals/LoadingModal";
import SuccessModal from "@components/Modals/SuccessModal";
import petsService from "@utils/supabase/services/pets/pets.service";
import { HttpStatusCode } from "axios";
import ErrorModal from "@components/Modals/ErrorModal";

export default function PetListOptions() {
	const [petsIds, setPetsIds] = useState<string[]>([]);

	const [isDeleting, setIsDeleting] = useState(false);
	const [isLoading, setIsLoading] = useState(false);

	const [success, setSuccess] = useState(false);
	const [error, setError] = useState(false);

	const colors = useColors();

	const cancelRef = useRef(null);

	useEffect(() => {
		const petsIdsUpdated = DeviceEventEmitter.addListener("selectedPetsUpdate", (petsIds: string[]) => {
			setPetsIds(petsIds);
		});

		return () => {
			petsIdsUpdated.remove();
		};
	}, []);

	const deletePets = async () => {
		setIsLoading(true);
		setIsDeleting(false);

		const result = await petsService.deletePets(petsIds);

		if (result.status === HttpStatusCode.InternalServerError) {
			setIsLoading(false);
			setError(true);
		}

		setIsLoading(false);
		setSuccess(true);

		setTimeout(() => {
			setSuccess(false);
			DeviceEventEmitter.emit("refreshPets");
		}, 1250);
	};

	if (petsIds.length === 0) return null;

	return (
		<>
			{isLoading && <LoadingModal />}
			{success && <SuccessModal />}
			{error && <ErrorModal errorMessage={i18n.get("pets.errors.deletePets")} />}

			<AlertDialog
				isOpen={isDeleting}
				onClose={() => setIsDeleting(false)}
				leastDestructiveRef={cancelRef}
				closeOnOverlayClick={true}
				overlayVisible={true}
				safeArea={true}
			>
				<AlertDialog.Content>
					<AlertDialog.CloseButton />
					<AlertDialog.Header>{i18n.get("pets.questions.deletePetsTitle")}</AlertDialog.Header>
					<AlertDialog.Body>
						<Text>{i18n.get("pets.questions.deletePets")}</Text>
					</AlertDialog.Body>
					<AlertDialog.Footer>
						<Button.Group space={2}>
							<PlatformButton
								onPress={() => setIsDeleting(false)}
								style={{ backgroundColor: colors.danger }}
								useDefaultStyle={true}
							>
								{i18n.get("cancel")}
							</PlatformButton>
							<PlatformButton
								onPress={() => deletePets()}
								style={{ backgroundColor: colors.primary }}
								useDefaultStyle={true}
							>
								{i18n.get("confirm")}
							</PlatformButton>
						</Button.Group>
					</AlertDialog.Footer>
				</AlertDialog.Content>
			</AlertDialog>

			<View
				style={{
					display: "flex",
					flexDirection: "row",
					alignItems: "center",
					justifyContent: "center",
					height: "100%",
					gap: 15,
					marginRight: 15,
				}}
			>
				{/* <TouchableOpacity onPress={() => {}} style={{ padding: 5 }}>
				<Octicons name="pencil" color="white" size={24} />
			</TouchableOpacity> */}

				<TouchableOpacity onPress={() => setIsDeleting(true)} style={{ padding: 5 }}>
					<Octicons name="trash" color={colors.text} size={24} />
				</TouchableOpacity>

				<TouchableOpacity onPress={() => DeviceEventEmitter.emit("cancelPets")} style={{ padding: 5 }}>
					<Octicons name="x" color={colors.text} size={24} />
				</TouchableOpacity>
			</View>
		</>
	);
}
