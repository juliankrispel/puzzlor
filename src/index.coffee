h = require('./helper.coffee')
config = require('./config.coffee')
gameEvents = require('./gameEvents.coffee')
$ = require('./selectors.coffee')
ss = require('./scoreStrategies.coffee')
grid = require('./grid.coffee')

gameEvents.tickStream.subscribe(()-> grid.placeRandomCard(2) )

connectedTiles = grid.streamConnected()

scoreAnimation = trx.createProperty()

#ss.scoreByAmount(connectedTiles)

score = ss.scoreByAmount(connectedTiles)
    .createProperty(
        (score, points)-> 
            score + parseInt(points)
        , 0)

score.subscribe((points)->
    h.interpolateProperty(scoreAnimation, points)
)

scoreAnimation.subscribe((points)->
    $.display.textContent = points
)
