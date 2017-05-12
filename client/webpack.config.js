/* eslint comma-dangle: ["error",
{"functions": "never", "arrays": "only-multiline", "objects":
"only-multiline"} ] */

const webpack = require('webpack');
const pathLib = require('path');

const devBuild = process.env.NODE_ENV !== 'production';

const config = {
	entry: [
		'es5-shim/es5-shim',
		'es5-shim/es5-sham',
		'babel-polyfill',
		'./app/bundles/Alldid/startup/registration',
	],

	output: {
		filename: 'webpack-bundle.js',
		path: pathLib.resolve(__dirname, '../app/assets/webpack'),
	},

	resolve: {
		extensions: ['.js', '.jsx'],
	},
	plugins: [
		new webpack.EnvironmentPlugin({ NODE_ENV: 'development' }),
		new webpack.ProvidePlugin({
				$: "jquery",
				"window.jQuery": "jquery",
				"moment": "moment"
		}),
	],
	module: {
		rules: [
			{
				test: require.resolve('react'),
				use: {
					loader: 'imports-loader',
					options: {
						shim: 'es5-shim/es5-shim',
						sham: 'es5-shim/es5-sham',
					}
				},
			},
			{
				test: /\.jsx?$/,
				use: 'babel-loader',
				exclude: /node_modules/,
			},
			{
				test: /\.css$/,
				loader:'style!css!'
			}
		],
	},
};

module.exports = config;

if (devBuild) {
	console.log('Webpack dev build for Rails'); // eslint-disable-line no-console
	module.exports.devtool = 'eval-source-map';
} else {
	console.log('Webpack production build for Rails'); // eslint-disable-line no-console
}
