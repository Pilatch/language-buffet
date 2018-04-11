require 'json'
require 'json-schema'
require_relative './JsonStrings'

schema = {
  type: 'object',
  required: ['name', 'winPercent'],
  properties: {
    name: {type: 'string'},
    winPercent: {type: ['number', 'null']},
  }
}

def introduce player
  puts "#{player['name']} " +
  if player['winPercent'].nil? then
    "is a new player."
  else
    "wins #{player['winPercent']}\% of the time."
  end
end

begin
  player = JSON.parse(good_json)
  validation_errors = JSON::Validator.fully_validate(schema, player)

  if validation_errors.count == 0 then
    introduce player
  else
    puts "player is not valid because #{validation_errors}"
  end
rescue JSON::ParserError => error
  puts "JSON parse error #{error}"
end
