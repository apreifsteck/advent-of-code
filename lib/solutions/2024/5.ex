defmodule AdventOfCode.Solutions.Y2024.S5 do
  use AdventOfCode.Solution
  @moduledoc """
  solved
  """

  def solve!(data) do
    data
    |> Enum.map(fn [_, left, right] -> left * right end)
    |> Enum.sum()
  end

  def parse_data(data) do
    data
    |> Enum.into("")
    |> then(&Regex.scan(~r/mul\((\d{1,3}),(\d{1,3})\)/, &1))
    |> Enum.map(fn [base, left, right] ->
      [base, String.to_integer(left), String.to_integer(right)]
    end)
  end
end
