import { DateTime } from "luxon";
import i18n from "./i18n";
import { ILineProps, IWalkedPath } from "types/pets";
import { Region } from "react-native-maps";
import { capitalize } from "lodash";
import { getDistance } from "geolib";

interface Options {
	removeHash: boolean;
}

export function getRandomHexColor(options?: Options) {
	let returning = "";

	if (!options?.removeHash) returning = "#";

	return returning + Math.floor(Math.random() * 16777215).toString(16);
}

/**
 * Checks if a string is null, undefined, empty, or contains only whitespace characters.
 * @param str - The string to check.
 * @returns True if the string is null, undefined, empty, or contains only whitespace characters, false otherwise.
 */
export function isNullOrEmpty(str: string | null | undefined): boolean {
	if (str === null || str === undefined || str.trim().length === 0 || /^\s+$/.test(str)) return true;
	return false;
}

/**
 * Return relative date time based on the given date.
 * @param date - Date
 * @returns Relative date time based on the given date.
 */
export function getPetDuration(date?: string | null) {
	if (isNullOrEmpty(date) || !date) return;

	const now = DateTime.now();
	const petDate = DateTime.fromISO(date);

	const diff = now.diff(petDate, ["years", "months"]).toObject();

	let returnString = "";

	if (diff.years! === 1) returnString += `${Math.floor(diff.years!)} ${i18n.get("date.year")}`;
	else if (diff.years! !== 1) returnString += `${Math.floor(diff.years!)} ${i18n.get("date.years")}`;

	returnString += ` ${i18n.get("and")} `;

	if (diff.months! === 1) returnString += `${Math.floor(diff?.months!)} ${i18n.get("date.month")}`;
	else if (diff.months! !== 1) returnString += `${Math.floor(diff?.months!)} ${i18n.get("date.months")}`;

	return returnString;
}

/**
 * Calculates the distance between two points using the Haversine formula.
 * @param lat1 - Latitude of the first point.
 * @param lon1 - Longitude of the first point.
 * @param lat2 - Latitude of the second point.
 * @param lon2 - Longitude of the second point.
 * @returns The distance between the two points in kilometers.
 */
export function calculateDistance(lat1: number, lon1: number, lat2: number, lon2: number): number {
	const earthRadius = 6371; // Earth's radius in kilometers
	const dLat = toRadians(lat2 - lat1);
	const dLon = toRadians(lon2 - lon1);

	const a =
		Math.sin(dLat / 2) * Math.sin(dLat / 2) +
		Math.cos(toRadians(lat1)) * Math.cos(toRadians(lat2)) * Math.sin(dLon / 2) * Math.sin(dLon / 2);

	const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
	const distance = earthRadius * c;

	return distance;
}

/**
 * Converts degrees to radians.
 * @param degrees - The angle in degrees.
 * @returns The angle in radians.
 */
export function toRadians(degrees: number): number {
	return degrees * (Math.PI / 180);
}

export function calculateMapRegion(path?: ILineProps[][]): Region | undefined {
	if (!path) return;

	let minLatitude = Infinity;
	let maxLatitude = -Infinity;
	let minLongitude = Infinity;
	let maxLongitude = -Infinity;

	// Find the minimum and maximum latitude and longitude values
	for (const line of path) {
		for (const point of line) {
			if (point.latitude < minLatitude) {
				minLatitude = point.latitude;
			}
			if (point.latitude > maxLatitude) {
				maxLatitude = point.latitude;
			}
			if (point.longitude < minLongitude) {
				minLongitude = point.longitude;
			}
			if (point.longitude > maxLongitude) {
				maxLongitude = point.longitude;
			}
		}
	}

	// Calculate the center of the path
	const centerLatitude = (minLatitude + maxLatitude) / 2;
	const centerLongitude = (minLongitude + maxLongitude) / 2;

	// Calculate the zoom level to cover the whole path
	const deltaLatitude = maxLatitude - minLatitude;
	const deltaLongitude = maxLongitude - minLongitude;
	const zoom = Math.max(deltaLatitude, deltaLongitude);

	// Create the region object
	const region: Region = {
		latitude: centerLatitude,
		longitude: centerLongitude,
		latitudeDelta: zoom,
		longitudeDelta: zoom,
	};

	return region;
}

export function getRelativeTimeText(dateTimeISO: string): string {
	const currentDateTime = DateTime.now();
	const givenDateTime = DateTime.fromISO(dateTimeISO);

	const diff = currentDateTime.diff(givenDateTime, ["years", "months", "days", "hours", "minutes", "seconds"]);

	const ago = i18n.get("date.ago");

	if (diff.as("seconds") < 60) {
		return capitalize(i18n.get("date.justNow"));
	}

	if (diff.as("minutes") < 60) {
		const minutes = `${i18n.get("date.minute")}${Math.floor(diff.as("minutes")) === 1 ? "" : "s"}`;
		return `${Math.floor(diff.as("minutes"))} ${minutes} ${ago}`;
	}

	if (diff.as("hours") < 24) {
		const hours = `${i18n.get("date.hour")}${Math.floor(diff.as("hours")) === 1 ? "" : "s"}`;
		return `${Math.floor(diff.as("hours"))} ${hours} ${ago}`;
	}

	if (diff.as("days") < 30) {
		const days = `${i18n.get("date.day")}${Math.floor(diff.as("days")) === 1 ? "" : "s"}`;
		return `${Math.floor(diff.as("days"))} ${days} ${ago}`;
	}

	if (diff.as("months") < 12) {
		const months = `${i18n.get("date.month")}${Math.floor(diff.as("months")) === 1 ? "" : "s"}`;
		return `${Math.floor(diff.as("months"))} ${months} ${ago}`;
	}

	return givenDateTime.toFormat(i18n.get("date.format"));
}
