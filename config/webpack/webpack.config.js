const path    = require("path")
const webpack = require("webpack")
// Extracts CSS into .css file
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
// Removes exported JavaScript files from CSS-only entries
// // in this example, entry.custom will create a corresponding empty custom.js file
const RemoveEmptyScriptsPlugin = require('webpack-remove-empty-scripts');

module.exports = {
  mode: "production",
  devtool: "source-map",
  entry: {
    application: [
      './app/javascript/application.js',
      //'./app/assets/stylesheets/application.scss',
      //'./app/assets/stylesheets/home.scss',
      //'./app/assets/stylesheets/tags.scss',
      //'./app/assets/stylesheets/scaffolds.scss',
      //'./app/assets/stylesheets/dashboard.scss',
      //'./app/assets/stylesheets/actiontext.scss',
      //'./app/assets/stylesheets/posts.scss',
      //'./app/assets/stylesheets/users.scss',
      //'./app/assets/stylesheets/comments.scss',
    ]
  },
  module: {
    rules: [
      // Add CSS/SASS/SCSS rule with loaders
      {
        test: /\.(?:sa|sc|c)ss$/i,
        use: [MiniCssExtractPlugin.loader, 'css-loader', 'sass-loader'],
      },
    ],
  },
  resolve: {
    // Add additional file types
    extensions: ['.js', '.jsx', '.scss', '.css'],
  },
  output: {
    hashFunction: "sha256",
    hashDigestLength: 64,
    filename: "[name].js",
    chunkFilename: "[name]-[contenthash].digested.js",
    //sourceMapFilename: "[file].map",
    sourceMapFilename: "[file]-[fullhash].map",
    chunkFormat: "module",
    //path: path.resolve(__dirname, "app/assets/builds"),
    path: path.resolve(__dirname, '..', '..', 'app/assets/builds'),
  },
  plugins: [
    new RemoveEmptyScriptsPlugin(),
    new MiniCssExtractPlugin(),
  ],
}


