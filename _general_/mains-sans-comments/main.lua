local JSON = require("JSON")
local jsonschema = require 'jsonschema'
require("./jsonStrings")

local playerValidator = jsonschema.generate_validator {
  type = 'object',
  required = {'name'},
  properties = {
    name = { type = 'string' },
    winPercent = { type = {'number', 'null'} },
  },
}

function introduce()
  local player = JSON:decode(radJson)
  local isValid = playerValidator(player)

  if isValid then
    if player.winPercent then
      print(player.name .. " wins " .. player.winPercent .. "% of the time.")
    else
      print(player.name .. " is a new player.")
    end
  else
    print("Player is not valid!")
  end
end

local status, error = pcall(introduce)

if error then
  print("something 'sploded: " .. error)
end
