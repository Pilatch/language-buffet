local JSON = require("JSON")
local jsonschema = require 'jsonschema' -- rapidjson Lua rock didn't work as expected
require("./jsonStrings") -- Really easy to require

local playerValidator = jsonschema.generate_validator {
  type = 'object',
  required = {'name'},
  properties = {
    name = { type = 'string' },
    winPercent = { type = {'number', 'null'} },
  },
}

function introduce()
  local player = JSON:decode(gladJson)
  local isValid = playerValidator(player)

  if isValid then
    if player.winPercent then
      -- Lua doesn't have built-in string interpolation
      print(player.name .. " wins " .. player.winPercent .. "% of the time.")
    else
      print(player.name .. " is a new player.")
    end
  else
    print("Player is not valid!")
  end
end

-- This is better than rapidjson.decode because that just returns nil when
-- encountering a JSON syntax error, failing silently.
local status, error = pcall(introduce) -- a little tricky; pass a function; don't call the function immediately
-- pcall calls a function in protected mode where the error can be captured

if error then
  print("something 'sploded: " .. error)
end

-- However rapidjson does offer schema validation.
-- Lua is garbage collected.
-- It appears to be very fast. I'm surprised every time I run `lua main.lua` how instantaneous it is comaped to the
-- other languages I've been testing. There's nothing scientific about this, but I have read that Lua has been
-- used for game development, which should speak to its performance.
-- The package manager is a little strange because it wants to put stuff in
-- /usr/local/bin/luarocks, and on installation of a package it might complain about a lack of
-- cmake or something so it can build native binaries.
-- What's most impressive about Lua is how easy it was to get started with.
-- At this point if I were to start a new scripting-heavy project, I'd probably choose Lua.
