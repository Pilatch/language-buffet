defmodule Player do
  defstruct [:name, :winPercent]
end

defmodule Main do
  def main do

    Code.require_file "json_strings.exs", __DIR__

    schema = %{
      "type" => "object",
      "properties" => %{
        "name" => %{
          "type" => "string",
        },
        "winPercent" => %{
          "type" => ["number", "null"],
        },
      },
    } |> ExJsonSchema.Schema.resolve

    player = Poison.decode! Json_Strings.good, as: %Player{}

    case ExJsonSchema.Validator.validate(schema, player |> Map.from_struct) do
      :ok ->
        case player.winPercent do
          nil -> IO.puts "#{player.name} is a new player."

          winPercent -> IO.puts "#{player.name} wins #{winPercent}% of the time"
        end

      {:error, messages} -> messages |> inspect |> IO.puts
    end

  end
end

Main.main
