defmodule AdventOfCode.Solutions.Y2023.S14 do
  use AdventOfCode.Solution

  @moduledoc """
  """

  @card_ranking ~w(A K Q T 9 8 7 6 5 4 3 2 J)a
  @hand_ranking ~w(five_of_a_kind four_of_a_kind full_house three_of_a_kind two_pair one_pair high_card)a
  defstruct hand: [], bid: 0, hand_type: :none

  def solve!(data) do
    data
    |> Enum.sort_by(&Function.identity/1, __MODULE__)
    |> Enum.reverse()
    |> Enum.with_index(1)
    |> Enum.reduce(0, fn {hand, rank}, acc -> hand.bid * rank + acc end)
  end

  def parse_data(data) do
    data
    |> Stream.map(fn line ->
      [hand, bid] = String.split(line)

      hand =
        hand
        |> String.split("")
        |> Enum.reject(&(&1 == ""))
        |> Enum.map(&String.to_existing_atom/1)

      %__MODULE__{hand: hand, bid: String.to_integer(bid), hand_type: hand_type(hand)}
    end)
    |> Enum.to_list()
  end

  defp hand_type([a, b, c, d, e] = hand) when a == b and b == c and c == d and d == e do
    :five_of_a_kind
  end

  defp hand_type(hand) do
    kinds_lengths =
      hand
      |> Enum.group_by(&Function.identity/1)
      |> Enum.to_list()
      |> Enum.map(fn {k, v} -> {k, length(v)} end)
      |> Map.new()

    {num_jokers, kinds} = Map.pop(kinds_lengths, :J, 0)

    # most of a kind not joker
    {kind, _num} =
      kinds_lengths
      |> Map.filter(fn {k, _} -> k != :J end)
      |> Enum.sort_by(&elem(&1, 1), :desc)
      |> hd()

    kinds = Map.update!(kinds, kind, &(&1 + num_jokers)) |> Map.values() |> Enum.sort(:desc)

    case kinds do
      [5] -> :five_of_a_kind
      [4, 1] -> :four_of_a_kind
      [3, 2] -> :full_house
      [3, 1, 1] -> :three_of_a_kind
      [2, 2, 1] -> :two_pair
      [2, 1, 1, 1] -> :one_pair
      _ -> :high_card
    end
  end

  def compare(a, b) do
    get_hand_rank = &Enum.find_index(@hand_ranking, fn elem -> elem == &1.hand_type end)

    case {get_hand_rank.(a), get_hand_rank.(b)} do
      {r1, r2} when r1 > r2 -> :gt
      {r1, r2} when r1 < r2 -> :lt
      _ -> break_tie(a.hand, b.hand)
    end
  end

  defp break_tie(hand_a, hand_b) do
    get_card_rank = &Enum.find_index(@card_ranking, fn elem -> elem == &1 end)

    Enum.zip(hand_a, hand_b)
    |> Enum.map(fn {a_card, b_card} -> {get_card_rank.(a_card), get_card_rank.(b_card)} end)
    |> Enum.find(fn {a_rank, b_rank} -> a_rank != b_rank end)
    |> case do
      {r1, r2} when r1 > r2 -> :gt
      {r1, r2} when r1 < r2 -> :lt
      _ -> :eq
    end
  end
end
