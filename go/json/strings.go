package json

var GoodJson = ` {
    "name": "Nooby McNoobington",
    "winPercent": null
} `

var GladJson = ` {
    "name": "Mikhail Tal",
    "winPercent": 85.2
} `

var DeadJson = ` {
    "name": "Never McWonAGame",
    "winPercent": 0
} `

var SadJson = ` {
    "name": "Nooby McNoobington",
    "winPercent": false
} `

var BadJson = ` {
    "name": "Nooby McNoobington",
    'winPercent': 13.3
} `

var RadJson = ` {
    "gab": 234,
    "gip": false,
    "gop": "Boom!"
} `