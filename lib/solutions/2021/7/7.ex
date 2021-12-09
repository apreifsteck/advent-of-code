defmodule AdventOfCode.Solutions.Y2021.S7 do
  @moduledoc """

  """
  @behaviour AdventOfCode.Solution

  alias AdventOfCode.DataFetcher
  alias AdventOfCode.Solutions.Utils.Board

  @impl true
  def parse_data(data) do
    {draws, boards} =
      data
      |> String.split("\n\n")
      |> Enum.split(1)

    draws =
      draws
      |> hd()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    boards =
      boards
      |> Stream.map(&String.replace(&1, "\n", " "))
      |> Stream.map(&String.split/1)
      |> Stream.map(fn row -> Enum.map(row, &String.to_integer/1) end)
      |> Enum.to_list()
    {draws, boards}
  end

  @impl true
  def solve!() do
    4
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
    marked_boards = Enum.map(boards, &Board.mark(&1, num))

    marked_boards
    |> Enum.find(&Board.wins?/1)
    |> case do
      %Board{} = board ->
        Board.get_final_score(board, num) |> Integer.to_string()
      nil ->
        solve!(rest, marked_boards)
    end
  end
end
