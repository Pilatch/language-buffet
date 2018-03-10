const ajv = new require('ajv')()
const jsonStrings = require('./jsonStrings')

function introduce(player) {
  if (player.winPercent) {
    console.log(`${player.name} wins ${player.winPercent}% of the time.`)
  } else {
    console.log(`${player.name} is a new player.`)
  }
}

try {
  const playerSchema = {
      'type': 'object',
      'required': ['name', 'winPercent'],
      'properties': {
          'name': {'type': 'string'},
          'winPercent': {'type': ['number', 'null']},
      },
  }
  const player = JSON.parse(jsonStrings.radJson) // need to make the player before validating
  const isValid = ajv.validate(playerSchema, player)

  if (isValid) {
    introduce(player)
  } else {
    console.error(ajv.errorsText())
  }
} catch (error) {
  console.error(`Here's what went wrong. ${error}`)
}
