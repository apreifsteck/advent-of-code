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

  defstruct [:parts]

  typedstruct module: Part do
    field :start_index, integer()
    field :end_index, integer()
    field :data, String.t()
  end

  def solve!(data) do
    case data do
      [_] ->
        [data]

      [_, _] = two_elems ->
        [two_elems, two_elems]

      _ ->
        initial = Enum.take(data, 2)
        # create a sliding window to look at
        [initial | Enum.chunk_every(data, 3, 1)]
    end
    |> dbg()
    |> find_all_engine_parts([])
    |> Enum.flat_map(& &1.parts)
    |> Enum.map(& &1.data)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  defp find_all_engine_parts([[current_row] = rows | []], transformed_rows) do
    [%{current_row | parts: get_engine_parts(current_row, rows)} | transformed_rows]
  end

  defp find_all_engine_parts([[_prior_row, current_row] = rows | []], transformed_rows) do
    [%{current_row | parts: get_engine_parts(current_row, rows)} | transformed_rows]
  end

  defp find_all_engine_parts(
         [[_prior_row, current_row, _next_row] = rows | rest],
         transformed_rows
       ) do
    find_all_engine_parts(rest, [
      %{current_row | parts: get_engine_parts(current_row, rows)} | transformed_rows
    ])
  end

  defp find_all_engine_parts([[current_row, _next_row] = rows | rest], transformed_rows) do
    find_all_engine_parts(rest, [
      %{current_row | parts: get_engine_parts(current_row, rows)} | transformed_rows
    ])
  end

  defp get_engine_parts(%__MODULE__{} = current_row, rows) do
    engine_parts_for_row = fn row ->
      Enum.filter(current_row.parts, &has_proximity_to_symbol?(&1, row.parts))
    end

    rows
    |> Enum.map(engine_parts_for_row)
    |> Enum.map(&MapSet.new/1)
    |> Enum.reduce(&MapSet.union/2)
  end

  defp has_proximity_to_symbol?(part, parts) do
    %{start_index: start_i, end_index: end_i} = part

    if digit_part?(part) do
      parts
      |> Enum.reject(&digit_part?(&1))
      |> Enum.filter(&(&1.start_index >= start_i - 1 and &1.end_index <= end_i + 1))
      |> case do
        [] -> false
        _ -> true
      end
    else
      false
    end
  end

  defp digit_part?(%__MODULE__.Part{} = part) do
    Integer.parse(part.data) != :error
  end

  def parse_data(data) do
    data
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(&Enum.with_index/1)
    |> Enum.map(&Enum.reject(&1, fn {codepoint, _index} -> codepoint == ?. end))
    |> Enum.map(
      &Enum.chunk_while(
        &1,
        {[], -1},
        fn elem, {part_or_symbol_chunk, last_index} ->
          {codepoint, index} = elem
          # codepoint not a number
          # index not contiguous
          # There's already stuff in the list

          cond do
            codepoint not in ?0..?9 ->
              maybe_prior_chunk = part_or_symbol_chunk |> Enum.reverse() |> build_part()
              symbol_part = build_part([elem])

              {:cont, List.flatten([maybe_prior_chunk, symbol_part]), {[], index}}

            index > last_index + 1 and part_or_symbol_chunk != [] ->
              {:cont, build_part(Enum.reverse(part_or_symbol_chunk)), {[elem], index}}

            true ->
              {:cont, {[elem | part_or_symbol_chunk], index}}
          end
        end,
        fn
          {[], _} ->
            {:cont, {}}

          {part_or_symbol_chunk, _last_index} ->
            {:cont, build_part(Enum.reverse(part_or_symbol_chunk)), {}}
        end
      )
    )
    |> Enum.map(&%__MODULE__{parts: List.flatten(&1)})
  end

  defp build_part([]), do: []

  defp build_part(part_spec) do
    {_codepoint, start_index} = hd(part_spec)
    {_codepoint, last_index} = List.last(part_spec)
    data = Enum.map(part_spec, &elem(&1, 0))

    %__MODULE__.Part{
      start_index: start_index,
      end_index: last_index,
      data: IO.chardata_to_string(data)
    }
  end
end
