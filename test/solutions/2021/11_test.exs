defmodule AdventOfCode.Solutions.Y2021.S11Test do
  use ExUnit.Case
  alias AdventOfCode.Solutions.Y2021.S11

  test "passes sample problem" do
    solution =
      "3,4,3,1,2"
      |> S11.parse_data()
      |> S11.solve!()

    assert solution == "5934"
  end
end
