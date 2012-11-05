define ['jquery', 'easel', 'EventEmitter', 'cs!block', 'cs!input', 'cs!entity', 'cs!player'], ($, $e, EventEmitter, Block, Input, Entity, Player) ->
    class Game extends EventEmitter
        constructor: (@screen, cb=(game, error)=>) ->
            ## Store the game globally
            window.$game = @

            ## Slots
            @blocks = {}
            @entities = []
            @camera = {x: 0, y: 0, vx: 0, vy: 0}
            @input = new Input()

            ## Bind the ticker
            $e.Ticker.addListener @

            ## Init secondary items
            @init_stats()

            ## Fetch a new player
            $.getJSON '/player/new/', (data) =>
                @player = new Player data
                console.log "Initial data:", data
                cb @, false
            .error (xhr, txt, e) =>
                console.log "Failed inital load"
                cb @, e

        ## Init other things
        init_stats: () =>
            setInterval (=>
                $(".camera.x").text @camera.x
                $(".camera.y").text @camera.y

                [x, y] = Block.world_to_block @camera.x, @camera.y
                $(".block.x").text x
                $(".block.y").text y

                $(".fps").text Math.round 1000 / window.elapsed
            ), 500

        ## Runtime events
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
