export function generateSimulatedLocation(
	startLat: number,
	startLon: number,
	distance: number = 0.01
): { latitude: number; longitude: number } {
	const offsetLat = (Math.random() - 0.5) * distance;
	const offsetLon = (Math.random() - 0.5) * distance;

	return {
		latitude: startLat + offsetLat,
		longitude: startLon + offsetLon,
	};
}
