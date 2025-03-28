defmodule AdventOfCode.Solutions.Y2024.S8Test do
  use ExUnit.Case, asnyc: true
  alias AdventOfCode.Solutions.Y2024.S8, as: Solution

  @test_input """
              """
              |> String.split("\n")
              |> Enum.reject(& &1 == "")

 
  describe "solve!/1" do
    test "works" do
      assert nil = @test_input |> Solution.parse_data() |> Solution.solve!()
    end
  end
end
