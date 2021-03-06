_ = require('lodash')
Card = require('./card.coffee')
dealer = require('./dealer.coffee')
gameEvents = require('./gameEvents.coffee')

Tile = require('./tile.coffee')
h = require('./helper.coffee')
$ = require('./selectors.coffee')
config = require('./config.coffee')
class Grid
    constructor: () ->
        grid = @_grid = []
        self = @
        for row in [0..config.rows-1]
            y = row * config.tileHeight
            for column in [0..config.columns-1]
                x = column * config.tileWidth
                grid.push(new Tile(config.tileWidth, config.tileHeight, x, y, row, column, self))
        for x in [0...9]
            @placeRandomCard()
    getTile: (row, column) =>
        @_grid[column + row*config.columns]

    _getAvailableTiles: ()->
        _(@_grid).filter((t)-> t.vacant == true).value()

    placeRandomCard: ()->
        availableTiles = @_getAvailableTiles()
        randomIndex = _.random(availableTiles.length-1)
        availableTiles[randomIndex].place(new Card)

    streamConnected: () ->
        canvasClick = trx.fromDomEvent('click', $.canvas)
        self = @
        canvasClick.map((e)->
            result = false
            for tile in self._grid
                result = tile if (tile.containsPoint.apply(tile, h.mouseToScreen(e.x,e.y)))
            result
        ).truethy().map((tile)->
            tile.place(dealer.deal())
            connected = tile.getConnected()
        )

module.exports = new Grid
