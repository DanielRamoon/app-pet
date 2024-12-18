import AsyncStorage from "@react-native-async-storage/async-storage";

interface IStorage {
	getItem: <T>(key: string) => Promise<T>;
	getItems: <T>(keys: string[]) => Promise<T[]>;
	setItem: <T>(key: string, _value: T) => Promise<boolean>;
	setItems: (items: [string, string][]) => Promise<boolean>;
	removeItem: (key: string) => Promise<boolean>;
	removeItems: (keys: string[]) => Promise<boolean>;
}

export default {
	getItem: <T>(key: string) =>
		new Promise<T>((resolve, reject) => {
			AsyncStorage.getItem(key, (error, result) => {
				if (error) return reject(error);

				if (!result) return reject(null);
				if (typeof result !== "string") return resolve(result);

				try {
					const parsedResult = JSON.parse(result) as T;
					return resolve(parsedResult);
				} catch (error) {
					return resolve(result as T);
				}
			});
		}),

	getItems: <T>(keys: string[]) =>
		new Promise<T>((resolve, reject) => {
			AsyncStorage.multiGet(keys, (error, result) => {
				if (error) return reject(error);

				if (!result) return reject(null);
				if (typeof result !== "string") return resolve(result as T);

				try {
					const parsedResult = JSON.parse(result) as T;
					return resolve(parsedResult);
				} catch (error) {
					return resolve(result as T);
				}
			});
		}),

	setItem: <T>(key: string, _value: T) =>
		new Promise<boolean>((resolve, reject) => {
			const value = typeof _value === "string" ? _value : JSON.stringify(_value);

			AsyncStorage.setItem(key, value, (error) => {
				if (error) return reject(error);
				return resolve(true);
			});
		}),

	setItems: (items: [string, string][]) =>
		new Promise<boolean>((resolve, reject) => {
			AsyncStorage.multiSet(items, (error) => {
				if (error) return reject(error);
				return resolve(true);
			});
		}),

	removeItem: (key: string) =>
		new Promise<boolean>((resolve, reject) => {
			AsyncStorage.removeItem(key, (error) => {
				if (error) return reject(error);
				return resolve(true);
			});
		}),

	removeItems: (keys: string[]) =>
		new Promise<boolean>((resolve, reject) => {
			AsyncStorage.multiRemove(keys, (error) => {
				if (error) return reject(error);
				return resolve(true);
			});
		}),
} as IStorage;
