# mix format is pretty cool.

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
  def introduce(player) do
    case player.winPercent do
      nil ->
        IO.puts("#{player.name} is a new player.")

      winPercent ->
        IO.puts("#{player.name} wins #{winPercent}% of the time")
    end
  end

  def main do
    # Had to do a bunch of searching just to load a local file
    Code.require_file("json_strings.exs", __DIR__)

    schema =
      %{
        "type" => "object",
        # "required" => ["name", "winPercent"], # for some reason this makes even good json bomb out
        "properties" => %{
          "name" => %{
            "type" => "string"
          },
          "winPercent" => %{
            "type" => ["number", "null"]
          }
        }
      }
      |> ExJsonSchema.Schema.resolve()

    # If you give it JSON with extra fields, those are discarded when the Player is created.
    try do
      # Decoding is not forgiving with single quotes like Google Gson.
      player = Poison.decode!(Json_Strings.glad(), as: %Player{})
      # So you can decode your JSON to a struct, but then if you want to validate it
      # using a schema you'll have to convert it to a map. Go figure.
      case ExJsonSchema.Validator.validate(schema, player |> Map.from_struct()) do
        # This will not error out as expected if you attempt to pipe player to a partially applied validate function like so:
        # player |> Map.from_struct |> ExJsonSchema.Validator.validate(schema)
        # That's because Elixir pipes to the first parameter, not the last.
        # Though a compiler failure would have been nice. :P
        :ok ->
          introduce(player)

        {:error, messages} ->
          messages |> inspect |> IO.puts()
      end
    rescue
      e in Poison.SyntaxError ->
        IO.puts("JSON syntax error: #{e.message}")
    end
  end
end

Main.main()

# hexdocs has been praised for documenation by this guy - https://elmtown.audio/29-knode-with-jim-carlson
#   https://hexdocs.pm/
