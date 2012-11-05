define ['easel', 'EventEmitter'], ($e, EventEmitter) ->
    class Entity extends EventEmitter
        constructor: (@name='undefined', x=0, y=0)->
            @p = {x: x, y: y}
            @v = {x: 0, y: 0}
            @d = {x: 0, y: 1}
            @r = 32
            @avatar = null

            g = new $e.Graphics()
            g.beginStroke("#F00")
             .beginFill("#0F0")
             .drawRect(0, 0, 32, 32)

            @avatar = new $e.Shape(g)
            @avatar.regX = @avatar.regY = 16

            $e.Ticker.addListener (elapsed, paused) =>
                seconds = elapsed / 1000
                @p.x += (@v.x * seconds)
                @p.y += (@v.y * seconds)

        ## Accessors
        position: => @p
        velocity: => @v
        radius: => @r
        width: => @radius()
        height: => @radius()