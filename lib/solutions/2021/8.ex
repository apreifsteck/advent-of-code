defmodule AdventOfCode.Solutions.Y2021.S8 do
  @moduledoc """

  """
  @behaviour AdventOfCode.Solution

  alias AdventOfCode.DataFetcher
  alias AdventOfCode.Solutions.Utils.Board

  @impl true
  def parse_data(data) do
    AdventOfCode.Solutions.get_prior_solution_module(__MODULE__).parse_data(data)
  end

  @impl true
  def solve!() do
    AdventOfCode.Solutions.get_day_from_sol(__MODULE__)
    |> DataFetcher.read_data()
    |> parse_data()
    |> solve!()
  end

  @impl true
  def solve!({draws, boards}) do
    boards
    |> Enum.map(&Board.init/1)
    |> then(&solve!(draws, &1, nil))
  end

  def solve!(_, [], last_winning_score), do: Integer.to_string(last_winning_score)
  def solve!([], _boards, last_winning_score), do: Integer.to_string(last_winning_score)
  def solve!([num | rest], boards, last_winning_score) do
    {winning_boards, losing_boards} =
      boards
      |> Enum.map(&Board.mark(&1, num))
      |> Enum.split_with(&Board.wins?(&1))

    if winning_boards == [] do
      solve!(rest, losing_boards, last_winning_score)
    else
      last_winning_score =
        winning_boards
        |> Enum.reverse()
        |> hd()
        |> Board.get_final_score(num)
      solve!(rest, losing_boards, last_winning_score)
    end
  end
end
