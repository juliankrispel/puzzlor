tickStream = trx.createStream()
gameEvents = {
    tickStream: tickStream
    tick: () =>
        tickStream.publish()
}
module.exports = gameEvents
