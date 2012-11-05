define ['cs!entity'], (Entity) =>
    class Player extends Entity
        constructor: (@data) ->
            {id: @id, pos: @pos} = @data