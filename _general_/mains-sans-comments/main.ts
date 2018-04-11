const ajv = new require('ajv')()
const jsonStrings = require('./jsonStrings')
const playerSchema = {
  type: 'object',
  required: ['name', 'winPercent'],
  properties: {
    name: {type: 'string'},
    winPercent: {type: ['number', 'null']},
  },
}

interface Player {
  name: string
  winPercent: number
}

function introduce(player : Player) {
  if (player.winPercent) {
    console.log(`${player.name} wins ${player.winPercent}% of the time.`)
  } else {
    console.log(`${player.name} is a new player.`)
  }
}

try {
  const player: Player = JSON.parse(jsonStrings.goodJson)
  const isValid: boolean = ajv.validate(playerSchema, player)

  if (isValid) {
    introduce(player)
  } else {
    console.error(ajv.errorsText())
  }
} catch (error) {
  console.error(`Here's what went wrong. ${error}`)
}
