defmodule AdventOfCode.Solutions.Y2021.S13Test do
  use ExUnit.Case
  alias AdventOfCode.Solutions.Y2021.S13

  describe "calculate_cost" do
    test "it works" do
      data = [1, 5, 9, 2, 7, 4]
      line = 3

      assert S13.calculate_cost(line, data) == (2 + 2 + 6 + 1 + 4 + 1)
    end
  end

  test "passes sample problem" do
    solution =
      "16,1,2,0,4,2,7,1,2,14"
      |> S13.parse_data()
      |> S13.solve!()

    assert solution == "37"
  end
end
