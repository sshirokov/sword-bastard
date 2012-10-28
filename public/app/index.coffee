define ['jquery', 'easel', 'cs!screen', 'cs!game'], ($, $e, Screen, Game) ->
    console.log "Sword Bootstrap"
    $e.Ticker.removeAllListeners()
    canvas = $('#screen')
    screen = new Screen(canvas)
    game = new Game(screen)

    console.log "Loading Game"
    game.load =>
        console.log "Game loaded"