define ['jquery', 'easel', 'cs!screen', 'cs!game'], ($, $e, Screen, Game) ->
    console.log "Sword Bootstrap"
    screen = new Screen $ '#screen'
    game = new Game screen, (g, e) =>
        throw e if e
        console.log "Game loaded"