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
    AdventOfCode.get_day_from_sol(__MODULE__)
    |> DataFetcher.read_data()
    |> parse_data()
    |> solve!()
  end

  @impl true
  def solve!(data) do
    solve!(data, 0)
  end

  def solve!(fish, 256), do: Enum.count(fish) |> Integer.to_string()
  def solve!(fish, day) do
    IO.puts("day number: #{day}")
    aged_fish =
      Task.async(fn ->
        Task.async_stream(fish, fn
        0 -> 6
        val -> val - 1
      end, ordered: false, max_concurrency: 10, timeout: :infinity)
      |> Stream.map(fn {:ok, val} -> val end)
      |> Enum.to_list()
     end)

    new_fish =
      Task.async(fn ->
        fish
        # |> IO.inspect(label: "fish")
        |> Enum.reduce(0, fn
          0, acc ->
            acc + 1
          _val, acc ->
            acc
        end)
        # |> IO.inspect(label: "new fish")
        |> then(&(Stream.cycle([8]) |> Enum.take(&1)))
      end)

    solve!(Task.await(new_fish, :infinity) ++ Task.await(aged_fish, :infinity), day + 1)
  end

end
