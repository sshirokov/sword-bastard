define ['jquery', 'easel', 'EventEmitter', 'cs!block', 'cs!input', 'cs!entity'], ($, $e, EventEmitter, Block, Input, Entity) ->
    class Game extends EventEmitter
        constructor: (@screen) ->
            #setInterval (=> console.log "FPS: #{1000 / window.elapsed }"), 3000

            window.$game = @
            $e.Ticker.addListener @

            @blocks = {}
            @entities = [
                new Entity("player", 0, 0)
                new Entity("square", 200, 200)
            ]

            @camera = {x: 0, y: 0, vx: 0, vy: 0}
            @input = new Input()

            setInterval (=>
                $(".camera.x").text @camera.x
                $(".camera.y").text @camera.y
                $(".fps").text Math.round 1000 / window.elapsed
            ), 500

            $e.Ticker.addListener (=>
                @camera.x += @camera.vx
                @camera.y += @camera.vy
            )

            @input.on_off "Up",
                (=> @camera.vy = 1),
                (=> @camera.vy = 0)
            @input.on_off "Down",
                (=> @camera.vy = -1),
                (=> @camera.vy = 0)
            @input.on_off "Right",
                (=> @camera.vx = 1),
                (=> @camera.vx = 0)
            @input.on_off "Left",
                (=> @camera.vx = -1),
                (=> @camera.vx = 0)


            @once "ready", =>
                @screen.stage.addChildAt (e.avatar for e in @entities)..., 1

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
                    @screen.stage.setChildIndex b.container, 0
                    @ready()
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
                        block.container.x = -@camera.x
                        block.container.y = @camera.y # Draw Y is inverted
