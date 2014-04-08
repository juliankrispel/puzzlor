$ = require('./selectors.coffee')
t = {
    mouseToScreen: (xmouse, ymouse) ->
        box = $.canvas.getClientRects()[0]
        [
            xmouse - box.left
            ymouse - box.top
        ]

    interpolateProperty: (prop, to, interval = 10) ->
        factor = +1
        factor = -1 if(prop.value() > to)

        setTimeout(()->
            if(prop.value()!=to)
                prop.value(prop.value()+factor)
                t.interpolateProperty(prop, to, interval)
        , interval)

    highlightTileGroup: (tiles) ->
        for t, i in tiles
            do (t, i) ->
                setTimeout(()->
                    t.highlight()
                , i * 50)
        undefined

}

module.exports = t
