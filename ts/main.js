var ajv = new require('ajv')(); // Why is this difficult to add a type annotation to?
var jsonStrings = require('./jsonStrings');
function introduce(player) {
    if (player.winPercent) {
        console.log(player.name + " wins " + player.winPercent + "% of the time.");
    }
    else {
        console.log(player.name + " is a new player.");
    }
}
try {
    var playerSchema = {
        'type': 'object',
        'required': ['name', 'winPercent'],
        'properties': {
            'name': { 'type': 'string' },
            'winPercent': { 'type': ['number', 'null'] }
        }
    };
    var player = JSON.parse(jsonStrings.goodJson); // We claim this returns a Player, but there is no guarantee.
    var isValid = ajv.validate(playerSchema, player);
    if (isValid) {
        introduce(player);
        delete player.name; // Why am I allowed to do this?
        introduce(player);
    }
    else {
        console.error(ajv.errorsText());
    }
}
catch (error) {
    console.error("Here's what went wrong. " + error);
}
// The TypeScript compiler won't tell us about an unhandled exception.
