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
  const playerSchema = { // The ajv typings don't provide an interface for our schema.
    'type': 'object',
    'required': ['name', 'winPercent'],
    'properties': {
        'name': {'type': 'string'},
        'winPercent': {'type': ['number', 'null']},
    },
  }
  const player: Player = JSON.parse(jsonStrings.goodJson) // We claim this returns a Player, but TypeScript provides no guarantee.
  const isValid: boolean = ajv.validate(playerSchema, player) // Here's the guarantee, but that's tied to the playerSchema, not the Player interface.

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

// TypeScript's configuration seems daunting, but I don't think it really is.
// The annoying part is the typings files, and how that all works. Will have to look into that more.
// Immediately TypeScript seems awesome for the majority of our use cases.
// However when it comes adding confidence around external data, it does nothing, or worse.
// In our case the `: Player` annotation is providing some value by not allowing us to access
// members of the `player` object that are not in the Player interface.
// However, it's really the `playerSchema` that doing the heavy lifting here,
// and that is defined parallel to the Player interface. I don't know how to have one help declare the other.
// And you have to declare what's effectively the same thing twice to get both runtime and compile time checks.
