defmodule AdventOfCode.Solutions.Y2023.S13Test do
  use ExUnit.Case, asnyc: true
  alias AdventOfCode.Solutions.Y2023.S13, as: Solution

  @test_input """
              32T3K 765
              T55J5 684
              KK677 28
              KTJJT 220
              QQQJA 483
              """
              |> String.split("\n")
              |> Enum.reject(& &1 == "")

  describe "parse_data/1" do
    test "works" do
      assert [
        %{hand: ~w(3 2 T 3 K)a, bid: 765, hand_type: :one_pair},
        %{hand: ~w(T 5 5 J 5)a, bid: 684, hand_type: :three_of_a_kind},
        %{hand: ~w(K K 6 7 7)a, bid: 28, hand_type: :two_pair},
        %{hand: ~w(K T J J T)a, bid: 220, hand_type: :two_pair},
        %{hand: ~w(Q Q Q J A)a, bid: 483, hand_type: :three_of_a_kind}
      ] = @test_input |> Solution.parse_data()
    end
  end

  describe "solve!/1" do
    test "works" do
      assert 6440 = @test_input |> Solution.parse_data() |> Solution.solve!()
    end
  end
end
