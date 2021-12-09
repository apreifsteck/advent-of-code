defmodule AdventOfCode.Solutions.Y2021.S8 do
  @moduledoc """

  """
  @behaviour AdventOfCode.Solution

  alias AdventOfCode.DataFetcher
  alias AdventOfCode.Solutions.Utils.Board

  @dim 5

  @impl true
  def parse_data(data) do
    AdventOfCode.get_prior_solution_module(__MODULE__).parse_data(data)
  end

  @impl true
  def solve!() do
    AdventOfCode.get_day_from_sol(__MODULE__)
    |> DataFetcher.read_data()
    |> parse_data()
    |> solve!()
  end

  @impl true
  def solve!({draws, boards}) do
    boards
    |> Enum.map(&Board.init/1)
    |> then(&solve!(draws, &1))
  end

  def solve!([num | rest], boards) do

  end
end
