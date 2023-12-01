defmodule AdventOfCode.Solutions.Y2023.S1Test do
	use ExUnit.Case, asnyc: true
  alias AdventOfCode.Solutions.Y2023.S1, as: Solution

  @test_input """
  1abc2
  pqr3stu8vwx
  a1b2c3d4e5f
  treb7uchet
  """
  |> String.split()

  describe "solve!/1" do
    test "works" do
      assert 142 = Solution.solve!(@test_input)
    end
  end
end
