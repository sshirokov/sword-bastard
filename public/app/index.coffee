define ['jquery', 'cs!screen'], ($, Screen) ->
    console.log "Sword Bootstrap"
    canvas = $('#screen')

    window.$stage =
    stage = new Screen(canvas)


    console.log "Stage: #{stage}"
