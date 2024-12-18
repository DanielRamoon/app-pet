export interface IPushNotification {
	request: Request;
	date: number;
}

export interface Request {
	trigger: Trigger;
	content: Content;
	identifier: string;
}

export interface Trigger {
	remoteMessage: RemoteMessage;
	channelId: string;
	type: string;
}

export interface RemoteMessage {
	originalPriority: number;
	sentTime: number;
	notification: any;
	data: Data;
	to: any;
	ttl: number;
	collapseKey: any;
	messageType: any;
	priority: number;
	from: string;
	messageId: string;
}

export interface Data {
	channelId: string;
	message: string;
	title: string;
	body: string;
	scopeKey: string;
	experienceId: string;
	projectId: string;
}

export interface Content {
	title: string;
	badge: any;
	autoDismiss: boolean;
	data: Data2;
	body: string;
	sound: string;
	sticky: boolean;
	subtitle: any;
}

export interface Data2 {}
