export interface IUserAddress {
	country: string;
	state: string;
	city: string;
}

export interface IUserInfo {
	name: string;
	surname: string;
	email?: string;
	birthDate: string;
	gender: 0 | 1 | 2;
	username?: string;
}

export interface IProps {
	initialImage?: string | null;
	compact?: boolean;
	style?: any;
	disabled?: boolean;
	onImageChange: (image: string) => void;
	onImageLoaded?: () => void;
}
