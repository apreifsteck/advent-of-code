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

  def solve!({data, domain}) do
    data 
      |> Enum.join("")
      |> String.to_charlist()
      |> Enum.with_index()
      |> Enum.chunk_by(fn {codepoint, _index} -> codepoint in ?0..?9 end)
      |> Enum.filter(fn [{codepoint, _index} | _ ] -> codepoint in ?0..?9 end)
      |> Enum.map(fn chunk -> 
        {_, first_index} = hd(chunk)
        {_, last_index} = List.last(chunk)
         number = Enum.map(chunk, &elem(&1, 0)) |> IO.chardata_to_string() |> String.to_integer()
      {number, {first_index, last_index}}
      end)
      |> Enum.filter(&touches_domain?(domain, elem(&1, 1)))
      |> Enum.map(&elem(&1, 0))
      |> Enum.sum()
  end

  defp touches_domain?(domain, {start, final}) do
    Enum.at(domain, start) == 1 or Enum.at(domain, final) == 1
  end

  def parse_data(data) do
    listified_data = Enum.to_list(data) 
    bounds = domain_bounds(listified_data)
    domain = build_empty_domain(bounds)

    {listified_data, listified_data
    |> get_symbol_domain_indexes(bounds)
    |> Enum.reduce(domain, &List.replace_at(&2, &1, 1))}
  end

  defp get_symbol_domain_indexes(data, bounds) do
    for {row, row_ind} <- Enum.with_index(data), 
        {char, col_ind} <- row |> String.to_charlist() |> Enum.with_index(),
        char not in ?0..?9 and char != ?. do
          {char, {row_ind, col_ind}}
    end
    |> Enum.flat_map(fn {_char, {row, col}} -> get_domain_from_indexes(row, col, bounds) end)
    |> MapSet.new()
  end

  def get_domain_from_indexes(row, col, {num_rows, num_cols}) do
    range = -1..1
    for row_offset <- range, col_offset <- range, between_bounds?(row + row_offset, num_rows) and between_bounds?(col + col_offset, num_cols) do
      (((row + row_offset) * num_cols) + (col + col_offset))
      |> min((num_rows * num_cols) - 1)
      |> max(0)
    end
  end

  defp build_empty_domain({num_rows, num_cols}) do
    for _ <- 1..num_rows, _ <- 1..num_cols, do: 0
  end

  defp between_bounds?(x, top_bound), do: x < top_bound and x >= 0

  defp domain_bounds(data) do
    lines = length(data)
    width = data |> hd() |> String.length()
    {lines, width}
  end
end
