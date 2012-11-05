define ['jquery', 'easel', 'cs!screen', 'cs!game'], ($, $e, Screen, Game) ->
    console.log "Sword Bootstrap"
    screen = new Screen $ '#screen'
    game = new Game screen, (g, e) =>
        if e
            $e.Ticker.removeAllListeners()
            throw e
        console.log "Game loaded"