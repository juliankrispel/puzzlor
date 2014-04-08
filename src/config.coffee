$ = require('./selectors.coffee')
columns = 10
rows = 10
boardSize = .6
dealerSize = .1

module.exports = {
    columns: columns 
    rows: columns
    background: 'white'
    context: $.canvas.getContext('2d')
    canvasWidth: $.canvas.width
    canvasHeight: $.canvas.height
    tileHeight: ($.canvas.height / rows) * boardSize
    tileWidth: ($.canvas.width / columns) * boardSize
    dealerWidth: $.canvas.height * dealerSize
    dealerHeight: $.canvas.width * dealerSize
}


