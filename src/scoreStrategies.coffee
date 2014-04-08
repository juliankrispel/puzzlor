availableFigures = require('./formations.coffee')

# All scoreStrategies take a group of tiles,
# evaluate them and return a score (inside a stream)

module.exports = {
    scoreByFormation: (tileGroup)->
        # Sort and rebase so we can compare with formation strings
        tileGroup.map((group)->
            tiles = _(group).chain()
                .sortBy('column')
                .sortBy('row')
                .value()
        ).map((group)->
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
        ).map((formations)->
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
        ).truethy()
        .extract('points')

    scoreByAmount: (tileGroup)->
        tileGroup.map((group)->
            console.log group.length
            if(group.length < 5)
                false
            else
                for t in group
                    t.reset()
                group.length * (group.length / 5)
        ).truethy()

}
