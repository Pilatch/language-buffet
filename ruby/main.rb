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
  puts "#{player['name']} " + # every statement returns
  # player is a hash so use this syntax rather than a dot.

  if player['winPercent'].nil? then
    "is a new player."
  else
    "wins #{player['winPercent']}\% of the time."
  end
end

begin
  player = JSON.parse(dead_json)
  validation_errors =
    JSON::Validator.fully_validate(schema, player)

  if validation_errors.count == 0 then
    introduce player
  else
    puts "Invalid player #{validation_errors}"
  end
rescue JSON::ParserError => error
  puts "JSON parse error #{error}"
end

# One of my favorite things about Ruby is the documancy.
# http://ruby-doc.org/stdlib-2.0.0/libdoc/json/rdoc/JSON.html#method-i-parse
# http://www.rubydoc.info/gems/json-schema/2.5.1

# Ruby is not known for its speed. The interpreter does seem a bit sluggish to start up.
# On the other hand, Ruby on Rails is known for a fast time-to-market for web applications,
# especially those backed by a relational database thanks to the power of Active Record.
# This also may be due to Ruby being a "developer productivity" language.
# It could be due to the Rails doctrine. http://rubyonrails.org/doctrine/

# Because Ruby is not a close-to-the-metal, high-performance language, many gems are
# Ruby C extensions. This can lead to C-like problems.
# How to find - https://holymonkey.com/how-to-find-and-fix-a-memory-leak-in-a-ruby-c-extension.html
# Leaky gems - https://github.com/ASoftCo/leaky-gems

# I had problems with installing gems on OS X because that comes with
# a version of Ruby, 2.0.0p648, and you don't want to install gems via sudo because they'll go to /usr/bin.
# To get around this we use RVM, which you should be using anyway, but the installation
# is janky and may require you use a different GPG key server.
# https://medium.com/@xiaoxiaohou/gpg-keyserver-receive-failed-no-route-to-host-9e47a0dd83f8
# Once you have that working you can install bundler, which is the package manager of choice.
# But nothing seems to work for me. Asked a question -
# https://stackoverflow.com/questions/49078366/cant-install-ruby-gem-on-macos-sierra10-12-6-even-with-rvm-or-sudo?noredirect=1#comment85163428_49078366
#