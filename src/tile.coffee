_ = require('lodash')
c = require('./config.coffee')

class Tile
    constructor: (@w = 10, @h = 10, @x = 0, @y = 0, @row, @column, @_grid) ->
        @vacant = true
        @tile = null
        @timer = 0
        @drawFrame()

    drawFrame: () ->
        c.context.strokeStyle = '#cccccc'
        c.context.strokeRect(@x,@y,@w,@h)

    draw: () -> 
        if(@card)
            @card.render(c.context, @x, @y, @w, @h)
        @

    reset: () =>
        c.context.fillStyle = 'white'
        c.context.fillRect(@x,@y,@w,@h)
        c.context.fillStyle = 'black'
        @drawFrame()
        @vacant = true
        @

    highlight: (delay) =>
        clearTimeout(@timer)
        c.context.fillStyle = 'red'
        self = @
        @draw()
        @timer = setTimeout(()->
            c.context.fillStyle = 'black'
            self.draw()
        , 100)

    containsPoint: (x, y) ->
        @x <= x <= (@x + @w) && @y <= y <= (@y+@h)

    neighbours: () =>
        [
            @_grid.getTile(@row-1,@column)
            @_grid.getTile(@row+1,@column)
            @_grid.getTile(@row,@column-1)
            @_grid.getTile(@row,@column+1)
        ]

    getConnected: (connected) =>
        return undefined if @vacant
        unless connected
            connected = [@]
        else if connected.length > 0
            connected.push @

        card = @card
        batch = []
        neighbours = @neighbours()

        # get all matching neighbours
        for n in neighbours
            if n && n.card && card.equals(n.card) && !_(connected).contains(n)
                connected.push(n)
                batch.push(n)

        # get the neighbours of your neighbours recursively
        for t in batch
            connected = _(connected).union(t.getConnected(connected))
        _(connected).union().value()

    place: (card) ->
        @vacant = false
        @card = card
        @draw()
        @

module.exports = Tile
