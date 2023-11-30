defmodule AdventOfCode.DataFetcher do
  def get_data(day) when is_integer(day), do: get_data(Integer.to_string(day))

  def get_data(day) when is_binary(day) do
    File.cwd!()
    |> Path.join(relative_file_name(day))
    |> File.stream!()
  end

  defp relative_file_name(day), do: "problem_input/#{day}.txt"
end
