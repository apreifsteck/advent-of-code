defmodule AdventOfCode.Solutions.Y2021.S13 do
  @moduledoc """

  """
  use AdventOfCode.Solution

  @impl true
  def parse_data(data) do
    data
    |> Stream.flat_map(&String.split(&1, ","))
    |> Stream.map(&String.to_integer/1)
    |> Enum.into([])
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
    IO.inspect(len, label: "length")
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
