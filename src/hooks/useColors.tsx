import theme from "@utils/theme";
import { ReactNode, createContext, useContext, useEffect, useState } from "react";

const ColorsContext = createContext(
	{} as { currentColors: typeof theme.light; setCurrentColors: (newColors: typeof theme.light) => void; appTheme: "light" | "dark" }
);

// Hook global para manusear o tema da aplicação
export default () => {
	// Verifica se o contexto está sendo usado dentro de um provider
	// Pense contexto como um estado global, mas que só pode ser acessado dentro de um provider (Componente)
	const context = useContext(ColorsContext);
	if (!context) {
		throw new Error("useColorsState must be used within a ColorsProvider");
	}

	// Obtem o tema atual através do hook useAppTheme
	const [currentColors, setCurrentColors] = useState({ ...theme, ...theme.light });

	// Atualiza as cores do tema atual quando o tema é alterado
	useEffect(() => {
		setCurrentColors(getCurrentThemeColors());
	}, [context.appTheme]);

	// Retorna as cores do tema atual
	const getCurrentThemeColors = () => {
		if (context.appTheme === "light") {
			return { ...theme, ...theme.light };
		} else {
			return { ...theme, ...theme.dark };
		}
	};

	return currentColors;
};

// Provider para o hook useAppTheme (Componente)
export const ColorsProvider = ({ children, appTheme }: { children: ReactNode; appTheme: "light" | "dark" }) => {
	const [currentColors, setCurrentColors] = useState(theme.light);

	return <ColorsContext.Provider value={{ currentColors, setCurrentColors, appTheme }}>{children}</ColorsContext.Provider>;
};
