define ['jquery', 'easel', 'EventEmitter', 'block'], ($, $e, EventEmitter, Block) ->
    class Game extends EventEmitter
        constructor: (@screen) ->
            $e.Ticker.addListener @
            @blocks = {}
            @player = {x: 0, y: 0}

        ready: () =>
            @emit "ready", @

        load: (cb) ->
            @once "ready", cb if cb

            # TODO: Compute block index from position
            block = {x: 0, y: 0}
            block_url = "/world/blocks/#{block.x}/#{block.y}/index.json"
            console.log "Loading block URL: #{block_url}"

            $.getJSON block_url, (data) =>
                console.log "Loaded block:", data
                new Block data, (b) =>
                    @blocks[block.x] ?= {}
                    @blocks[block.x][block.y] = b
                    @screen.stage.addChild b.container
            .error =>
                console.log "Failed to fetch block."

        tick: () =>