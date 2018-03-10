<?

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

$goodJson = '{
  "name": "Nooby McNooberson",
  "winPercent": null
}';

$gladJson = '{
  "name": "Mikhail Tal",
  "winPercent": 85.2
}';

$sadJson = '{
  "name": "Nooby McNooberson",
  "winPercent": false
}';

$badJson = '{
  \'name\': "Nooby McNooberson",
  "winPercent": null
}';

$radJson = '{
  "zap": 123,
  "zub": null,
  "ziz": "Nooby McNooberson"
}';
