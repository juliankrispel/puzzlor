h = require('./helper.coffee')
config = require('./config.coffee')
$ = require('./selectors.coffee')
availableFigures = require('./formations.coffee')
grid = require('./grid.coffee')

connectedTile = grid.streamConnected()

# Sort and rebase tilegroups to make them comparable
sortedTileGroup = connectedTiles.map((group)->
    tiles = _(group).chain()
        .sortBy('column')
        .sortBy('row')
        .value()
)

# Rebase so we can compare with valid formations
rebasedTileFormation = sortedTileGroup.map((group)->
    minColumn = 0
    minRow = 0
    _(group).tap((sortedTiles)->
            minColumn = _(sortedTiles).min('column').value().column
            minRow = _(sortedTiles).min('row').value().row
        ).map((tile)->
            {
                active: tile.active
                column: tile.column - minColumn
                row: tile.row - minRow
                tile: tile
            }
    ).value()
)

#Stream of figures 
validFormations = rebasedTileFormation.map((formations)->
    figureHash = _(formations)
        .map((tile)->
            [tile.column, tile.row]
        ).flatten().value().join('')
    figure = _(availableFigures).findWhere({figure: figureHash})
    if(!figure)
        false
    else
        _(formations).each((t)-> 
            t.tile.reset())
        figure
)

scoreAnimation = trx.createProperty()

score = validFormations
    .truethy()
    .extract('points')
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
