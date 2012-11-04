define ['EventEmitter'], (EventEmitter) ->
    class Input extends EventEmitter
        CODES:
            38: "Up"
            40: "Down"
            37: "Left"
            39: "Right"

        constructor: ->
            @on "key:down", document.onkeydown if document.onkeydown
            @on "key:up", document.onkeyup if document.onkeyup

            window.onkeyup = @up
            window.onkeydown = @down

        up: (event) =>
            @emit "key:up", event
            do (mapping = @CODES[event.which]) =>
                @emit "key:up[#{mapping}]" if mapping

        down: (event) =>
            @emit "key:down", event
            do (mapping = @CODES[event.which]) =>
                @emit "key:down[#{mapping}]" if mapping