define ['jquery', 'easel', 'EventEmitter', 'cs!block', 'cs!input', 'cs!entity'], ($, $e, EventEmitter, Block, Input, Entity) ->
    class Game extends EventEmitter
        constructor: (@screen) ->
            window.$game = @
            $e.Ticker.addListener @

            @blocks = {}
            @entities = [
                new Entity("player", 0, 0),
                new Entity("square", 200, 200)
            ]

            @camera = {x: 0, y: 0, vx: 0, vy: 0}
            @input = new Input()

            setInterval (=>
                $(".camera.x").text @camera.x
                $(".camera.y").text @camera.y

                [x, y] = Block.world_to_block @camera.x, @camera.y
                $(".block.x").text x
                $(".block.y").text y

                $(".fps").text Math.round 1000 / window.elapsed
            ), 500

            $e.Ticker.addListener (=>
                @camera.x += @camera.vx
                @camera.y += @camera.vy
            )

            do (speed = 10) =>
                @input.on_off "Up",
                    (=> @camera.vy = speed),
                    (=> @camera.vy = 0)
                @input.on_off "Down",
                    (=> @camera.vy = -speed),
                    (=> @camera.vy = 0)
                @input.on_off "Right",
                    (=> @camera.vx = speed),
                    (=> @camera.vx = 0)
                @input.on_off "Left",
                    (=> @camera.vx = -speed),
                    (=> @camera.vx = 0)


            @once "ready:blocks", =>
                if @entities.length
                    @screen.stage.addChild (e.avatar for e in @entities)...

        ready: () =>
            @emit "ready:blocks", @

        load: (cb) ->
            @once "ready:blocks", cb if cb
            ready = 0
            ready_block = () =>
                ready += 1
                console.log "Loaded #{ready} blocks"
                @ready() if ready == 2

            # TODO: Compute block index from position
            do (block = {x: 0, y: 0}) =>
                block_url = "/world/blocks/#{block.x}/#{block.y}/index.json"
                console.log "Loading block URL: #{block_url}"

                $.getJSON block_url, (data) =>
                    console.log "Loaded block:", data
                    new Block data, (b) =>
                        @blocks[block.x] ?= {}
                        @blocks[block.x][block.y] = b
                        @screen.stage.addChildAt b.container, 0
                        ready_block()
                .error =>
                    console.log "Failed to fetch block."

            do (block = {x: 0, y: 1}) =>
                block_url = "/world/blocks/#{block.x}/#{block.y}/index.json"
                console.log "Loading block URL: #{block_url}"

                $.getJSON block_url, (data) =>
                    console.log "Loaded block:", data
                    new Block data, (b) =>
                        @blocks[block.x] ?= {}
                        @blocks[block.x][block.y] = b
                        @screen.stage.addChildAt b.container, 0
                        ready_block()
                .error =>
                    console.log "Failed to fetch block."

        tick: (elapsed, paused) =>
            window.elapsed = elapsed

            # Update entities
            for entity in @entities
                entity.avatar.x = entity.p.x - @camera.x
                entity.avatar.y = entity.p.y + @camera.y

            # Update every block
            for own x of @blocks
                for own y of @blocks[x]
                    do (block = @blocks[x][y]) =>
                        block.container.x = block.data.location.x - @camera.x
                        block.container.y = block.data.location.y - @camera.y
                        block.container.y *= -1
