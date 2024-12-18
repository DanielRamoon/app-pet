import { IPetWalk } from "@utils/supabase/services/walk/walk.service";
import { calculateKilometersFootstepsAndPetKicks } from "@utils/utilities";
import { ReactNode, createContext, useContext, useEffect, useState } from "react";
import { IWalkedDuration } from "types/pets";
import { petProps } from "types/pets";
interface ICurrentWalk {
	// Private
	_durationChecker: NodeJS.Timeout | undefined;
	_lastDataDistanceLength: number;

	// Public
	data: Partial<IPetWalk>;
	paused: boolean;
	duration: number;
	id: string;
	distance: IWalkedDuration;
	finished: boolean;
	finishedId: number | string | undefined;
	petData?: petProps;
	userData?: {
		id: number | string;
		name: string;
		image: string;
	};
	walking: boolean;
}

// Pense nisso como uma classe
const defaultState: ICurrentWalk = {
	_durationChecker: undefined,
	_lastDataDistanceLength: 0,

	data: {},
	duration: 0,
	distance: { km: 0, humanDistance: 0, animalDistance: 0 },
	paused: true,
	finished: false,
	finishedId: undefined,
	petData: undefined,
	userData: undefined,
	walking: false,
};

const CurrentWalkContext = createContext(
	{} as {
		currentWalk: ICurrentWalk;
		setCurrentWalk: (newCurrentWalk: ICurrentWalk | ((_: ICurrentWalk) => void)) => void;
	}
);

// Hook global para manusear o estado da caminhada atual
export default () => {
	// Verifica se o contexto está sendo usado dentro de um provider
	// Pense contexto como um estado global, mas que só pode ser acessado dentro de um provider (Componente)
	const context = useContext(CurrentWalkContext);
	if (!context) {
		throw new Error("useCurrentWalkState must be used within a CurrentWalkProvider");
	}

	const recalculateWalkValues = (currentWalk: ICurrentWalk) => {
		if (currentWalk.paused) return currentWalk;

		const lastDistance = currentWalk.data.distance?.[currentWalk.data.distance.length - 1];

		if (lastDistance && currentWalk._lastDataDistanceLength !== lastDistance.length) {
			const { km, fs, pk } = calculateKilometersFootstepsAndPetKicks(lastDistance);

			console.log(
				"Distancia caminhada:",
				km,
				"+",
				currentWalk.distance.km,
				"=",
				Number((km + currentWalk.distance.km).toFixed(5))
			);

			const walkValues = {
				...currentWalk,
				_lastDataDistanceLength: lastDistance.length,
				distance: {
					km: Number((km + currentWalk.distance.km).toFixed(5)),
					humanDistance: currentWalk.distance.humanDistance + fs, // Footsteps
					animalDistance: currentWalk.distance.animalDistance + pk, // Pet kicks
				},
				paused: false,
			};

			return walkValues;
		}
	};

	return {
		walk: context.currentWalk,

		setWalk: (newWalk: Partial<ICurrentWalk>) => {
			console.log("[CURRENT WALK] Setting");

			const walkValues = recalculateWalkValues({
				...context.currentWalk,
				...newWalk,
			});

			context.setCurrentWalk((prevWalk) => {
				const newCurrentWalk = {
					...prevWalk,
					...walkValues,
				};

				return newCurrentWalk;
			});
		},

		start: (
			userData?: { id: any; name: string; image: string },
			petData?: { petData: petProps[] },
			walkData?: Partial<ICurrentWalk>
		) => {
			console.log("[CURRENT WALK] Starting");

			context.setCurrentWalk((prevWalk) => {
				if (prevWalk._durationChecker) clearInterval(prevWalk._durationChecker);

				const newWalk = {
					...defaultState,
					...walkData,
					paused: false,
					duration: 0,
					distance: { km: 0, humanDistance: 0, animalDistance: 0 },
					_durationChecker: setInterval(() => {
						context.setCurrentWalk((prevWalk) => ({
							...prevWalk,
							duration: prevWalk.duration + 1,
						}));
					}, 1000),
					petData: petData,
					userData: userData,
					walking: true,
				};

				return newWalk;
			});
		},

		reset: () => {
			console.log("[CURRENT WALK] Resetting");

			if (context.currentWalk._durationChecker) clearInterval(context.currentWalk._durationChecker);

			context.setCurrentWalk({ ...defaultState });
		},

		stop: () => {
			console.log("[CURRENT WALK] Stopping");

			if (context.currentWalk._durationChecker) clearInterval(context.currentWalk._durationChecker);

			const currentState = { ...context.currentWalk };

			// context.setCurrentWalk({ ...defaultState });

			context.setCurrentWalk((prevWalk) => {
				const newWalk = {
					...prevWalk,
					finished: true,
				};

				return newWalk;
			});

			return currentState;
		},

		pause: () => {
			console.log("[CURRENT WALK] Pausing");

			if (context.currentWalk._durationChecker) clearInterval(context.currentWalk._durationChecker);

			// Adiciona um novo array de distancia
			const currentWalk = { ...context.currentWalk, paused: true };

			// Verifica se o ultimo item do array de distancia é um array e se está vazio, se não, adiciona um novo array
			if (
				currentWalk.data?.distance?.[currentWalk.data.distance?.length - 1] &&
				Array.isArray(currentWalk.data.distance?.[currentWalk.data.distance?.length - 1]) &&
				currentWalk.data?.distance?.[currentWalk.data.distance?.length - 1]?.length > 0
			)
				currentWalk.data.distance?.push([]);

			context.setCurrentWalk(currentWalk);
		},

		resume: () => {
			console.log("[CURRENT WALK] Resuming");

			context.setCurrentWalk((prevWalk) => {
				if (prevWalk._durationChecker) clearInterval(prevWalk._durationChecker);

				const newWalk = {
					...prevWalk,
					paused: false,
					_durationChecker: setInterval(() => {
						context.setCurrentWalk((prevWalk) => ({
							...prevWalk,
							duration: prevWalk.duration + 1,
						}));
					}, 1000),
				};

				return newWalk;
			});
		},
	};
};

// Provider para o hook useAppTheme (Componente)
export const CurrentWalkProvider = ({ children }: { children: ReactNode }) => {
	const [currentWalk, setCurrentWalk] = useState({ ...defaultState });

	return <CurrentWalkContext.Provider value={{ currentWalk, setCurrentWalk }}>{children}</CurrentWalkContext.Provider>;
};
