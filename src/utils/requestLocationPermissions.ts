import * as TaskManager from "expo-task-manager";
import * as Location from "expo-location";
import AsyncStorage from "@react-native-async-storage/async-storage";

// Nome da tarefa
export const LOCATION_TASK_NAME = "ptvd-background-location-task";

TaskManager.defineTask(LOCATION_TASK_NAME, async ({ data, error }: TaskManager.TaskManagerTaskBody) => {
	if (error) {
		console.error("Erro na tarefa de localização em segundo plano:", error);
		return;
	}

	if (data) {
		const { locations } = data as { locations: Location.LocationObject[] };

		if (locations && locations.length > 0) {
			console.log("Localizações em segundo plano recebidas:", locations);

			try {
				// Obtém as localizações salvas previamente
				const storedLocations = await AsyncStorage.getItem("@ptvd:backgroundLocations");
				const parsedLocations = storedLocations ? JSON.parse(storedLocations) : [];

				console.log("Localizações armazenadas antes de adicionar novas:", parsedLocations);

				// Adiciona novas localizações
				const updatedLocations = [
					...parsedLocations,
					...locations.map((location) => ({
						latitude: location.coords.latitude,
						longitude: location.coords.longitude,
						timestamp: String(location.timestamp),
					})),
				];

				// Armazena as novas localizações
				await AsyncStorage.setItem("@ptvd:backgroundLocations", JSON.stringify(updatedLocations));

				console.log("Localizações atualizadas e salvas com sucesso.");
			} catch (error) {
				console.error("Erro ao processar e salvar localizações em segundo plano:", error);
			}
		}
	}
});
