const path = require("path");
const UglifyJSPlugin = require("uglifyjs-webpack-plugin");
const Webpack = require("webpack");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const VueLoaderPlugin = require("vue-loader/lib/plugin");

module.exports = {
  // входная точка нашего приложения
  entry: "./src/index.js",
  output: {
    path: path.resolve(__dirname, "../backend/public"), // устанавливаем путь к сборке
    publicPath: "/public/", // устанавливаем публичный путь, по которому файл будет доступен
    filename: "js/build.js" // устанавливаем имя файла сборки
  },
  devtool: "#cheap-module-source-map",
  module: {
    rules: [
      //настройка загрузчика js файлов
      {
        test: /\.js$/,
        // запрещает просматривать эту деррикторию
        exclude: /node_modules/,
        // обработчик файлов
        loader: "babel-loader",
        query: {
          presets: ["es2015"]
        }
      },
      {
        test: /\.vue$/,
        exclude: /node_modules|.vscode|app|bootstrapp|config|database|resources|routes|storage|tre/,
        loader: "vue-loader"
      },
      {
        test: /\.(sa|sc|c)ss$/,
        exclude: /node_modules/,
        use: [MiniCssExtractPlugin.loader, "css-loader", "sass-loader"]
      },
      {
        test: /\.(png|jpg|svg|ttf|eof|woof|woff2)$/,
        exclude: /node_modules/,
        loader: "file-loader?name=[path][name].[ext]"
      }
    ]
  },
  plugins: [
    new Webpack.IgnorePlugin(/public\/fonts/),
    new UglifyJSPlugin(),
    new MiniCssExtractPlugin({
      filename: "css/[name].css",
      chunkFilename: "css/[id].css"
    }),
    new VueLoaderPlugin()
  ]
};
