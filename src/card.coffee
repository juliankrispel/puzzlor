_ = require('lodash')
config = require('./config.coffee')

cards = [
    {
        name: 'Green Card'
        color: 'green'
    }
    {
        name: 'Red Card'
        color: 'red'
    }
    {
        name: 'Blue Card'
        color: 'blue'
    }
    {
        name: 'Yello Card'
        color: 'yellow'
    }

]


class Card
    constructor: (type)->
        unless type
            type = cards[_.random(3)]
        else
            type = _(cards).findWhere({name: type})
        _(@).extend(type)

    equals: (card) =>
        @name == card.name

    render: (context, x, y, w, h)->
        context.fillStyle = @color
        context.fillRect(x,y,w,h) 
        context.fillStyle = config.background

    clone: () =>
        new Card(@name)

module.exports = Card
