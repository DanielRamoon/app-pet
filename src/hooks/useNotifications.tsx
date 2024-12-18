import { UserResponse } from "@supabase/supabase-js";
import followService from "@utils/supabase/services/follow.service";
import { ReactNode, createContext, useContext, useEffect, useState } from "react";
import { Alert } from "react-native";

interface INotifications {
	follows: number;
}

const NotificationsContext = createContext(
	{} as {
		currentNotifications: INotifications | null;
		setCurrentNotifications: (newNotification: INotifications | null) => void;
	}
);

// Hook global para manusear o tema da aplicação
export default () => {
	// Verifica se o contexto está sendo usado dentro de um provider
	// Pense contexto como um estado global, mas que só pode ser acessado dentro de um provider (Componente)
	const context = useContext(NotificationsContext);
	if (!context) {
		throw new Error("useNotificationState must be used within a NotificationProvider");
	}

	useEffect(() => {
		getNotificationsAsync();
	}, []);

	const getNotificationsSync = () => {
		return context.currentNotifications;
	};

	const getNotificationsAsync = async () => {
		const { data, messages } = await followService.getRequestedFollowsQty();

		if (typeof data !== "number" && !data) Alert.alert("NOTIFICATIONS", messages?.join(" "));

		context.setCurrentNotifications({ ...context.currentNotifications, follows: data as number });

		return { ...context.currentNotifications, follows: data as number };
	};

	return { getNotificationsSync, getNotificationsAsync, notifications: context.currentNotifications };
};

// Provider para o hook useNotifications (Componente)
export const NotificationsProvider = ({ children }: { children: ReactNode }) => {
	const [currentNotifications, setCurrentNotifications] = useState(null as INotifications | null);

	return (
		<NotificationsContext.Provider value={{ currentNotifications, setCurrentNotifications }}>
			{children}
		</NotificationsContext.Provider>
	);
};
