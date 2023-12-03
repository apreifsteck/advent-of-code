defmodule AdventOfCode.Solutions.Y2023.S3Test do
  use ExUnit.Case, asnyc: true
  alias AdventOfCode.Solutions.Y2023.S3, as: Solution

  @test_input """
              Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
              Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
              Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
              Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
              Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
              """
              |> String.split("\n")

  describe "solve!/1" do
    test "works" do
      assert 8 = @test_input |> Solution.parse_data() |> Solution.solve!()
    end
  end

  describe "parse_data" do
    test "parses a single line into a game" do
      [
        %Solution{
          id: 1,
          draws: [
            {4, 0, 3},
            {1, 2, 6},
            {0, 2, 0}
          ]
        }
      ] =
        @test_input
        |> hd()
        |> List.wrap()
        |> Solution.parse_data()
    end
  end
end
