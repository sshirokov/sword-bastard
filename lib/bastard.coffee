fs = require 'fs'
coffee  = require 'coffee-script'
express = require 'express'
io      = require 'socket.io'

class Bastard
    module.exports = @

    # Slots
    static_root: "#{process.cwd()}/public/"

    # Init
    constructor: () ->
        console.log "#{@constructor.name} Init"
        @app = express()
        @server = require('http').createServer @app
        @io = io.listen @server

        # App config
        @app.use express.logger()
        @app.use express.favicon()
        @app.use express.query()

        # Static host
        @app.use express.static @static_root

        # Routes
        controllers = "#{__dirname}/controllers/"
        console.log "Loading: #{controllers}/*"
        fs.readdir controllers, (err, files) =>
            return if err
            for file in files
                do (file) =>
                    controller = require "./controllers/#{file}"
                    name = /(.+)\.(.+)$/.exec(file)[1]
                    @app.use "/#{name}/", controller.app      if controller.app
                    controller.io @io.of "/#{name}/socket.io" if controller.io

    # Control
    start: (@options = {port: 5000}) =>
        console.warn "#{@constructor.name} Starting on port #{@options.port}"
        @server.listen @options.port

    stop: () =>
        console.warn "#{@constructor.name} Stopping"
        @server?.close()
        @server = undefined