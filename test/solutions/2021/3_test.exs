defmodule AdventOfCode.Solutions.Y2021.S3Test do
  use ExUnit.Case

  alias AdventOfCode.Solutions.Y2021.S3

  test "passes sample problem" do
    solution =
      [
        {"forward", 5},
        {"down", 5},
        {"forward", 8},
        {"up", 3},
        {"down", 8},
        {"forward", 2}
      ]
      |> S3.solve!()

    assert solution == "150"
  end
end
