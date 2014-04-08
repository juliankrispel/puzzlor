gameEvents = require('./gameEvents.coffee')
config = require('./config.coffee')
Card = require('./card.coffee')

class Dealer
    constructor: () -> @deal()
    deal: ()->
        current = @currentCard
        @currentCard = new Card()
        @display()
        gameEvents.tick()
        current if current
    display: () ->
        x = config.canvasWidth - config.dealerWidth
        @currentCard.render(config.context, x, 30, config.dealerWidth, config.dealerHeight)

module.exports = new Dealer
