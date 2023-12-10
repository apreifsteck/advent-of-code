defmodule AdventOfCode.Solutions.Y2023.S17 do
use AdventOfCode.Solution
 
  @moduledoc """
  """

  def solve!(data) do
    data
    |> Enum.map(&find_constant_sequence/1)
    |> Enum.map(fn lists -> Enum.map(lists, &List.last/1) end)
    |> Enum.map(&Enum.reverse/1)
    |> Enum.map(&Enum.sum/1)
    |> Enum.sum()
  end


  def parse_data(data) do
    data
    |> Enum.map(fn row -> row |> String.split() |> Enum.map(&String.to_integer/1) end)
  end

  defp find_constant_sequence(initial) do
    initial
    |> MapSet.new()
    |> MapSet.size()
    |> case do
      1 -> [initial] 
      _ -> [initial | find_constant_sequence(generate_sequence(initial))]
    end
  end

  defp generate_sequence(stuff) do
    stuff |> Enum.chunk_every(2, 1, :discard) |> Enum.map(fn [left, right] -> right - left end)
  end
 
end
