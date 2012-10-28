define ['jquery', 'easel'], ($, easel) ->
    console.log "Sword Bootstrap"

    window.$stage =
    stage = new easel.Stage($('#screen'))

    console.log "Starting 30FPS Ticker on the stage."
    easel.Ticker.setFPS 30
    easel.Ticker.addListener stage

    console.log "Stage: #{stage}"