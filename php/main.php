<?
require 'vendor/autoload.php';
include_once 'json_strings.php';
use JsonSchema\Validator;

$schemaObject = json_decode($playerSchema);
$validator = new Validator();
$player = json_decode($gladJson); // returns null if decoding fails
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

// json_decode is native to PHP, which makes sense as it's a web language.
// Note that decoding bad json does not throw an error, but just returns null.
// This is a little funny because if you decode 'null' you get the same thing.
// PHP does type coercion in if statements like JavaScript, which is why it also has == and ===.
// It's string interpolation is easy too because of the dollar signs.
// On the other hand, it's a little tiresome to slap a dollar sign in front of everything.
// My experience in PHP has taught me that it can be reasonably fast,
// even with a bloated application like Drupal.
// The trick is to enable the "Alternate PHP Cache", or APC, which will save and run opcode.
// PHP does feel like a square peg shoved into a round hole in that it's a programming
// language, but sort of retrofitted to do more than wrap the HTTP requests/response cycle.
// If you're going to pick PHP for a project, it's probably because of some existing framework,
// and not because you're excited to code in PHP.
//
// That said, Facebook, Wikipedia, Wordpress, Etsy, Baidu, Box, and Slack are written in PHP.
// Maybe it's because of the fast development cycle.

// https://slack.engineering/taking-php-seriously-cf7a60065329
// The author if this article states that PHP is a member of the "Mixed-Paradigm Developer Productivity Languages",
// which includes JavaScript, Python, Ruby, and Lua.

// Then there is Hack, a language that augments PHP to add static typing,
// while providing another execution environment for vanilla PHP code.
// http://hacklang.org/
// It uses a just-in-time compiler that claims to only add a fifth of a second,
// and its HipHop Virtual Machine, HHVM, has produced significant performance gains
// for companies that use it such as Facebook and Wikipedia.
