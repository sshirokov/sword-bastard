define ['jquery', 'easel'], ($, easel) ->
    console.log "Sword Bootstrap"

    window.$stage =
    canvas = $('#screen')
    stage = new easel.Stage()

    console.log "Starting 30FPS Ticker on the stage."
    easel.Ticker.removeAllListeners()
    easel.Ticker.useRAF = true
    easel.Ticker.setFPS 30
    easel.Ticker.addListener stage

    console.log "Stage: #{stage}"

    # Bind a resize function
    (resize = ()=>
        base = [1024, 576]
        aspect = 16.0 / 9.0
        canvas.width 1024 ## XXX: Locking scaling until later
        width = canvas.width()
        canvas.height (width / aspect)
        console.log "W: #{canvas.width()}, H: #{canvas.height()}: AR[e]: #{aspect} AR[a]: #{canvas.width() / canvas.height()}")()
    $(window).resize resize
