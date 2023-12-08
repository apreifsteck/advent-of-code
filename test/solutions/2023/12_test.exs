defmodule AdventOfCode.Solutions.Y2023.S12Test do
  use ExUnit.Case, asnyc: true
  alias AdventOfCode.Solutions.Y2023.S12, as: Solution

  @test_input """
              Time:      7  15   30
              Distance:  9  40  200
              """
              |> String.split("\n")
              |> Enum.reject(& &1 == "")

  describe "parse_data/1" do
    test "works" do
      assert {71530, 940200} = @test_input |> Solution.parse_data()
    end
  end

  describe "solve!/1" do
    test "works" do
      assert 71503 = @test_input |> Solution.parse_data() |> Solution.solve!()
    end
  end
end
