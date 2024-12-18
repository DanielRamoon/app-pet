import { getDistance } from "geolib";
import { WalkingStateValue } from "src/store/features/walkSlice";
import { ILineProps } from "types/pets";
export function recalculateDuration(timeRegistry: WalkingStateValue["timeRegistry"]) {
	let tempoTotal = 0;
	let lastResumed = 0;
	let paused = false;

	if (timeRegistry.length === 0) {
		// Caso não haja registros, o tempo total é zero
		return 0;
	}

	timeRegistry.forEach((registry, index) => {
		const chave = Object.keys(registry)[0] as "started" | "resumed" | "paused" | "finished";
		const valor = registry[chave]!;

		switch (chave) {
			case "started":
			case "resumed":
				if (!paused) {
					lastResumed = valor;
				}
				paused = false;
				break;
			case "paused":
				if (!paused) {
					tempoTotal += valor - lastResumed;
					paused = true;
				}
				break;
			case "finished":
				if (!paused) {
					tempoTotal += valor - lastResumed;
				}
				paused = true; // Marcar como pausado para evitar duplicar o tempo
				break;
		}

		// Log para debug
		console.log(`Registro ${index}:`, { chave, valor, tempoTotal, lastResumed, paused });
	});

	// Caso não esteja pausado, adicionar o tempo final ao total
	const lastRegistry = timeRegistry[timeRegistry.length - 1];
	if (!paused && !lastRegistry.finished) {
		const end = lastRegistry.finished || Date.now();
		tempoTotal += end - lastResumed;
	}

	console.log("Tempo total (ms):", tempoTotal);
	return Math.floor(tempoTotal / 1000); // Converte milissegundos para segundos
}

/**
 * Calculates kilometers, footsteps, and pet kicks based on an array of walked paths.
 * @param paths - An array of walked paths.
 * @returns An object with the calculated values of kilometers, footsteps, and pet kicks.
 */
export function calculateKilometersFootstepsAndPetKicks(paths: ILineProps[]): { km: number; fs: number; pk: number } {
	let km = 0;
	let fs = 0;
	let pk = 0;

	// Calculate kilometers only from the last two paths
	if (paths.length >= 2) {
		const lastPath = paths[paths.length - 1];
		const secondLastPath = paths[paths.length - 2];

		// km = calculateDistance(lastPath.latitude, lastPath.longitude, secondLastPath.latitude, secondLastPath.longitude);
		km =
			getDistance(
				{ lat: lastPath.latitude, lon: lastPath.longitude },
				{ lat: secondLastPath.latitude, lon: secondLastPath.longitude }
			) / 1000;

		// Extract footsteps from the distance
		fs = Math.floor((km * 1000) / 0.762);

		// Transform footsteps into pet kicks
		pk = convertStepsToPawStrikes(fs);

		// Round kilometers to 5 decimal places and divide by 2, because the user walks with two legs
		km = Number(km.toFixed(5));
	}

	return {
		km,
		fs: Math.floor(fs),
		pk: Math.floor(pk),
	};
}

/**
 * Converts steps into paw strikes for an average-sized dog.
 * @param {number} stepLength - The length of a step in meters.
 * @returns {number} The approximate number of paw strikes.
 */
export function convertStepsToPawStrikes(humanSteps: number): number {
	const humanStepLength = 0.762 * 1.7; // comprimento médio de um passo humano em metros
	const dogPawLength = 0.25 * 1.7; // comprimento médio de uma pegada de cachorro em metros

	// Calcula a distância total percorrida pelo humano
	const totalDistance = humanSteps * humanStepLength;

	// Calcula o número aproximado de pegadas de cachorro
	const dogPawStrikes = totalDistance / dogPawLength;

	return Math.round(dogPawStrikes); // Arredonda para o inteiro mais próximo
}
