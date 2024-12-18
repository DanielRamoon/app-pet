module.exports = function (api) {
	api.cache(true);
	return {
		presets: ["babel-preset-expo"],
		plugins: [
			[
				"module-resolver",
				{
					root: ["./"],
					extensions: [".ts", ".tsx", ".jsx", ".js", ".json"],
					alias: {
						"@components": "./src/components",
						"@screens": "./src/screens",
						"@utils": "./src/utils",
						"@navigation": "./src/navigation",
						"@styles": "./src/styles",
						"@hooks": "./src/hooks",
						"@providers": "./src/providers",
						"@assets": "./assets",
						types: "./src/@types",
						"@models": "./src/utils/supabase/models",
					},
				},
			],
			"react-native-reanimated/plugin",
		],
	};
};
