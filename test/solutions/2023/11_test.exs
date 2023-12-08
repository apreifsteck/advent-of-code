defmodule AdventOfCode.Solutions.Y2023.S11Test do
  use ExUnit.Case, asnyc: true
  alias AdventOfCode.Solutions.Y2023.S11, as: Solution

  @test_input """
              Time:      7  15   30
              Distance:  9  40  200
              """
              |> String.split("\n")
              |> Enum.reject(& &1 == "")

  describe "parse_data/1" do
    test "works" do
      assert [{7, 9}, {15, 40}, {30, 200}] = @test_input |> Solution.parse_data()
    end
  end

  describe "solve!/1" do
    test "works" do
      assert 288 = @test_input |> Solution.parse_data() |> Solution.solve!()
    end
  end
end
