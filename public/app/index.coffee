define ['jquery', 'cs!screen', 'cs!block', 'cs!game', 'easel'], ($, Screen, Block, Game, easel) ->
    console.log "Sword Bootstrap"
    canvas = $('#screen')
    screen = new Screen(canvas)
    game = new Game(screen)

    console.log "Loading Game"
    game.load =>
        console.log "Game loaded"