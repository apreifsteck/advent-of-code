defmodule AdventOfCode.Solutions.Utils.Board do
  @dim 5
  @base for _ <- 1..25, do: 0
  defstruct board: @base, markers: @base

  def init(board) when is_list(board), do: %__MODULE__{board: board}

  def get_final_score(%__MODULE__{} = board, number) do
    board.board
    |> Enum.zip(board.markers)
    |> Enum.map(fn
      {num, 0} -> num
      {_num, 1} -> 0
    end)
    |> Enum.sum()
    |> Kernel.*(number)
  end
  def wins?(%__MODULE__{} = board) do
    # Each board has five rows and five columns
    # When a number is called, a row gets "marked"
    # A winning board is one that has a whole row or column "marked"
    # I.e, if 5 * row..5 * (row + 1) are maked for some row or
    # (5 * row + index) % col are marked for col 1..5 for some index
    check_vertical_win(board.markers) or check_horizontal_win(board.markers)
  end

  defp check_horizontal_win(markers) do
    markers
    |> Enum.chunk_every(@dim)
    |> Enum.map(&Enum.sum/1)
    |> Enum.any?(&(&1 == @dim))
  end

  defp check_vertical_win(markers) do
    base = for _ <- 1..@dim, do: 0
    markers
    |> Enum.chunk_every(@dim)
    |> Enum.reduce(base, fn marker_row, acc ->
      marker_row
      |> Enum.zip(acc)
      |> Enum.map(fn {marker, sum_markers} -> marker + sum_markers end)
    end)
    |> Enum.member?(@dim)
  end

  def mark(%__MODULE__{} = board, number) do
    board.board
    |> Enum.find_index(&(&1 == number))
    |> case do
      nil ->
        board

      index when is_integer(index) ->
        board.markers
        |> List.replace_at(index, 1)
        |> then(&(%{board | markers: &1}))
    end
  end
end
