const jsonStrings = require('./jsonStrings')
const player = JSON.parse(jsonStrings.radJson)

console.log(`${player.name} wins ${player.winPercent}% of the time.`)

// This is one of the things that makes JavaScript awesome.
// I can bang out a few lines of code and get a job done extremely quickly.
// No waiting for compilers. No worrying about whether my objects fit a certain structure.
// Just run it and see what happens!
