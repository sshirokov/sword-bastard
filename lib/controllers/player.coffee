express = require 'express'
uuid = require 'node-uuid'

Player = require 'models/player'
World  = require 'models/world'

module.exports.app = app = express()

app.get '/new/?', (req, res) =>
    player = new Player()
    res.json player.toJSON()