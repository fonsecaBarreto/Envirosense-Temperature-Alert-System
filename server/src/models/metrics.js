function Metrics(h, t){
    return ({
        humidity: h || 0,
        temperature: t || 0,
        timestamp: new Date()
    })
}
module.exports = { Metrics }