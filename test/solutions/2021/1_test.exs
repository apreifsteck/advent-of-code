defmodule AdventOfCode.Solutions.Y2021.S1Test do
  use ExUnit.Case

  alias AdventOfCode.Solutions.Y2021.S1

  test "passes sample problem" do
    solution =
      [
        199,
        200,
        208,
        210,
        200,
        207,
        240,
        269,
        260,
        263
      ]
      |> S1.solve!()

    assert solution == "7"
  end
end
