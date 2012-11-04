define ['easel', 'EventEmitter'], ($e, EventEmitter) ->
    class Block extends EventEmitter
        size:
            width: 16
            height: 16

        container: null
        tiles: {}

        constructor: (data, cb) ->
            @container = new $e.Container()
            @tiles = {}

            @load data, cb if data

        ready: () =>
            @init_children()
            @emit "ready", @

        load: (@data, cb) ->
            @once "ready", cb if cb

            @container.regX = (@size.width * @data.tileset.frames.width) / 2
            @container.regY = (@size.height * @data.tileset.frames.height) / 2

            @tileset = new $e.SpriteSheet @data.tileset

            unless @tileset.complete
                @tileset.onComplete = @ready
            else
                @ready()

        init_children: () =>
            add_tile = (x, y) =>
                frame = @tileset.getFrame 0
                bmp = new $e.Bitmap frame.image
                bmp.sourceRect = frame.rect

                label = new $e.Text("[#{@data.location.x},#{@data.location.y}](#{x},#{y})")

                tile = new $e.Container()
                tile.addChild bmp
                tile.addChild label
                tile.x = (x * @data.tileset.frames.width)
                tile.y = (y * @data.tileset.frames.width)

                @tiles[x] ?= {}
                @tiles[x][y] = tile

                @container.addChild tile

            for y in [0..@size.height]
                for x in [0..@size.width]
                    add_tile x, y


        ## Static utility
        @world_to_block: (x, y) ->
            [w, h] = [@prototype.size.width, @prototype.size.height]
            [NaN, NaN]

        @block_to_world: (x, y) ->
            [w, h] = [@prototype.size.width, @prototype.size.height]
            [NaN, NaN]