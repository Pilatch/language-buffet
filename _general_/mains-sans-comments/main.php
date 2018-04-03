<?
require 'vendor/autoload.php';
include_once 'json_strings.php';
use JsonSchema\Validator;

$playerSchema = <<<'JSON'
{
  "type": "object",
  "properties": {
    "winPercent": {
      "type": [
        "number",
        "null"
      ]
    },
    "name": {
      "type": "string"
    }
  }
}
JSON;

$schemaObject = json_decode($playerSchema);
$validator = new Validator();
$player = json_decode($gladJson);
$validator->validate($player, $schemaObject);

if ($validator->isValid()) {
  if ($player->winPercent) {
    echo "$player->name wins $player->winPercent% of the time.";
  } else {
    echo "$player->name is a new player.";
  }
} else {
  echo "Your player is invalid.";
}
