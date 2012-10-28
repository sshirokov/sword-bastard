define ['jquery', 'easel'], ($, $e) ->
    class Screen
        size: {width: 1024, height: 576}

        constructor: (@canvas, @fps = 30) ->
            @resize()
            @stage = new $e.Stage(@canvas.get(0))

            console.log "Starting #{fps}FPS Ticker"
            $e.Ticker.useRAF = true
            $e.Ticker.setFPS @fps
            $e.Ticker.addListener @

            console.log "Resizing and binding resize to canvas"
            $(window).resize @resize.bind @


        tick: (dt, paused) =>
            @stage.tick()
            @stage.update()

        resize: () ->
            # Lock the canvas to a fixed resolution and aspect
            aspect = @size.width / @size.height
            width = @canvas.get(0).width = @size.width
            height = @canvas.get(0).height = (width / aspect)

            @stage?.update()