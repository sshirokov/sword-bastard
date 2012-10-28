define ['easel', 'EventEmitter'], ($e, EventEmitter) ->
    class Block extends EventEmitter
        size:
            width: 16
            height: 16

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

                label = new $e.Text("[#{@data.location.x},#{@data.location.y}](#{x},#{y})")

                block = new $e.Container()
                block.addChild bmp
                block.addChild label
                block.x = (x * @data.tileset.frames.width)
                block.y = (y * @data.tileset.frames.width)

                @blocks[x] ?= {}
                @blocks[x][y] = block

                @container.addChild block

            for y in [0..@size.height]
                for x in [0..@size.width]
                    add_block(x, y)


        ## Static utility
        @world_to_block: (x, y) ->
            [w, h] = [@prototype.size.width, @prototype.size.height]
            [NaN, NaN]

        @block_to_world: (x, y) ->
            [w, h] = [@prototype.size.width, @prototype.size.height]
            [NaN, NaN]