const express = require('express');
const app = express();
const path = require('path');
const fs = require('fs');
const webpack = require('webpack');
const webpackConfig = require('./webpack.config');
const compiler = webpack(webpackConfig);

// webpack hmr
app.use(require('webpack-hot-middleware')(compiler));

// static assets
app.use(
    require('webpack-dev-middleware')(compiler, {
        noInfo: true,
        publicPath: webpackConfig.output.publicPath,
        stats: false
    })
);

// main route
app.get('/', (req, res) =>
    res.sendFile(path.resolve(__dirname, './index.html'))
);

app.get('/docList', (req, res) => {
    fs.readdir('./posts', function (err, filesnames) {
        if (err) {
            throw new Error('No file is found! ', err);
        }
        res.send(filesnames);
    })
});

app.get('/file', (req, res) => {
    const filename = req.query.name
    fs.readFile('./posts/' + filename, 'utf8', function (err, content) {
        if (err) {
            throw new Error('Fail to read file: ', filename, 'Error: ', err);
        }

        res.send(JSON.stringify({ name: filename, content: content }));
    })
});

app.listen(9000, () => {
    console.log('Listening on port 9000');
});