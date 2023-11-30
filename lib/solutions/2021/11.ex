defmodule AdventOfCode.Solutions.Y2021.S11 do
  @moduledoc """

  """
  @behaviour AdventOfCode.Solution

  alias AdventOfCode.DataFetcher

  @impl true
  def parse_data(data) do
    data
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  @impl true
  def solve!() do
    AdventOfCode.Solutions.get_day_from_sol(__MODULE__)
    |> DataFetcher.get_data()
    |> parse_data()
    |> solve!()
  end

  @impl true
  def solve!(data) do
    life_stages =
      [0]
      |> Stream.cycle()
      |> Enum.take(9)

    data
    |> Enum.reduce(life_stages, fn elem, acc ->
      List.update_at(acc, elem, &(&1 + 1))
    end)
    |> solve!(0)
  end

  def solve!(life_stages, 256), do: Enum.sum(life_stages) |> Integer.to_string()
  def solve!(life_stages, day) do
    [births | rest] = life_stages

    (rest ++ [births])
    |> List.update_at(6, &(&1 + births))
    |> solve!(day + 1)
  end



end
