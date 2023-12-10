defmodule AdventOfCode.Solutions.Y2023.S18 do
use AdventOfCode.Solution, use_prior_solution: true
 
  @moduledoc """
  """
  def solve!(data) do
    data
    |> Enum.map(&find_constant_sequence/1)
    |> Enum.map(fn lists -> Enum.map(lists, &List.first/1) end)
    |> Enum.map(fn list -> List.foldr(list, 0, &Kernel.-/2) end)
    |> Enum.sum()
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
