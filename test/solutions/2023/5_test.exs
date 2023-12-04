defmodule AdventOfCode.Solutions.Y2023.S5Test do
  use ExUnit.Case, asnyc: true
  alias AdventOfCode.Solutions.Y2023.S5, as: Solution

  @test_input """
              467..114..
              ...*......
              ..35..633.
              ......#...
              617*......
              .....+.58.
              ..592.....
              ......755.
              ...$.*....
              .664.598..
              """
              |> String.split("\n")
              |> Enum.reject(&(&1 == ""))


  describe "get_domain_from_indexes" do
    test "works" do
      # top mid, one row
      assert [4, 5, 6] = Solution.get_domain_from_indexes(0, 5, {1, 10}) 
      # top mid, two rows
      assert [4, 5, 6, 14, 15, 16] = Solution.get_domain_from_indexes(0, 5, {2, 10}) 
      # top_right, two rows
      assert [8, 9, 18, 19] = Solution.get_domain_from_indexes(0, 9, {2, 10})
      # mid_left, three rows
      assert [0, 1, 10, 11, 20, 21] = Solution.get_domain_from_indexes(1, 0, {3, 10})
      # mid, three rows
      assert [4, 5, 6, 14, 15, 16, 24, 25, 26] = Solution.get_domain_from_indexes(1, 5, {3, 10})
    end
  end
  describe "parse_data/1" do
    test "accepts garbage" do
      # assert [
      #          %Solution{
      #            parts: []
      #          }
      #        ] = 
      input = ".....*...."
      assert String.length(input) == Solution.parse_data([input]) |> length() |> dbg()

      # assert [] = Solution.parse_data([])
    end

    test "works" do
      @test_input |> Solution.parse_data() |> dbg()
    end

    # test "multiple symbols in a row are each their own part" do
    #   assert [
    #            %Solution{
    #              parts: [
    #                %Solution.Part{data: "*", start_index: 3},
    #                %Solution.Part{data: "#", start_index: 4},
    #                %Solution.Part{data: "@", start_index: 5}
    #              ]
    #            }
    #          ] = Solution.parse_data(["...*#@..."])
    # end

    # test "typical case works" do
    #   assert [
    #            %Solution{
    #              parts: [
    #                %Solution.Part{data: "123", start_index: 2, end_index: 4},
    #                %Solution.Part{data: "456", start_index: 7, end_index: 9}
    #              ]
    #            }
    #          ] = Solution.parse_data(["..123..456..."])
    # end

    # test "leading with a number" do
    #   assert [
    #            %Solution{
    #              parts: [
    #                %Solution.Part{data: "617", start_index: 0, end_index: 2},
    #                %Solution.Part{data: "*", start_index: 3, end_index: 3}
    #              ]
    #            }
    #          ] = Solution.parse_data(["617*......"])
    # end

    # test "trailing a number" do
    #   assert [
    #            %Solution{
    #              parts: [
    #                %Solution.Part{data: "123"},
    #                %Solution.Part{data: "*"},
    #                %Solution.Part{data: "617"}
    #              ]
    #            }
    #          ] = Solution.parse_data(["123.*617......"])
    # end

    test "full input" do
      # |> dbg()
      @test_input |> Solution.parse_data()
    end
  end

  describe "solve!/1" do
    test "works" do
      # assert nil = ["617*......"] |> Solution.parse_data() |> Solution.solve!()
      assert assert 4361 == @test_input |> Solution.parse_data() |> Solution.solve!()
    end

    test "Some problem cases" do
      input = """
      361.....
      ...*313.
      """

      assert 674 ==
               input
               |> String.split("\n")
               |> Enum.reject(&(&1 == ""))
               |> Solution.parse_data()
               |> Solution.solve!()
    end

    test "symbols with overlapping don't double count numbers" do
      input = """
      ***#
      123@
      *4#.
      """

      assert 127 ==
               input
               |> String.split("\n")
               |> Enum.reject(&(&1 == ""))
               |> Solution.parse_data()
               |> Solution.solve!()
    end

    test "trying stuff out" do
      # input = """
      # ..521......388.........116.....33.............2...........519..717..859..............&....*....*881.*...109...............828...............
      # ................................*...927.........................*.....................240....66.....27.......482.227*...................#968
      # ...$479...........91*...%.......598........102../.........615.....184..@......456.385....................+.....*.....476...13+...391........
      # """

      # assert Enum.sum([479, 91, 33, 598, 717, 240, 66, 881, 27, 482, 227, 476, 13, 968]) ==

      input = """
      123.
      *4..
      .12.
      ..3.
      ...1
      """

      assert 127 + 12 ==
               input
               |> String.split("\n")
               |> Enum.reject(&(&1 == ""))
               |> Solution.parse_data()
               |> Solution.solve!()
    end
  end
end
