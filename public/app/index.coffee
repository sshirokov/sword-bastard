define ['jquery', 'cs!screen', 'easel'], ($, Screen, easel) ->
    console.log "Sword Bootstrap"
    canvas = $('#screen')
    screen = new Screen(canvas)

    text = new easel.Text("Hello World", "20px Arial", "#0F0")
    text.x = 100
    text.y = 100

    screen.stage.addChild text


    console.log "Stage: #{screen.stage}"

    console.log "Loading data"

    ground1 = new easel.SpriteSheet
        images: ["/img/tiles/ground1.png"]
        frames: { width: 64, height: 64, regX: 32, regY: 32 }

    unless ground1.complete
        console.log "Tile: ground1 is not ready."
        ground1.onComplete = =>
            console.log "Tile: ground1 loaded."
    else
        console.log "Tile: tile1 was already loaded."
