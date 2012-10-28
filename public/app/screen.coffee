define ['jquery', 'easel'], ($, easel) ->
    class Screen extends easel.Stage
        BASE_RES: [1024, 576]

        constructor: (@dom_canvas, @fps = 30) ->
            console.log "Loading canvas: #{@dom_canvas}"
            super @dom_canvas
            console.log "Loading canvas: #{@dom_canvas}"


            console.log "Starting 30FPS Ticker on the stage."
            easel.Ticker.removeAllListeners()
            easel.Ticker.useRAF = true
            easel.Ticker.setFPS @fps
            easel.Ticker.addListener @

            console.log "Resizing and binding resize to canvas"
            $(window).resize @resize.bind @
            @resize()

        resize: () ->
            aspect = @BASE_RES[0] / @BASE_RES[1]
            @dom_canvas.width @BASE_RES[0] ## XXX: Locking scaling until later
            width = @dom_canvas.width()
            @dom_canvas.height (width / aspect)
            console.log "W: #{@dom_canvas.width()}, H: #{@dom_canvas.height()}: AR[e]: #{aspect} AR[a]: #{@dom_canvas.width() / @dom_canvas.height()}"
            @update()