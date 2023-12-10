defmodule AdventOfCode.Solutions.Y2023.S15Test do
  use ExUnit.Case, asnyc: true
  alias AdventOfCode.Solutions.Y2023.S15, as: Solution

  @test_input """
              RL

              AAA = (BBB, CCC)
              BBB = (DDD, EEE)
              CCC = (ZZZ, GGG)
              DDD = (DDD, DDD)
              EEE = (EEE, EEE)
              GGG = (GGG, GGG)
              ZZZ = (ZZZ, ZZZ)
              """
              |> String.split("\n")
              |> Enum.reject(&(&1 == ""))

  @test_input_2 """
                LLR

                AAA = (BBB, BBB)
                BBB = (AAA, ZZZ)
                ZZZ = (ZZZ, ZZZ)
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
      assert 2 = @test_input |> Solution.parse_data() |> Solution.solve!()
    end

    test "also works" do
      assert 6 = @test_input_2 |> Solution.parse_data() |> Solution.solve!()
    end
  end
end
