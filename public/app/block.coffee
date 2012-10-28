define ['easel', 'EventEmitter'], ($e, EventEmitter) ->
    class Block extends EventEmitter
        ## The size of the level in tiles
        size:
            width: 16
            height: 16

        ## Display list and entities
        container: null
        ## @blocks[x][y] = <DisplayObject> || undefined
        blocks: {}

        ## Assets
        tiles: []
        tileset: null
        frames: {
            width: 64, height: 64,
            regX: 32, regY: 32
        }

        constructor: (@tiles) ->
            @container = new $e.Container()
            @blocks = {}
            @tiles = [@tiles] unless @tiles instanceof Array

        ready: () =>
            @init_children()
            @emit "ready", @

        load: (cb) ->
            @once "ready", cb if cb
            @tileset = new $e.SpriteSheet
                images: @tiles
                frames: @frames
            unless @tileset.complete
                @tileset.onComplete = @ready
            else
                @ready()

        init_children: () =>
            add_block = (x, y) =>
                console.log "Adding block (#{x}, #{y}) =>", bmp
                frame = @tileset.getFrame 0
                bmp = new $e.Bitmap frame.image
                bmp.sourceRect = frame.rect
                bmp.x = (x * @frames.width)
                bmp.y = (y * @frames.width)
                @blocks[x] ?= {}
                @blocks[x][y] = bmp
                @container.addChild bmp

            for y in [0..@size.height]
                for x in [0..@size.width]
                    add_block(x, y)