<?
require 'vendor/autoload.php';
include_once 'json_strings.php';
use JsonSchema\Validator;

$playerSchema = <<<'JSON'
{
  "type": "object",
  "required": ["name", "winPercent"],
  "properties": {
    "winPercent": {
      "type": ["number", "null"]
    },
    "name": {
      "type": "string"
    }
  }
}
JSON;

$player = json_decode($deadJson);

if ($player === null) {
  echo "JSON parse error.";
} else {
  $schemaObject = json_decode($playerSchema);
  $validator = new Validator();
  $validator->validate($player, $schemaObject);

  if ($validator->isValid()) {
    if ($player->winPercent !== null) {
      echo "$player->name wins $player->winPercent% of the time.";
    } else {
      echo "$player->name is a new player.";
    }
  } else {
    echo "Invalid player.\n";
    foreach ($validator->getErrors() as $error) {
      echo sprintf("[%s] %s\n", $error['property'], $error['message']);
    }
  }
}