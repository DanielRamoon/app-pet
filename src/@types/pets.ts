export type ILineProps = { latitude: number; longitude: number; timestamp: string };

export type IWalkedPath = ILineProps;

export interface IWalkedDuration {
	km: number;
	humanDistance: number;
	animalDistance: number;
}

export interface petProps {
	name: string;
	id: string;
}