module JsonStrings where

badJSON :: String
badJSON = """{
  "name": "Nooby McNoobington",
  'winPercent': null
}"""

goodJSON :: String
goodJSON = """{
  "name": "Nooby McNoobington",
  "winPercent": null
}"""


gladJSON :: String
gladJSON = """{
  "name": "Mikhail Tal",
  "winPercent": 85.2
}"""

