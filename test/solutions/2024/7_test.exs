defmodule AdventOfCode.Solutions.Y2024.S7Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Solutions.Y2024.S7, as: Solution

  @test_input """
              MMMSXXMASM
              MSAMXMSMSA
              AMXSXMAAMM
              MSAMASMSMX
              XMASAMXAMM
              XXAMMXXAMA
              SMSMSASXSS
              SAXAMASAAA
              MAMMMXMMMM
              MXMXAXMASX
              """
              |> String.split("\n")
              |> Enum.reject(&(&1 == ""))

  describe "extract" do
    test "vertical" do
      data = Solution.data_as_tensor(@test_input)
      vertical = Solution.extract(data, :vertical)
      assert Nx.to_list(data[col: 0]) == Nx.to_list(vertical[0])
    end

    test "reverse" do
      data = Solution.data_as_tensor(@test_input)
      reverse = Solution.extract(data, :reverse)

      assert data[0]
             |> Nx.to_list()
             |> Enum.reverse() ==
               Nx.to_list(reverse[0])
    end

    test "diagonal" do
      data = Solution.data_as_tensor(@test_input)
      diagonal = Solution.extract(data, :main_diagonal)

      assert diagonal
             |> Nx.to_list()
             |> Enum.find(&(&1 == ~c(MSXMAXSAMX))) != nil
    end

    test "off diagonal" do
      data = Solution.data_as_tensor(@test_input)
      off_diagonal = Solution.extract(data, :off_diagonal)

      assert off_diagonal
             |> Nx.to_list()
             |> dbg()
             |> Enum.find(&(&1 == ~c(MSAMMMMXAM))) != nil
    end
  end

  # describe "parse_data/1" do
  #   test "works" do
  #     assert "" = @test_input |> Solution.parse_data()
  #   end
  # end

  describe "solve!/1" do
    test "works" do
      assert 18 = @test_input |> Solution.parse_data() |> Solution.solve!()
    end
  end
end
