require 'json'
require 'json-schema'
require_relative './JsonStrings'

schema = {
  'type' => 'object',
  'required' => ['name', 'winPercent'],
  'properties' => {
    'name' => {'type' => 'string'},
    'winPercent' => {'type' => ['number', 'null']}
  }
}

begin
  player_hash = JSON.parse(glad_json)
  validation_errors = JSON::Validator.fully_validate(schema, player_hash)

  if validation_errors.count == 0 then
    puts "#{player_hash['name']} " +
    if player_hash['winPercent'].nil? then
      "is a new player."
    else
      "wins #{player_hash['winPercent']}\% of the time."
    end
  else
    puts "player_hash is not valid because #{validation_errors}"
  end
rescue JSON::ParserError => error
  puts "JSON parse error #{error}"
end
