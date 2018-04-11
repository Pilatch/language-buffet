const ajv = new require('ajv')()
const jsonStrings = require('./jsonStrings')
const schema = {
  'type': 'object',
  'required': ['name', 'winPercent'],
  'properties': {
    'name': {'type': 'string'},
    'winPercent': {'type': ['number', 'null']},
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
  const player = JSON.parse(jsonStrings.deadJson) // need to make the player before validating
  const isValid = ajv.validate(schema, player)

  if (isValid) {
    introduce(player)
  } else {
    console.error(ajv.errorsText())
  }
} catch (error) {
  console.error(`Error parsing player JSON: ${error}`)
}

// In other languages we might instead see something like this:
//
//   let isValid = jsonStrings.radJson |> JSON.parse |> ajv.validate(schema)
//
// Eventually this could be doable in JavaScript, but it gets ugly when dealing with
// functions that accept multiple parameters because calling a function in JavaScript
// will result in that function being fully executed rather than currying.
// https://github.com/tc39/proposal-pipeline-operator#functions-with-multiple-arguments
//
// One of the most interesting things about JavaScript is prototypal inheritance,
// but we're not going to get into that here because it's not apparent in our implementation.
