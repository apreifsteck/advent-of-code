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

  describe "parse_data/1" do
    test "accepts garbage" do
      assert [
               %Solution{
                 parts: []
               }
             ] = Solution.parse_data([".........."])

      assert [] = Solution.parse_data([])
    end

    test "multiple symbols in a row are each their own part" do
      assert [
               %Solution{
                 parts: [
                   %Solution.Part{data: "*", start_index: 3},
                   %Solution.Part{data: "#", start_index: 4},
                   %Solution.Part{data: "@", start_index: 5}
                 ]
               }
             ] = Solution.parse_data(["...*#@..."])
    end

    test "typical case works" do
      assert [
               %Solution{
                 parts: [
                   %Solution.Part{data: "123", start_index: 2, end_index: 4},
                   %Solution.Part{data: "456", start_index: 7, end_index: 9}
                 ]
               }
             ] = Solution.parse_data(["..123..456..."])
    end

    test "leading with a number" do
      assert [
               %Solution{
                 parts: [
                   %Solution.Part{data: "617", start_index: 0, end_index: 2},
                   %Solution.Part{data: "*", start_index: 3, end_index: 3}
                 ]
               }
             ] = Solution.parse_data(["617*......"])
    end

    test "trailing a number" do
      assert [
               %Solution{
                 parts: [
                   %Solution.Part{data: "123"},
                   %Solution.Part{data: "*"},
                   %Solution.Part{data: "617"}
                 ]
               }
             ] = Solution.parse_data(["123.*617......"])
    end

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
