defmodule AdventOfCode.Solutions.Y2023.S17Test do
  use ExUnit.Case, asnyc: true
  alias AdventOfCode.Solutions.Y2023.S17, as: Solution

  @test_input """
              0 3 6 9 12 15
              1 3 6 10 15 21
              10 13 16 21 30 45
              """
              |> String.split("\n")
              |> Enum.reject(&(&1 == ""))

  describe "parse_data/1" do
    test "works" do
      assert "" = @test_input |> Solution.parse_data()
    end
  end

  describe "solve!/1" do
    test "works" do
      assert 114 = @test_input |> Solution.parse_data() |> Solution.solve!()
    end
  end
end
