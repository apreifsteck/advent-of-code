defmodule AdventOfCode.Solutions.Y2021.S10 do
  @moduledoc """

  """
  @behaviour AdventOfCode.Solution
  @prior_mod AdventOfCode.get_prior_solution_module(__MODULE__)

  alias AdventOfCode.DataFetcher

  @impl true
  def parse_data(data) do
    @prior_mod.parse_data(data)
  end

  @impl true
  def solve!() do
    AdventOfCode.get_day_from_sol(__MODULE__)
    |> DataFetcher.get_data()
    |> parse_data()
    |> solve!()
  end

  @impl true
  def solve!(data) do
    @prior_mod.solve!(data, &process_line/1)
  end


  def process_line({{x1, y1}, {x2, y2}}) when abs(y2 - y1) == abs(x2 - x1) do
    Enum.zip(x1..x2, y1..y2)
  end

  def process_line(points) do
    @prior_mod.process_line(points)
  end

end
