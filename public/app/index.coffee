define ['jquery', 'cs!screen', 'easel'], ($, Screen, easel) ->
    console.log "Sword Bootstrap"
    canvas = $('#screen')
    screen = new Screen(canvas)

    text = new easel.Text("Hello World", "20px Arial", "#0F0")
    text.x = 100
    text.y = 100

    screen.stage.addChild text


    console.log "Stage: #{screen.stage}"
