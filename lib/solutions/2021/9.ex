defmodule AdventOfCode.Solutions.Y2021.S9 do
  @moduledoc """

  """
  @behaviour AdventOfCode.Solution

  alias AdventOfCode.DataFetcher

  @impl true
  def parse_data(data) do
    data
    |> Stream.map(&String.split(&1, "->"))
    |> Stream.map(fn elem ->
      [origin, dest] = Enum.map(elem, &parse_pnt/1)
      {origin, dest}
    end)
  end

  defp parse_pnt(point) do
    [x, y] =
      point
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
    {x, y}
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
    solve!(data, &process_line/1)
  end
  def solve!(data, line_processor) do
    data
    |> Enum.flat_map(line_processor)
    |> Enum.reduce(%{}, fn loc, acc ->
      {_, acc} =
        Map.get_and_update(acc, loc, fn
          nil ->
            {nil, 1}
          val ->
            {val, val + 1}
        end)
      acc
    end)
    |> Enum.filter(fn {_k, v} -> v >= 2 end)
    |> Enum.count()
    |> Integer.to_string()
  end

  def process_line({{x1, y1}, {x2, y2}}) when x1 == x2 do
    for n <- y1..y2 do
      {x1, n}
    end
  end

  def process_line({{x1, y1}, {x2, y2}}) when y1 == y2 do
    for n <- x1..x2 do
      {n, y1}
    end
  end

  def process_line(_) do
    []
  end
end
