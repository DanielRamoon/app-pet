import i18n from "./i18n";

export default {
	0: () => i18n.get("pets.types.dog"),
	1: () => i18n.get("pets.types.cat"),
	2: () => i18n.get("pets.types.bird"),
	3: () => i18n.get("pets.types.fish"),
	4: () => i18n.get("pets.types.rodent"),
	5: () => i18n.get("pets.types.reptile"),
	6: () => i18n.get("pets.types.other"),
} as any;
