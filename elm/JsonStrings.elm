module JsonStrings exposing (..)


goodJson : String
goodJson =
    """ {
        "name": "Nooby McNoobington",
        "winPercent": null
    } """


gladJson : String
gladJson =
    """ {
        "name": "Mikhail Tal",
        "winPercent": 85.2
    } """


sadJson : String
sadJson =
    """ {
        "name": "Nooby McNoobington",
        "winPercent": false
    } """


badJson : String
badJson =
    """ {
        "name": "Mikhail Tal",
        'winPercent': 85.2
    } """


radJson : String
radJson =
    """ {
        "gab": 234,
        "gip": false,
        "gop": "Boom!"
    } """
