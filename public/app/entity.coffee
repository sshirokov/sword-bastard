define ['easel', 'EventEmitter'], ($e, EventEmitter) ->
    class Entity extends EventEmitter
        constructor: (x=0, y=0)->
            @p = {x: x, y: y}
            @v = {x: 0, y: 0}
            @r = 32
            @avatar = null

            g = new $e.Graphics()
            g.beginStroke("#F00")
             .beginFill("#0F0")
             .drawRect(0, 0, 32, 32)

            @avatar = new $e.Shape(g)
            @avatar.regX = @avatar.regY = 16


        ## Accessors
        position: => @p
        velocity: => @v
        radius: => @r
        width: => @radius()
        height: => @radius()