import json
from jsonschema import validate
from jsonschema.exceptions import ValidationError
from jsonStrings import goodJson, gladJson, sadJson, badJson


def introduce(player):
    if player["winPercent"]:
        print("{:s} wins {:f}% of the time.".format(
            player["name"], player["winPercent"]))
    else:
        print("{:s} is a new player.".format(player["name"]))


playerSchema = {
    "type": "object",
    "required": ["name", "winPercent"],
    "properties": {
        "name": {"type": "string"},
        "winPercent": {"type": ["number", "null"]},
    },
}

try:
    loadedPlayer = json.loads(goodJson)

    try:
        validate(loadedPlayer, playerSchema)
        introduce(loadedPlayer)

    except ValidationError as validationError:
        print(validationError)

except json.decoder.JSONDecodeError as decodeError:
    print(decodeError)
