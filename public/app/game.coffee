define ['jquery', 'easel', 'EventEmitter', 'cs!block'], ($, $e, EventEmitter, Block) ->
    class Game extends EventEmitter
        constructor: (@screen) ->
            $e.Ticker.addListener @
            @blocks = {}
            @player = {x: 0, y: 0, avatar: null}
            @camera = {x: 0, y: 0}

            @key_codes =
                38: "Up"
                40: "Down"
                37: "Left"
                39: "Right"

            document.onkeyup = @key_up
            document.onkeydown = @key_down

        key_up: (event) =>
            console.log "Key up:", (@key_codes[event.which] or event.which)

        key_down: (event) =>
            console.log "Key down:", (@key_codes[event.which] or event.which)

        ready: () =>
            @emit "ready", @

        load: (cb) ->
            @once "ready", cb if cb

            @init_player()

            # TODO: Compute block index from position
            block = {x: 0, y: 0}
            block_url = "/world/blocks/#{block.x}/#{block.y}/index.json"
            console.log "Loading block URL: #{block_url}"

            $.getJSON block_url, (data) =>
                console.log "Loaded block:", data
                new Block data, (b) =>
                    @blocks[block.x] ?= {}
                    @blocks[block.x][block.y] = b
                    @screen.stage.addChildAt b.container, @screen.stage.getChildIndex(@player.avatar)
            .error =>
                console.log "Failed to fetch block."

            @ready()

        init_player: () =>
            g = new $e.Graphics()
            g.beginStroke("#F00")
             .beginFill("#0F0")
             .drawRect(@player.x, -@player.y, 32, 32)

            @player.avatar = new $e.Shape(g)
            @player.avatar.regX = @player.avatar.regY = 16

            @screen.stage.addChild @player.avatar

        tick: (elapsed, paused) =>
            window.elapsed = elapsed

            # Center the screen on the camera
            @screen.stage.x = @camera.x
            @screen.stage.y = -@camera.y
