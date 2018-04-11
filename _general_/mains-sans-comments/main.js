const jsonStrings = require('./jsonStrings')
const ajv = new require('ajv')()
const schema = {
  type: 'object',
  required: ['name', 'winPercent'],
  properties: {
    name: {type: 'string'},
    winPercent: {type: ['number', 'null']},
  },
}

function introduce(player) {
  if (player.winPercent !== null) {
    console.log(`${player.name} wins ${player.winPercent}% of the time.`)
  } else {
    console.log(`${player.name} is a new player.`)
  }
}

try {
  const player = JSON.parse(jsonStrings.radJson)
  const isValid = ajv.validate(schema, player)

  if (isValid) {
    introduce(player)
  } else {
    console.error(ajv.errorsText())
  }
} catch (error) {
  console.error(`Error parsing player JSON: ${error}`)
}