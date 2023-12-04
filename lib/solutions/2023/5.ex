defmodule AdventOfCode.Solutions.Y2023.S5 do
  use AdventOfCode.Solution
  use TypedStruct

  @moduledoc """
  The engineer explains that an engine part seems to be missing from the engine, but nobody can figure out which one. If you can add up all the part numbers in the engine schematic,
  it should be easy to work out which part is missing.

  The engine schematic (your puzzle input) consists of a visual representation of the engine. 
  There are lots of numbers and symbols you don't really understand, but apparently any number adjacent to a symbol, even diagonally, is a "part number" and should be included in your sum. (Periods (.) do not count as a symbol.)

  Here is an example engine schematic:

  467..114..
  ...*......
  ..35..633.
  ......#...
  617*......
  .....+.58.
  ..592.....
  ......755.
  ...$.*....
  .664.598..
  In this schematic, two numbers are not part numbers because they are not adjacent to a 
  symbol: 114 (top right) and 58 (middle right). Every other number is adjacent to a symbol 
  and so is a part number; their sum is 4361.

  Of course, the actual engine schematic is much larger.
  What is the sum of all of the part numbers in the engine schematic?
  """

  def solve!(data) do
    data
  end

  def parse_data(data) do
    domain = build_empty_domain(data)
    get_symbol_indexes(data)

  end

  defp get_symbol_indexes(data) do
    data
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(&Enum.with_index/1)
    |> Enum.map(&Enum.filter(&1, fn {code_point, _index} -> code_point not in ?0..?9 and code_point != ?. end))
    |> Enum.with_index()
    |> dbg()
  end

  defp get_domain_from_indexes(row, col, {num_rows, num_cols}) do
    range = [-1, 0, 1]
    for row_offset <- range, col_offset <- range do
      (((row + row_offset) * num_rows) + (col + col_offset))
      |> min((num_rows - 1) * (num_cols - 1))
      |> max(0)
    end
  end

  defp build_empty_domain(data) do
    lines = length(data)
    width = data |> hd() |> String.length()
    for _ <- 1..lines, _ <- 1..width, do: 0
  end

  defp domain_bounds(data) do
    
  end
end
