define ['jquery', 'easel'], ($, easel) ->
    class Screen
        BASE_RES: [1024, 576]

        constructor: (@canvas, @fps = 30) ->
            @stage = new easel.Stage(@canvas.get(0))

            console.log "Starting 30FPS Ticker"
            easel.Ticker.removeAllListeners()
            easel.Ticker.useRAF = true
            easel.Ticker.setFPS @fps
            easel.Ticker.addListener @


            console.log "Resizing and binding resize to canvas"
            $(window).resize @resize.bind @
            @resize()

        tick: (dt, paused) =>
            @stage.tick()
            @stage.update()

        resize: () ->
            aspect = @BASE_RES[0] / @BASE_RES[1]
            @canvas.width @BASE_RES[0] ## XXX: Locking scaling until later
            width = @canvas.width()
            @canvas.height (width / aspect)
            console.log "W: #{@canvas.width()}, H: #{@canvas.height()}: AR[e]: #{aspect} AR[a]: #{@canvas.width() / @canvas.height()}"
            @stage.update()