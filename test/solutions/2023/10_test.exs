defmodule AdventOfCode.Solutions.Y2023.S10Test do
  use ExUnit.Case, asnyc: true
  alias AdventOfCode.Solutions.Y2023.S10, as: Solution

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

 
  describe "solve!/1" do
    test "works" do
      g = @test_input |> Solution.parse_data() |> Solution.solve!()
      # [
      #   {{60, 96}, {56, 92}},
      #   {{56, 59}, {93, 96}},
      #   {{56, 92}, {56, 69}},
      #   {{56, 92}, {70, 92}},
      #   {{93, 96}, {93, 96}},
      #   {{56, 69}, {55, 68}},
      #   {{70, 92}, {70, 92}}
      # ]
      # |> Enum.each(fn {v1, v2} -> assert Graph.edge(g, v1, v2) end)
      g
      |> Graph.reachable([{79, 79 + 13}])
      |> Enum.filter(&(Graph.out_degree(g, &1) == 0))
      |> dbg()
    end
  end

  describe "get_interval_mappings_for_interval/1" do
    test "detects a split" do
      assert [{{56, 69}, {55, 68}}, {{70, 92}, {70, 92}}] = Solution.get_interval_mappings_for_interval({56, 92}, [
          {{0, 0}, {69, 69}},
          {{1, 69}, {0, 68}}
        ])
    end

    test "passes through when required" do
      assert [{55, 67}] = Solution.get_interval_mappings_for_interval({55, 67}, [
       {45, 67},
        {81, 99},
        {68, 80}
      ])
    end
  end
end
