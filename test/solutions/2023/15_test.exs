defmodule AdventOfCode.Solutions.Y2023.S15Test do
  use ExUnit.Case, asnyc: true
  alias AdventOfCode.Solutions.Y2023.S15, as: Solution

  @test_input """
              """
              |> String.split("\n")
              |> Enum.reject(& &1 == "")


  describe "parse_data/1" do
    test "works" do
      assert "" = @test_input |> Solution.parse_data()
    end
  end
 
  describe "solve!/1" do
    test "works" do
      assert nil = @test_input |> Solution.parse_data() |> Solution.solve!()
    end
  end
end
