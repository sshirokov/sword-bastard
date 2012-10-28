define ['easel', 'EventEmitter'], ($e, EventEmitter) ->
    class Block extends EventEmitter
        container: null
        blocks: {}

        constructor: (data, cb) ->
            @container = new $e.Container()
            @blocks = {}

            @load data, cb if data

        ready: () =>
            @init_children()
            @emit "ready", @

        load: (@data, cb) ->
            @once "ready", cb if cb
            @tileset = new $e.SpriteSheet @data.tileset

            unless @tileset.complete
                @tileset.onComplete = @ready
            else
                @ready()

        init_children: () =>
            add_block = (x, y) =>
                frame = @tileset.getFrame 0
                bmp = new $e.Bitmap frame.image
                bmp.sourceRect = frame.rect
                bmp.x = (x * @data.tileset.frames.width)
                bmp.y = (y * @data.tileset.frames.width)
                @blocks[x] ?= {}
                @blocks[x][y] = bmp
                @container.addChild bmp

            for y in [0..@data.size.height]
                for x in [0..@data.size.width]
                    add_block(x, y)