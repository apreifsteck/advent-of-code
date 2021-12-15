defmodule AdventOfCode.Solutions.Y2021.S14Test do
  use ExUnit.Case
  alias AdventOfCode.Solutions.Y2021.S14

  describe "sum_integers" do
    test "it works" do
      assert S14.sum_integers(1, 3) == 6
      assert S14.sum_integers(3, 9) == Enum.sum(3..9)
    end
  end

  test "passes sample problem" do
    solution =
      "16,1,2,0,4,2,7,1,2,14"
      |> S14.parse_data()
      |> S14.solve!()

    assert solution == "168"
  end
end
