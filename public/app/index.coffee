define ['jquery', 'cs!screen', 'cs!block', 'cs!game', 'easel'], ($, Screen, Block, Game, easel) ->
    console.log "Sword Bootstrap"
    canvas = $('#screen')
    screen = new Screen(canvas)
    game = new Game(screen)

    console.log "Loading Game"
    game.load =>
        console.log "Game loaded"

    # console.log "Loading data"
    # block = new Block("/img/tiles/ground1.png")
    # block.load =>
    #     console.log "Block is ready"
    #     screen.stage.addChild block.container
