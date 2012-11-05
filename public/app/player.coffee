define ['cs!entity', 'cs!input'], (Entity, Input) =>
    class Player extends Entity
        constructor: (@data) ->
            {id: @id, pos: @pos} = @data
            @bind_keys()

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
