defmodule AdventOfCode.Solutions.Y2021.S2Test do
  use ExUnit.Case

  alias AdventOfCode.Solutions.Y2021.S2

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
      |> S2.solve!()

    assert solution == "5"
  end
end
