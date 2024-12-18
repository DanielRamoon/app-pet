// Tema de cores do aplicativo (IMPORTANTE: Não esquecer de quando for criar cores que dependam do tema, de criar nos dois temas, dark e light)

export default {
	// primary: "#5973fd",
	secondary: "#3a8ec2",
	active: "#f67f31",
	white: "white",
	black: "#27272a",
	danger: "#f5004a",

	//new colors
	primary: "#f65731",
	lightGreen: "#f65731",
	darkGreen: "#f65731",
	likeButton: "#6359ff",
	darkBlue: "#3c3a54",

	//Loader colors
	loaderBackColor: "#333",
	loaderForeColor: "#999",

	male: "#f67f31",
	female: "#A33FF2",
	reminderDelete: "#f5004a",
	reminderMedicineReminder: "#0388f2",

	light: {
		background: "white",
		tabBarColor: "white",
		backgroundSecondary: "#f2f2f2",
		cardColor: "#f2f2f2",
		cardColorPressed: "#d1d5db",
		cardColorSelected: "#c3c5c7",
		text: "black",
		secondaryText: "#a0a0a0",
		tertiaryText: "#ffffff",
		bottomTab: "#f2f2f2",
		loaderBackColor: "#d3d3e9",
		loaderForeColor: "#e8e7ff",
	},
	dark: {
		background: "#27272a",
		tabBarColor: "#27272a",
		backgroundSecondary: "#1e1e20",
		cardColor: "#1e1e20",
		cardColorPressed: "#2c2c2e",
		cardColorSelected: "#3a3a3c",
		text: "white",
		secondaryText: "#a0a0a0",
		tertiaryText: "#ffffff",
		bottomTab: "#1e1e20",
		loaderBackColor: "#333",
		loaderForeColor: "#999",
	},
	lightGray: "#f2f2f2",
};

export const mapThemes = {
	light: [
		{
			elementType: "labels",
			stylers: [
				{
					visibility: "on",
				},
			],
		},
		{
			featureType: "poi.business",
			stylers: [
				{
					visibility: "off",
				},
			],
		},
		{
			featureType: "poi.school",
			stylers: [
				{
					visibility: "off",
				},
			],
		},
		{
			featureType: "administrative.land_parcel",
			stylers: [
				{
					visibility: "on",
				},
			],
		},
		{
			featureType: "administrative.neighborhood",
			stylers: [
				{
					visibility: "on",
				},
			],
		},
	],
	dark: [
		{
			elementType: "labels",
			stylers: [
				{
					visibility: "on",
				},
			],
		},
		{
			featureType: "poi.business",
			stylers: [
				{
					visibility: "off",
				},
			],
		},
		{
			featureType: "poi.school",
			stylers: [
				{
					visibility: "off",
				},
			],
		},
		{
			featureType: "administrative.land_parcel",
			stylers: [
				{
					visibility: "on",
				},
			],
		},
		{
			featureType: "administrative.neighborhood",
			stylers: [
				{
					visibility: "on",
				},
			],
		},
		{
			elementType: "geometry",
			stylers: [
				{
					color: "#1d2c4d",
				},
			],
		},
		{
			elementType: "labels.text.fill",
			stylers: [
				{
					color: "#8ec3b9",
				},
			],
		},
		{
			elementType: "labels.text.stroke",
			stylers: [
				{
					color: "#1a3646",
				},
			],
		},
		{
			featureType: "administrative.country",
			elementType: "geometry.stroke",
			stylers: [
				{
					color: "#4b6878",
				},
			],
		},
		{
			featureType: "administrative.land_parcel",
			elementType: "labels.text.fill",
			stylers: [
				{
					color: "#64779e",
				},
			],
		},
		{
			featureType: "administrative.province",
			elementType: "geometry.stroke",
			stylers: [
				{
					color: "#4b6878",
				},
			],
		},
		{
			featureType: "landscape.man_made",
			elementType: "geometry.stroke",
			stylers: [
				{
					color: "#334e87",
				},
			],
		},
		{
			featureType: "landscape.natural",
			elementType: "geometry",
			stylers: [
				{
					color: "#023e58",
				},
			],
		},
		{
			featureType: "poi",
			elementType: "geometry",
			stylers: [
				{
					color: "#283d6a",
				},
			],
		},
		{
			featureType: "poi",
			elementType: "labels.text.fill",
			stylers: [
				{
					color: "#6f9ba5",
				},
			],
		},
		{
			featureType: "poi",
			elementType: "labels.text.stroke",
			stylers: [
				{
					color: "#1d2c4d",
				},
			],
		},
		{
			featureType: "poi.park",
			elementType: "geometry.fill",
			stylers: [
				{
					color: "#023e58",
				},
			],
		},
		{
			featureType: "poi.park",
			elementType: "labels.text.fill",
			stylers: [
				{
					color: "#3C7680",
				},
			],
		},
		{
			featureType: "road",
			elementType: "geometry",
			stylers: [
				{
					color: "#304a7d",
				},
			],
		},
		{
			featureType: "road",
			elementType: "labels.text.fill",
			stylers: [
				{
					color: "#98a5be",
				},
			],
		},
		{
			featureType: "road",
			elementType: "labels.text.stroke",
			stylers: [
				{
					color: "#1d2c4d",
				},
			],
		},
		{
			featureType: "road.highway",
			elementType: "geometry",
			stylers: [
				{
					color: "#2c6675",
				},
			],
		},
		{
			featureType: "road.highway",
			elementType: "geometry.stroke",
			stylers: [
				{
					color: "#255763",
				},
			],
		},
		{
			featureType: "road.highway",
			elementType: "labels.text.fill",
			stylers: [
				{
					color: "#b0d5ce",
				},
			],
		},
		{
			featureType: "road.highway",
			elementType: "labels.text.stroke",
			stylers: [
				{
					color: "#023e58",
				},
			],
		},
		{
			featureType: "transit",
			elementType: "labels.text.fill",
			stylers: [
				{
					color: "#98a5be",
				},
			],
		},
		{
			featureType: "transit",
			elementType: "labels.text.stroke",
			stylers: [
				{
					color: "#1d2c4d",
				},
			],
		},
		{
			featureType: "transit.line",
			elementType: "geometry.fill",
			stylers: [
				{
					color: "#283d6a",
				},
			],
		},
		{
			featureType: "transit.station",
			elementType: "geometry",
			stylers: [
				{
					color: "#3a4762",
				},
			],
		},
		{
			featureType: "water",
			elementType: "geometry",
			stylers: [
				{
					color: "#0e1626",
				},
			],
		},
		{
			featureType: "water",
			elementType: "labels.text.fill",
			stylers: [
				{
					color: "#4e6d70",
				},
			],
		},
	],
};
