defmodule AdventOfCode.Solutions.Y2021.S9Test do
  use ExUnit.Case
  alias AdventOfCode.Solutions.Y2021.S9

  test "passes sample problem" do
    solution =
      "0,9 -> 5,9
      8,0 -> 0,8
      9,4 -> 3,4
      2,2 -> 2,1
      7,0 -> 7,4
      6,4 -> 2,0
      0,9 -> 2,9
      3,4 -> 1,4
      0,0 -> 8,8
      5,5 -> 8,2"
      |> StringIO.open()
      |> then(fn {:ok, pid} -> IO.stream(pid, :line) end)
      |> S9.parse_data()
      |> S9.solve!()

    assert solution == "5"
  end
end
