defmodule Player do
  # @derive [Poison.Encoder]
  # Un-comment the @derive line this for encoding players to JSON,
  # but it gives me warnings when I run it.
  defstruct [:name, :winPercent]
  # This just does field mapping for you. There is no type-checking.
  # Google elixir strong types and one option is to write your elixir in Elm.
  # https://github.com/wende/elchemy
end

defmodule Main do
  def main do

    # Had to do a bunch of searching just to load a local file
    Code.require_file "json_strings.exs", __DIR__

    schema = %{
      "type" => "object",
      # "required" => ["name", "winPercent"], # for some reason this makes even good json bomb out
      "properties" => %{
        "name" => %{
          "type" => "string",
        },
        "winPercent" => %{
          "type" => ["number", "null"],
        },
      },
    } |> ExJsonSchema.Schema.resolve

    # If you give it JSON with extra fields, those are discarded when the Player is created.
    player = Poison.decode! Json_Strings.good, as: %Player{}

    # So you can decode your JSON to a struct, but then if you want to validate it
    # using a schema you'll have to convert it to a map. Go figure.
    case ExJsonSchema.Validator.validate(schema, player |> Map.from_struct) do
      # This will not error out as expected if you attempt to pipe player to a partially applied validate function like so:
      # player |> Map.from_struct |> ExJsonSchema.Validator.validate(schema)
      # That's because Elixir pipes to the first parameter, not the last.
      # Though a compiler failure would have been nice. :P
      :ok ->
        case player.winPercent do
          nil ->
            IO.puts "#{player.name} is a new player."

          winPercent ->
            IO.puts "#{player.name} wins #{winPercent}% of the time"
        end

      {:error, messages} -> messages |> inspect |> IO.puts
    end

    # Decoding is not forgiving with single quotes like Google Gson.
    # Decoding bad json will result in a Poison.SyntaxError being thrown.
  end
end

Main.main
