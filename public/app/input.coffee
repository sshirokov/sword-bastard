define ['jquery', 'EventEmitter'], ($, EventEmitter) ->
    class Input extends EventEmitter
        CODES:
            38: "Up"
            40: "Down"
            37: "Left"
            39: "Right"

        constructor: ->
            $(document).keyup (e) => @key 'up', e
            $(document).keydown (e) => @key 'down', e

        key: (type, e) =>
            @emit "key:#{type}", e
            do (mapping = @CODES[e.which]) =>
                @emit "key:#{type}[#{mapping}]", e if mapping

        on_off: (mapping, down=(->), up=(->)) =>
            @on "key:down[#{mapping}]", down
            @on "key:up[#{mapping}]", up