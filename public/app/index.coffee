define ['jquery', 'cs!screen', 'easel'], ($, Screen, easel) ->
    console.log "Sword Bootstrap"
    canvas = $('#screen')
    stage = new Screen(canvas)

    text = new easel.Text("Hello World", "20px Arial", "#0F0")
    text.x = 100
    text.y = 100

    stage.stage.addChild text

    console.log "Stage: #{stage}"
