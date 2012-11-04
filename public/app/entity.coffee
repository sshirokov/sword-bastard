define ['easel', 'EventEmitter'], ($e, EventEmitter) ->
    class Entity extends EventEmitter
        constructor: (x=0, y=0)->
            @p = {x: x, y: y}
            @v = {x: 0, y: 0}
            @r = 32
            @avatar = null

        ## Accessors
        position: => @p
        velocity: => @v
        radius: => @r
        width: => @radius()
        height: => @radius()