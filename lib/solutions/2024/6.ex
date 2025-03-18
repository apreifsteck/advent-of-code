defmodule AdventOfCode.Solutions.Y2024.S6 do
  use AdventOfCode.Solution, use_prior_solution: false
  @moduledoc """
  Solved
  """

  def solve!(data) do
    data
    |> Enum.reduce({true, 0}, fn
      ["do"], {_, running_tally} ->
        {true, running_tally}

      ["don't"], {_, running_tally} ->
        {false, running_tally}

      [_, left, right], {should_execute_instruction?, running_tally} ->
        running_tally =
          if should_execute_instruction? do
            running_tally + left * right
          else
            running_tally
          end

        {should_execute_instruction?, running_tally}
    end)
    |> elem(1)
  end

  def parse_data(data) do
    data
    |> Enum.into("")
    |> then(&Regex.scan(~r/mul\((\d{1,3}),(\d{1,3})\)|don't|do/, &1))
    |> Enum.map(fn
      [base, left, right] ->
        [base, String.to_integer(left), String.to_integer(right)]

      other ->
        other
    end)
  end
end
