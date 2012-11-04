define ['jquery', 'easel', 'EventEmitter', 'cs!block', 'cs!input'], ($, $e, EventEmitter, Block, Input) ->
    class Game extends EventEmitter
        constructor: (@screen) ->
            window.$game = @
            $e.Ticker.addListener @
            @blocks = {}
            @player = {x: 0, vx: 0, vy: 0, y: 0, avatar: null}
            @camera = {x: 0, y: 0}
            @input = new Input()

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
             .drawRect(0, 0, 32, 32)

            @player.avatar = new $e.Shape(g)
            @player.avatar.regX = @player.avatar.regY = 16

            @screen.stage.addChild @player.avatar

            @input.on "key:down[Up]", => @player.vy = 1
            @input.on "key:up[Up]", => @player.vy = 0

            @input.on "key:down[Down]", => @player.vy = -1
            @input.on "key:up[Down]", => @player.vy = 0

            @input.on "key:down[Left]", => @player.vx = -1
            @input.on "key:up[Left]", => @player.vx = 0

            @input.on "key:down[Right]", => @player.vx = 1
            @input.on "key:up[Right]", => @player.vx = 0

            $e.Ticker.addListener (elapsed, paused) =>
                @player.x += @player.vx
                @player.y += @player.vy
                @player.avatar.x = @player.x
                @player.avatar.y = @player.y * -1

        tick: (elapsed, paused) =>
            window.elapsed = elapsed

            # Chase the player with the camera
            @camera.x = @player.x
            @camera.y = @player.y