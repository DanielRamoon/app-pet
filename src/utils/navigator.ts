// Arquivo usutilário que server para criar uma referência ao navigation do react-navigation, para que possamos navegar entre telas sem precisar passar
// o navigation como parâmetro para cada componente que precisar navegar (podemos usar o navigator em lugares que não teríamos o navigator por padrão).

import { createRef } from "react";

export const navigationRef: any = createRef();

export function navigate(name: any, params?: any) {
	navigationRef.current?.navigate(name, params);
}

export function getRouter() {
	return navigationRef.current;
}

export function getRoute() {
	return navigationRef.current?.getCurrentRoute();
}

export function goBack() {
	navigationRef.current?.goBack();
}
