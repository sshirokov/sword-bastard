uuid = require 'node-uuid'

class Player
    module.exports = @

    constructor: (@id=uuid.v1()) ->
        @pos = {x: 0, y: 0}
        @dir = {x: 0, y: 1}
        console.log "Player: #{id} constructor"

    toJSON: () =>
        id: @id
        pos: @pos
        dir: @dir
