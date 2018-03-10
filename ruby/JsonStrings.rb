def good_json
  <<-EOF
  {
    "name": "Nooby McNoobington",
    "winPercent": null
  }
  EOF
end

def glad_json
  <<-EOF
  {
    "name": "Mikhail Tal",
    "winPercent": 85.2
  }
  EOF
end

def sad_json
  <<-EOF
  {
    "name": 123,
    "winPercent": false
  }
  EOF
end

def bad_json
  <<-EOF
  {
    "name": "Nooby McNoobington",
    'winPercent': null
  }
  EOF
end

def rad_json
  <<-EOF
  {
    "fiz": 123,
    "faz": null,
    "guz": "Boom!"
  }
  EOF
end
