express = require('express')

module.exports = app = express()

app.get '/?', (req, res) =>
    res.json version: "0.0.0"
