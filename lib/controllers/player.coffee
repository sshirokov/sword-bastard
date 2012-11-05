express = require 'express'
uuid = require 'node-uuid'

module.exports = app = express()

app.get '/new/?', (req, res) =>
    res.json
        id: uuid.v1()
        pos: {x: 0, y: 0}
        dir: {x: 0, y: 1}