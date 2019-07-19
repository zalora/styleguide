'use strict';

const webpack = require('webpack');
const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const CopyPlugin = require('copy-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const OptimizeCssAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const TerserPlugin = require('terser-webpack-plugin');
const CleanWebpackPlugin = require('clean-webpack-plugin');

module.exports = (env, argv) => [{
    entry: {
        index: [
            './src/index.js'
        ]
    },
    output: {
        filename:  argv.mode === "production" ? "[name].[hash].js" : "index.js",
        publicPath: '',
    },
    module: {
        noParse: /\.elm$/,
        rules: [
            {
                test: /\.(scss|css)$/,
                use: [
                    MiniCssExtractPlugin.loader,
                    'css-loader',
                    'fast-sass-loader'
                ]
            },
            {
                test: /\.md$/,
                use: 'raw-loader'
            },
            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                use: [
                    { loader: 'elm-hot-webpack-loader' },
                    {
                        loader: 'elm-webpack-loader',
                        options: {
                            debug: argv.mode === 'production' ? false : true
                        }
                    }
                ]
            },
            {
                test: /\.(ico|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                loader: 'file-loader'
            }
        ]
    },
    plugins: [
        new CleanWebpackPlugin(),
        new HtmlWebpackPlugin(
            {
                title: "Style",
                favicon: "./assets/favicon.ico",
                meta: {viewport: 'width=device-width, initial-scale=1, shrink-to-fit=no'},
            }
        ),
        new MiniCssExtractPlugin({
            filename: argv.mode === "production" ? "[name].[contenthash].css" : "index.css",
            chunkFilename: '[id].css'
        }),
        new webpack.HotModuleReplacementPlugin(),
        new CopyPlugin([
            { from: 'pages', to: 'pages' },
            { from: 'img', to: 'img' },
            { from: 'assets', to: 'assets'},
            { from: './index.html'},
            { from: './error.html'}
          ]),
    ],
    devServer: {
        contentBase: path.join(__dirname, '/'),
        hot: true,
        inline: true,
        port: 9001,
        open: true,
    },
    optimization: {
        minimizer: [
            new TerserPlugin({
                test: /\.js(\?.*)?$/i,
                exclude: /node_modules/,
            }), 
            new OptimizeCssAssetsPlugin({
                cssProcessor: require('cssnano'),
                cssProcessorPluginOptions: {
                preset: ['default', { discardComments: { removeAll: true } }],
            },
            })
        ]
      },


}];
