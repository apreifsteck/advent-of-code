defmodule AdventOfCode.Solutions.Y2023.S9Test do
  use ExUnit.Case, asnyc: true
  alias AdventOfCode.Solutions.Y2023.S9, as: Solution

              # seeds: 79 14 55 13
  @test_input """
              seeds: 79 14 55 13

              seed-to-soil map:
              50 98 2
              52 50 48

              soil-to-fertilizer map:
              0 15 37
              37 52 2
              39 0 15

              fertilizer-to-water map:
              49 53 8
              0 11 42
              42 0 7
              57 7 4

              water-to-light map:
              88 18 7
              18 25 70

              light-to-temperature map:
              45 77 23
              81 45 19
              68 64 13

              temperature-to-humidity map:
              0 69 1
              1 0 69

              humidity-to-location map:
              60 56 37
              56 93 4
              """
              |> String.split("\n")
              |> Enum.reject(& &1 == "")


  describe "parse_data/1" do
    test "works" do
      assert {_seeds, maps} = @test_input |> Solution.parse_data()
      assert 7 = length(maps)
    end
  end
 
  describe "solve!/1" do
    test "works" do
      assert MapSet.new([82, 43, 86, 35]) == MapSet.new(@test_input |> Solution.parse_data() |> Solution.solve!())
    end
  end
end
