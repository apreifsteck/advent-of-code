defmodule AdventOfCode.Solutions.Y2023.S2 do
  use AdventOfCode.Solution, use_prior_solution: true

  @moduledoc """
  Your calculation isn't quite right. It looks like some of the digits are actually spelled out with letters: one, two, three, four, five, six, seven, eight, and nine also count as valid "digits".

  Equipped with this new information, you now need to find the real first and last digit on each line. For example:

  two1nine
  eightwothree
  abcone2threexyz
  xtwone3four
  4nineeightseven2
  zoneight234
  7pqrstsixteen
  In this example, the calibration values are 29, 83, 13, 24, 42, 14, and 76. Adding these together produces 281.

  What is the sum of all of the calibration values?
  """

  @translator %{
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9"
  }

  def solve!(data) do
    data
    |> Stream.map(&tokenize/1)
    |> Stream.map(fn
      [h] -> [h, h]
      [h | tl] -> [h, List.last(tl)]
    end)
    |> Stream.map(&IO.chardata_to_string/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.sum()
  end

  # We want a greedy match
  # Something that replaces the earliest occurence of a 
  # match with it's corresponding numerical representationt
  def tokenize(string, valid_tokens \\ [], current_tokens \\ [])
  def tokenize("", valid_tokens, _current_tokens) do
    valid_tokens |> Enum.reverse() 
  end
  def tokenize(string, valid_tokens, current_tokens) do
    {token, string} = String.next_codepoint(string)
    current_token_string = 
      [token | current_tokens]
      |> Enum.reverse()
      |> Enum.join("")

    cond do
      Integer.parse(token) != :error -> 
        tokenize(string, [token | valid_tokens], [])
      contains_digit?(current_token_string) ->
        tokenize(string, [extract_digit(current_token_string) | valid_tokens], [token])
      true -> 
        tokenize(string, valid_tokens, [token | current_tokens])
    end
  end

  def contains_digit?(string) do
    @translator
    |> Map.keys()
    |> Enum.any?(&String.contains?(string, &1))
  end

  def extract_digit(string) do
    @translator
    |> Map.keys()
    |> Enum.find(&String.contains?(string, &1))
    |> then(&Map.fetch!(@translator, &1))
  end
end
