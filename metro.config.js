const { getDefaultConfig } = require("expo/metro-config");
const defaultSourceExts = require("metro-config/src/defaults/defaults").sourceExts;
const sourceExts = ["jsx", "js", "ts", "tsx", "json", "svg", "d.ts", "mjs"].concat(defaultSourceExts);

module.exports = (() => {
	const config = getDefaultConfig(__dirname);

	const { transformer, resolver } = config;

	config.transformer = {
		...transformer,
		babelTransformerPath: require.resolve("react-native-svg-transformer"),
	};
	config.resolver = {
		...resolver,
		assetExts: resolver.assetExts.filter((ext) => ext !== "svg"),
		sourceExts: [...resolver.sourceExts, "svg", ...sourceExts],
	};

	return config;
})();
