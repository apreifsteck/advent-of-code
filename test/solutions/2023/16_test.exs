defmodule AdventOfCode.Solutions.Y2023.S16Test do
  use ExUnit.Case, asnyc: true
  alias AdventOfCode.Solutions.Y2023.S16, as: Solution

  @test_input """
              LR

              11A = (11B, XXX)
              11B = (XXX, 11Z)
              11Z = (11B, XXX)
              22A = (22B, XXX)
              22B = (22C, 22C)
              22C = (22Z, 22Z)
              22Z = (22B, 22B)
              XXX = (XXX, XXX)
              """
              |> String.split("\n")
              |> Enum.reject(&(&1 == ""))

  @test_2 """
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

  @test_3 """
          LLR

          AAA = (BBB, BBB)
          BBB = (AAA, ZZZ)
          ZZZ = (ZZZ, ZZZ)
          """
          |> String.split("\n")
          |> Enum.reject(&(&1 == ""))

  describe "solve!/1" do
    test "works" do
      assert 6 = @test_input |> Solution.parse_data() |> Solution.solve!()
    end

    test "also works" do
      assert 6 = @test_3 |> Solution.parse_data() |> Solution.solve!()
      assert 2 = @test_2 |> Solution.parse_data() |> Solution.solve!()
    end
  end
end
