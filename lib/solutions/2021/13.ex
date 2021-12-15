defmodule AdventOfCode.Solutions.Y2021.S13 do
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
    AdventOfCode.get_day_from_sol(__MODULE__)
    |> DataFetcher.read_data()
    |> parse_data()
    |> solve!()
  end

  @impl true
  def solve!(data) do
    data
    |> median()
    |> calculate_cost(data)
    |> Integer.to_string()
  end

  def median(data) do
    sorted_data = Enum.sort(data)
    len = Enum.count(data)
    IO.inspect(len, label: "length:")
    mid = Integer.floor_div(len, 2) - 1

    Enum.at(sorted_data, mid)
  end

  def calculate_cost(line, crabs) do
    crabs
    |> Enum.reduce(0, fn elem, acc ->
      acc + abs(elem - line)
    end)
  end
end
