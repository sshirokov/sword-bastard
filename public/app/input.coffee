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
            console.log "Up: #{@CODES[event.which]}", event

        down: (event) =>
            console.log "Down: #{@CODES[event.which]}", event