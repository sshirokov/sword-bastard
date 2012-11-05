define ['jquery', 'easel', 'EventEmitter'], ($, $e, EventEmitter) ->
    class Block extends EventEmitter
        size:
            width: 16
            height: 16

        constructor: (@x, @y, cb=(->)) ->
            @container = new $e.Container()
            @tiles = {}
            @complete = false

            ## Bind the handlers
            @once "loaded", (data) =>
                @load data, cb
            @on "error", (e) =>
                cb null, e

            ## Do the fetch
            do (url = "/world/blocks/#{x}/#{y}/") =>
                $.getJSON url, (data) =>
                    @emit "loaded", data
                .error (xhr, txt, e) =>
                    @emit "error", e

        ready: () =>
            @init_children()
            @complete = true
            @emit "ready", @

        load: (@data, cb) ->
            console.log "Loading Block from", @data
            @once "ready", cb if cb

            @container.regX = (@size.width * @data.tileset.frames.width) / 2
            @container.regY = (@size.height * @data.tileset.frames.height) / 2

            @tileset = new $e.SpriteSheet @data.tileset

            unless @tileset.complete
                @tileset.onComplete = => @ready()
            else
                @ready()

        init_children: () =>
            add_tile = (x, y) =>
                frame = @tileset.getFrame @data.tileset.default or 0
                bmp = new $e.Bitmap frame.image
                bmp.sourceRect = frame.rect

                tile = new $e.Container()
                tile.addChild bmp
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
            [w, h] = [@prototype.size.width, @prototype.size.height].map (x) => x * 64
            [x / w, y / h].map (x) => Math.round x

        @block_cluster: (x, y) ->
            B = (x, y) => new @(x, y)
            [cx, cy] = @world_to_block x, y
            [
                [ B(cx-1, cy+1), B(cx, cy+1), B(cx+1, cy+1) ],
                [ B(cx-1, cy),   B(cx, cy),   B(cx+1, cy)   ],
                [ B(cx-1, cy-1), B(cx, cy-1), B(cx+1, cy-1) ],
            ]
