define ['jquery', 'cs!entity', 'cs!input'], ($, Entity, Input) =>
    class Player extends Entity
        constructor: (cb=(->)) ->
            @id = ""
            @pos = {x: 0, y: 0}
            @dir = {x: 0, y: 1}
            @data = {}

            ## Fetch the player data
            $.getJSON '/player/new/', (data) =>
                {
                    id: @id,
                    pos: {x: @pos.x, y: @pos.y},
                    dir: {x: @dir.x, y: @dir.y}
                } = @data = data
                console.log "Loaded:", @
                @bind_keys()
                cb @
            .error (xhr, txt, e) =>
                cb @, e

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
