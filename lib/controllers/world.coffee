express = require 'express'

module.exports = app = express()

app.get '/blocks/:x/:y/?', (req, res) =>
    [x, y] = [req.params.x, req.params.y]
    W = H = 16
    tW = tH = 64
    res.json
        tileset:
            images: ["/img/tiles/ground1.png"],
            frames: {
                width: tW, height: tH,
                regX: tW / 2,  regY: tH / 2
            },
            default: 0,
        location: { x: x * W * tW, y: y * H * tH }
