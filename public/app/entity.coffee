define ['easel', 'EventEmitter'], ($e, EventEmitter) ->
    class Entity extends EventEmitter
        constructor: ->
            [@x, @y] = [0, 0]