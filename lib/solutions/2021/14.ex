defmodule AdventOfCode.Solutions.Y2021.S14 do
  @moduledoc """

  """
  @behaviour AdventOfCode.Solution
  @prior_mod AdventOfCode.Solutions.get_prior_solution_module(__MODULE__)

  alias AdventOfCode.DataFetcher

  @impl true
  def parse_data(data) do
    @prior_mod.parse_data(data)
  end

  @impl true
  def solve!() do
    AdventOfCode.Solutions.get_day_from_sol(__MODULE__)
    |> DataFetcher.read_data()
    |> parse_data()
    |> solve!()
  end
  # Keep track of the total distance on each
  # side
  # recursively(?) step in each direction until
  # You find the shortest distance?
  # Or, just try to equalize the distance on each side?
  # Or come up with a cost formula relative to distance and then
  # take the derivative, then solve for the minimum. Seems the
  # most mathematically reliable.

  @impl true
  def solve!(data) do
    data
    |> calculate_cost(data)
    |> Integer.to_string()
  end

  def calculate_cost(line, crabs) do
    crabs
    |> Enum.reduce(0, fn elem, acc ->
      acc + sum_integers(line, elem)
    end)
  end

  def sum_integers(first, last) do
    ((abs(last - first) + 1) * (first + last)) / 2
  end
end
