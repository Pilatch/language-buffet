//multiline literals must start and end on their own lines
let goodJson = """
{
    "name": "Nooby McNoobington",
    "winPercent": null
}
"""

let gladJson = """
{
    "name": "Mikhail Tal",
    "winPercent": 85.2
}
"""

let deadJson = """
{
    "name": "Never McWonAGame",
    "winPercent": 0
}
"""

let sadJson = """
{
    "name": "Nooby McNooberson",
    "winPercent": false
}
"""

let badJson = """
{
    "name": "Nooby McNooberson",
    'winPercent': 13.3
}
"""

let radJson = """
{
    "biz": "Nooby McNooberson",
    "baz": 13.3
}
"""
