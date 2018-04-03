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

// In other languages we might instead see something like this:
//
//   let isValid = jsonStrings.radJson |> JSON.parse |> ajv.validate(playerSchema)
//
// Eventually this could be doable in JavaScript, but it gets ugly when dealing with
// functions that accept multiple parameters because calling a function in JavaScript
// will result in that function being fully executed rather than currying.
// https://github.com/tc39/proposal-pipeline-operator#functions-with-multiple-arguments

