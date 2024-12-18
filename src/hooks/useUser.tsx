import { User, UserResponse } from "@supabase/supabase-js";
import { supabase } from "@utils/supabase/client";
import { createContext, ReactNode, useContext, useEffect, useState } from "react";
import { DeviceEventEmitter } from "react-native";

const UserContext = createContext({} as { currentUser: User | null; setCurrentUser: (newUser: User | null) => void });

// Hook global para manusear o tema da aplicação
export default () => {
	// Verifica se o contexto está sendo usado dentro de um provider
	// Pense contexto como um estado global, mas que só pode ser acessado dentro de um provider (Componente)
	const context = useContext(UserContext);
	if (!context) {
		throw new Error("useUserState must be used within a UserProvider");
	}

	useEffect(() => {
		getUserAsync();

		const { data: authListener } = supabase.auth.onAuthStateChange(async (event, session) => {
			if (session && session.user) {
				context.setCurrentUser(session.user);

				DeviceEventEmitter.emit("onAuth");
				DeviceEventEmitter.emit("onAuthResult", true);
			} else {
				context.setCurrentUser(null);
				DeviceEventEmitter.emit("onAuthResult", false);
			}
		});

		return () => {
			authListener!.subscription.unsubscribe();
		};
	}, []);

	const getUserSync = () => {
		return context.currentUser;
	};

	const getUserAsync = async () => {
		const { data, error } = await supabase.auth.getUser();

		if (error) return DeviceEventEmitter.emit("onAuthResult", false);
		else DeviceEventEmitter.emit("onAuthResult", true);

		context.setCurrentUser(data.user);

		return data.user;
	};

	return { getUserAsync, getUserSync, user: context.currentUser };
};

// Provider para o hook useUser (Componente)
export const UserProvider = ({ children }: { children: ReactNode }) => {
	const [currentUser, setCurrentUser] = useState(null as UserResponse["data"]["user"]);

	return <UserContext.Provider value={{ currentUser, setCurrentUser }}>{children}</UserContext.Provider>;
};
