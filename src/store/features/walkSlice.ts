import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { IPetWalk } from "@utils/supabase/services/walk/walk.service";
import { calculateKilometersFootstepsAndPetKicks, recalculateDuration } from "@utils/walk";
import { getDistance } from "geolib";
import { ILineProps } from "types/pets";

interface TimeRegistry {
	started?: number;
	resumed?: number;
	paused?: number;
	finished?: number;
}

export interface WalkingStateValue {
	walkIds: Array<string> | undefined;
	walk: Partial<IPetWalk>;
	duration: number;
	distance: {
		km: number;
		humanDistance: number;
		animalDistance: number;
	};
	timeRegistry: Array<TimeRegistry>;
	userData: { id: string; name: string; image: string };
	petsData: Array<{ id: string; name: "QUERY" }>;
}

export interface WalkingState {
	status: "idle" | "walking" | "paused" | "finished";
	hideTabBar: boolean;
	hideAppBar: boolean;
	value: WalkingStateValue;
}

const initialState: WalkingState = {
	status: "idle",
	hideTabBar: false,
	hideAppBar: false,
	value: {
		walkIds: undefined,
		walk: {
			distance: [],
		},
		duration: 0,
		distance: {
			km: 0,
			humanDistance: 0,
			animalDistance: 0,
		},
		timeRegistry: [],
		userData: { id: "", name: "", image: "" },
		petsData: [],
	},
};

const walkSlice = createSlice({
	name: "currentWalk",
	initialState,
	reducers: {
		toogleBar: (state: any, action: PayloadAction<{ value?: boolean }>) => {
			state.hideTabBar = action.payload.value ?? !state.hideTabBar;
			state.hideAppBar = action.payload.value ?? !state.hideAppBar;
		},

		resetWalk: (state: any) => {
			state.status = "idle";
			state.value = { ...initialState.value };
		},

		startWalk: (
			state: any,
			action: PayloadAction<{
				user: { id: string; name: string; image: string };
				pets: Array<{ id: string; name: "QUERY" }>;
			}>
		) => {
			if (state.status === "idle" || state.status === "finished") {
				state.status = "walking";

				state.value = {
					...initialState.value,
					timeRegistry: [{ started: Date.now() }],
					walk: {
						distance: [],
						date_start: new Date().toISOString(),
						created_at: new Date().toISOString(),
					},
					userData: action.payload.user,
					petsData: action.payload.pets,
				};
			}
		},

		pauseWalk: (state: any) => {
			if (state.status === "walking") {
				state.status = "paused";

				state.value.timeRegistry.push({ paused: Date.now() });
			}

			// Atualiza o estado com os novos valores
			state.value = {
				...state.value,
			} as WalkingStateValue;
		},

		resumeWalk: (state: any) => {
			if (state.status === "paused") {
				state.status = "walking";

				// Adiciona um array vazio para representar a retomada da caminhada (verificando se o último array de distância está vazio ou não)
				if (state.value.walk.distance[state.value.walk.distance.length - 1].length > 0) {
					state.value.walk.distance.push([]);
				}

				state.value.timeRegistry.push({ resumed: Date.now() });
			}

			// Atualiza o estado com os novos valores
			state.value = {
				...state.value,
			} as WalkingStateValue;
		},

		finishWalk: (state: any, action: PayloadAction<{ walkIds: string[] }>) => {
			state.status = "finished";

			if (action.payload.walkIds.length === 0) state.value.timeRegistry.push({ finished: Date.now() });

			// Atualiza o estado com os novos valores
			state.value = {
				...state.value,
				walkIds: action.payload.walkIds,
				duration: recalculateDuration(state.value.timeRegistry),
			} as WalkingStateValue;
		},

		// updateWalkData: (
		// 	state: any,
		// 	action: PayloadAction<Pick<WalkingStateValue, "distance"> & { lineProps: ILineProps[][] }>
		// ) => {
		// 	if (state.status === "walking") {
		// 		state.value = {
		// 			distance: action.payload.distance,
		// 			duration: recalculateDuration(state.value.timeRegistry),
		// 			walk: {
		// 				...state.value.walk,
		// 				distance: action.payload.lineProps,
		// 			},
		// 			timeRegistry: state.value.timeRegistry,
		// 		} as WalkingStateValue;

		// 		console.log("WALK DATA UPDATED", state.value);
		// 	}
		// },

		updateDurationByOneSecond: (state: any) => {
			if (state.status === "walking") {
				state.value = {
					...state.value,
					duration: state.value.duration + 1,
				} as WalkingStateValue;
			}
		},

		updateWalkDataDistance: (state: any, action: PayloadAction<ILineProps[]>) => {
			// Remove valores inválidos do array de distância
			action.payload = action.payload.filter((item) => !!item?.latitude && !!item?.longitude);

			if (state.status === "walking") {
				const OFFSET = 0.5; // Ajuste conforme necessário

				let firstItem = false;

				// Se o array de distância estiver vazio, cria um novo array
				if (state.value.walk.distance.length === 0) {
					state.value = {
						...state.value,
						walk: {
							...state.value.walk,
							distance: [[...action.payload]],
						},
					} as WalkingStateValue;

					firstItem = true;
				}

				// Se o array de distância tiver pelo menos um item, verifica se a distância entre o último item e o novo item é maior que o offset
				if (!firstItem) {
					// Busca o último array de distância
					let lastDistance = state.value.walk.distance[state.value.walk.distance.length - 1];

					// Se o array atual está vazio, adiciona duas vezes
					if (lastDistance.length === 0) {
						state.value.walk.distance[state.value.walk.distance.length - 1].push(...action.payload);
						lastDistance = state.value.walk.distance[state.value.walk.distance.length - 1];
					}

					// Inicializa previousLocation com a última localização do último array
					let previousLocation = lastDistance[lastDistance.length - 1];

					// Itera sobre as novas localizações para calcular a distância total
					action.payload.forEach((location) => {
						const distance = getDistance(previousLocation, location);

						if (distance > OFFSET) {
							// Adiciona a nova localização ao array de distância
							state.value.walk.distance[state.value.walk.distance.length - 1].push(location);

							// Atualiza previousLocation
							previousLocation = location;
						}
					});

					// **Aqui está a modificação:**
					// Calcula a distância percorrida, os passos e as pegadas do pet a partir da linha traçada no mapa
					const {
						km,
						pk: animalDistance,
						fs: humanDistance,
					} = calculateKilometersFootstepsAndPetKicks(state.value.walk.distance.flat());

					// Certifique-se de que o estado da distância esteja acumulando corretamente, somando o valor anterior ao novo
					state.value = {
						...state.value,
						distance: {
							km: (state.value.distance?.km || 0) + km,
							humanDistance: (state.value.distance?.humanDistance || 0) + humanDistance,
							animalDistance: (state.value.distance?.animalDistance || 0) + animalDistance,
						},
						// duration: recalculateDuration(state.value.timeRegistry),
					} as WalkingStateValue;
				}
			}
		},
	},
});

export const {
	toogleBar,
	resetWalk,
	startWalk,
	pauseWalk,
	resumeWalk,
	finishWalk,
	updateDurationByOneSecond,
	updateWalkDataDistance,
} = walkSlice.actions;

export default walkSlice.reducer;
