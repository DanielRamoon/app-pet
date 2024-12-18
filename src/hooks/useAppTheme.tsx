import AsyncStorage from "@react-native-async-storage/async-storage";
import { useColorMode } from "native-base";
import { Dispatch, ReactNode, SetStateAction, createContext, useContext, useEffect, useState } from "react";
import { DeviceEventEmitter } from "react-native";
import { ColorsProvider } from "./useColors";

const AppThemeContext = createContext(
	{} as { appTheme: string; setAppTheme: Dispatch<SetStateAction<"light" | "dark">> }
);

// Hook global para manusear o tema da aplicação
export default () => {
	// Verifica se o contexto está sendo usado dentro de um provider
	// Pense contexto como um estado global, mas que só pode ser acessado dentro de um provider (Componente)
	const context = useContext(AppThemeContext);
	if (!context) {
		throw new Error("useGlobalState must be used within a AppThemeProvider");
	}

	const { setColorMode, setAccessibleColors } = useColorMode();

	/**
	 * Altera o tema da aplicação
	 * @param {string} newTheme - Tema a ser aplicado
	 */
	const changeTheme = async (newTheme: "light" | "dark") => {
		context.setAppTheme(newTheme);
		setColorMode(newTheme);
		setAccessibleColors(false);

		DeviceEventEmitter.emit("changeTheme", newTheme);
		try {
			await AsyncStorage.setItem("@petvidade:theme", newTheme);
		} catch (e) {
			console.log(e);
		}
	};

	/**
	 * Altera o tema da aplicação baseado no tema atual
	 */
	const toggleTheme = async () => {
		if (context.appTheme === "light") changeTheme("dark");
		else changeTheme("light");
	};

	useEffect(() => {
		//Obtem o tema da "LocalStorage"
		const getTheme = async () => {
			try {
				const themeFromStorage = await AsyncStorage.getItem("@petvidade:theme");
				if (themeFromStorage !== null) {
					context.setAppTheme(themeFromStorage as "light" | "dark");
					setColorMode(themeFromStorage);
					DeviceEventEmitter.emit("changeTheme", themeFromStorage);
				} else {
					// Coloca o tema como claro por padrão
					context.setAppTheme("light");
					setColorMode("light");
					DeviceEventEmitter.emit("changeTheme", "light");
					AsyncStorage.setItem("@petvidade:theme", "light");
				}
			} catch (e) {
				console.log(e);
			}
		};
		getTheme();
	}, []);

	// Retorna o tema atual e as funções utilitárias
	return [context.appTheme, toggleTheme, changeTheme] as [
		string,
		() => void,
		Dispatch<SetStateAction<"light" | "dark">>
	];
};

// Provider para o hook useAppTheme (Componente)
export const AppThemeProvider = ({ children }: { children: ReactNode }) => {
	const [appTheme, setAppTheme] = useState<"light" | "dark">("light");

	return (
		<AppThemeContext.Provider value={{ appTheme, setAppTheme }}>
			<ColorsProvider appTheme={appTheme}>{children}</ColorsProvider>
		</AppThemeContext.Provider>
	);
};
