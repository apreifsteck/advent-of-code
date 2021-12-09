defmodule AdventOfCode.Solutions.Utils.BoardTest do
  use ExUnit.Case
  alias AdventOfCode.Solutions.Utils.Board

  describe "wins?/1" do
    test "returns true if a board is wins" do
      winning_rows = %Board{
        board: 1..25 |> Enum.to_list(),
        markers: [1, 1, 1, 1, 1] ++ (Stream.cycle([0]) |> Enum.take(20))
      }
      assert Board.wins?(winning_rows)

      winning_columns = [
        0, 0, 1, 0, 0,
        0, 0, 1, 0, 0,
        0, 0, 1, 0, 0,
        0, 0, 1, 0, 0,
        0, 0, 1, 0, 0,
      ]
      winning_columns = %{winning_rows | markers: winning_columns}

      assert Board.wins?(winning_columns)
    end
  end

  describe "mark/2" do
    test "marks the appropriate place" do
      board =
        %Board{board: 1..25 |> Enum.to_list() }
        |> Board.mark(1)
        |> Board.mark(3)

      assert [1, _, 1 | _] = board.markers
    end
  end
end
