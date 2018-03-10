const ajv = new require('ajv')() // Why is this difficult to add a type annotation to?
const jsonStrings = require('./jsonStrings')

interface Player {
  name: string
  winPercent: number // All fields can be null in TS by default.
}

function introduce(player : Player) {
  if (player.winPercent) {
    console.log(`${player.name} wins ${player.winPercent}% of the time.`)
  } else {
    console.log(`${player.name} is a new player.`)
  }
}

try {
  const playerSchema = {  // The ajv typings don't provide an interface for our schema.
      'type': 'object',
      'required': ['name', 'winPercent'],
      'properties': {
          'name': {'type': 'string'},
          'winPercent': {'type': ['number', 'null']},
      },
  }
  const player: Player = JSON.parse(jsonStrings.goodJson) // We claim this returns a Player, but there is no guarantee.
  const isValid: boolean = ajv.validate(playerSchema, player)

  if (isValid) {
    introduce(player)
    delete player.name // Why am I allowed to do this?
    introduce(player)
  } else {
    console.error(ajv.errorsText())
  }
} catch (error) { // Catch clause cannot have a type annotation.
  console.error(`Here's what went wrong. ${error}`)
}

// The TypeScript compiler won't tell us about an unhandled exception.

// For some reason my compiler keeps yelling at me about errors in AJV.

