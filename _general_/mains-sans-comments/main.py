import json
from jsonschema import validate
from jsonschema.exceptions import ValidationError
from json_strings import *

schema = {
    "type": "object",
    "required": ["name", "winPercent"],
    "properties": {
        "name": {"type": "string"},
        "winPercent": {"type": ["number", "null"]},
    },
}


def introduce(player):
    if player["winPercent"] is not None:
        print("{:s} wins {:f}% of the time.".format(
            player["name"], player["winPercent"]))
    else:
        print("{:s} is a new player.".format(player["name"]))


try:
    player = json.loads(bad_json)

    try:
        validate(player, schema)
        introduce(player)

    except ValidationError as validation_error:
        print(validation_error)

except json.decoder.JSONDecodeError as decode_error:
    print("JSON parse error", decode_error)