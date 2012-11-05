define ['jquery', 'easel', 'EventEmitter', 'cs!block', 'cs!input', 'cs!entity', 'cs!player'], ($, $e, EventEmitter, Block, Input, Entity, Player) ->
    class Game extends EventEmitter
        constructor: (@screen, cb=(game, error)=>) ->
            ## Slots
            @blocks = {}
            @entities = []
            @camera = {x: 0, y: 0, vx: 0, vy: 0}

            ## Store the game globally
            window.$game = @
            $e.Ticker.addListener @

            # Handler binds for inital load/fail
            do (on_error = (e) => cb(@, e)) =>
                @once "error", on_error
                @once "ready:blocks", =>
                    @removeListener "error", on_error
                    cb @

            # Handle block streaming and signal when all
            # requested blocks are ready
            @on "ready:block", (b) =>
                complete = true
                for own x of @blocks
                    for own y of @blocks[x]
                        do (block = @blocks[x][y]) => complete &= block.complete
                @emit "ready:blocks" if complete

            ## Init
            @init_player()
            @init_stats()

        ## Subinits
        init_player: () =>
            ## Fetch a new player
            $.getJSON '/player/new/', (data) =>
                console.log "Initial data:", data
                @player = new Player data
                cluster = Block.block_cluster  @player.pos.x, @player.pos.y
                for row in cluster
                    for block in row
                        @add_block block if block
            .error (xhr, txt, e) => cb(@, e)

        init_stats: () =>
            setInterval (=>
                $(".camera.x").text @camera.x
                $(".camera.y").text @camera.y

                [x, y] = Block.world_to_block @camera.x, @camera.y
                $(".block.x").text x
                $(".block.y").text y

                $(".fps").text Math.round 1000 / window.elapsed
            ), 500

        ## Runtime API
        add_block: (block) =>
            console.log "Adding block:", block
            @blocks[block.x] ?= {}
            @blocks[block.x][block.y] = block
            block.once "ready", () =>
                @screen.stage.addChildAt block.container, 0
                @emit "ready:block", block
            block.on "error", (e) =>
                @emit "error", e

        ## Clock
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
                        return unless block.complete
                        block.container.x = block.data.location.x - @camera.x
                        block.container.y = block.data.location.y - @camera.y
                        block.container.y *= -1
