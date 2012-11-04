define ['jquery', 'easel', 'EventEmitter', 'cs!block', 'cs!input', 'cs!entity'], ($, $e, EventEmitter, Block, Input, Entity) ->
    class Game extends EventEmitter
        constructor: (@screen) ->
            setInterval (=> console.log "FPS: #{1000 / window.elapsed }"), 3000

            window.$game = @
            $e.Ticker.addListener @

            @player = new Entity("player")
            @blocks = {}
            @entities = [
                @player,
                new Entity("square", 200, 200)
            ]

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
            @screen.stage.addChild @player.avatar

            do (speed = 64) =>
                @input.on "key:down[Up]", => @player.v.y = speed
                @input.on "key:up[Up]", => @player.v.y = 0

                @input.on "key:down[Down]", => @player.v.y = -speed
                @input.on "key:up[Down]", => @player.v.y = 0

                @input.on "key:down[Left]", => @player.v.x = -speed
                @input.on "key:up[Left]", => @player.v.x = 0

                @input.on "key:down[Right]", => @player.v.x = speed
                @input.on "key:up[Right]", => @player.v.x = 0

        tick: (elapsed, paused) =>
            window.elapsed = elapsed

            # Chase the player with the camera
            @camera.x = @player.p.x
            @camera.y = @player.p.y

            # Update entities
            for entity in @entities
                entity.avatar.x = entity.p.x - @camera.x
                entity.avatar.y = entity.p.y - @camera.y

            # Update every block
            for own x of @blocks
                for own y of @blocks[x]
                    do (block = @blocks[x][y]) =>
                        block.container.x = -@camera.x
                        block.container.y = @camera.y # Draw Y is inverted
