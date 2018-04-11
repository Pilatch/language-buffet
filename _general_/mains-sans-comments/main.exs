defmodule Player do
  defstruct [:name, :winPercent]
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
    Code.require_file("json_strings.exs", __DIR__)

    schema =
      %{
        "type" => "object",
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

    try do
      player = Poison.decode!(Json_Strings.bad(), as: %Player{})

      case ExJsonSchema.Validator.validate(schema, player |> Map.from_struct()) do
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
