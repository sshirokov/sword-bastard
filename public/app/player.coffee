define ['jquery', 'cs!entity', 'cs!input'], ($, Entity, Input) =>
    class Player extends Entity
        constructor: (cb=(->)) ->
            super "player"
            @id = ""

            ## Load handlers
            @once "loaded", =>
                console.log "Loaded:", @
                @connect()
            @once "connected", =>
                console.log "Connected:", @
                @bind_keys()
                cb @
            @once "load:error", (e) =>
                cb @, e

            ## Init from the server
            @load()

        load: () =>
            ## Fetch the player data
            $.getJSON '/player/new/', (@data) =>
                {
                    id: @id,
                    pos: {x: @p.x, y: @p.y},
                    dir: {x: @d.x, y: @d.y}
                } = @data
                @name = "player:#{@id}"
                @emit "loaded", @
            .error (xhr, txt, e) =>
                @emit "load:error", e

        connect: () =>
            @emit "connected", @

        bind_keys: =>
            @input ?= new Input()
            @input.on_off "Up",
                (=>
                    console.log "Up down"),
                (=>
                    console.log "Up up")
            @input.on_off "Down",
                (=>
                    console.log "Down down"),
                (=>
                    console.log "Down up")
            @input.on_off "Right",
                (=>
                    console.log "Right down"),
                (=>
                    console.log "Right up")
            @input.on_off "Left",
                (=>
                    console.log "Left down"),
                (=>
                    console.log "Left up")
