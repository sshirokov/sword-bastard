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

            window.onkeyup = (e) => @key 'up', e
            window.onkeydown = (e) => @key 'down', e

        key: (type, e) =>
            @emit "key:#{type}", e
            do (mapping = @CODES[e.which]) =>
                @emit "key:#{type}[#{mapping}]" if mapping