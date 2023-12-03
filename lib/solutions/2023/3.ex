defmodule AdventOfCode.Solutions.Y2023.S3 do
  use AdventOfCode.Solution

  @moduledoc """
  As you walk, the Elf shows you a small bag and some cubes which are either red, green, or blue. Each time you play this game, he will hide a secret number of cubes of each color in the bag, and your goal is to figure out information about the number of cubes.

  To get information, once a bag has been loaded with cubes, the Elf will reach into the bag, grab a handful of random cubes, show them to you, and then put them back in the bag. He'll do this a few times per game.

  You play several games and record the information from each game (your puzzle input). Each game is listed with its ID number (like the 11 in Game 11: ...) followed by a semicolon-separated list of subsets of cubes that were revealed from the bag (like 3 red, 5 green, 4 blue).

  For example, the record of a few games might look like this:

  Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
  Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
  Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
  Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
  Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
  In game 1, three sets of cubes are revealed from the bag (and then put back again). The first set is 3 blue cubes and 4 red cubes; the second set is 1 red cube, 2 green cubes, and 6 blue cubes; the third set is only 2 green cubes.

  The Elf would first like to know which games would have been possible if the bag contained only 12 red cubes, 13 green cubes, and 14 blue cubes?

  In the example above, games 1, 2, and 5 would have been possible if the bag had been loaded with that configuration. However, game 3 would have been impossible because at one point the Elf showed you 20 red cubes at once; similarly, game 4 would also have been impossible because the Elf showed you 15 blue cubes at once. If you add up the IDs of the games that would have been possible, you get 8.

  Determine which games would have been possible if the bag had been loaded with only 12 red cubes, 13 green cubes, and 14 blue cubes. What is the sum of the IDs of those games?
  """
  defstruct [:id, draws: []]

  # red, green, blue
  @configuration {12, 13, 14}

  def solve!(data) do
    data
    |> Enum.filter(&possible?(&1, @configuration))
    |> Enum.map(& &1.id)
    |> Enum.sum()
  end

  defp possible?(%__MODULE__{} = self, config) do
    {max_red, max_green, max_blue} = config

    not Enum.any?(self.draws, fn {r, g, b} -> 
      r > max_red or g > max_green or b > max_blue
    end)
  end

  def parse_data(data) do
    data
    |> Enum.reject(& &1 == "")
    |> Enum.map(&String.split(&1, ":"))
    |> Enum.map(&parse_game/1)
  end

  defp parse_game([game_string, draws]) do
    %__MODULE__{
      id: parse_game_num(game_string),
      draws:
        draws
        |> String.split(";")
        |> Enum.map(&String.trim/1)
        |> Enum.map(&parse_draw/1)
        |> Enum.map(fn draw_elems -> Enum.reduce(draw_elems, {0, 0, 0}, &sum_tups/2) end)
    }
  end

  defp parse_draw(draw) do
    draw
    |> String.split(",")
    |> Enum.map(&parse_colors/1)
  end

  defp parse_colors(string) do
    [num, color] = String.split(string)
    num = String.to_integer(num)

    case color do
      "red" -> {num, 0, 0}
      "green" -> {0, num, 0}
      "blue" -> {0, 0, num}
    end
  end

  defp parse_game_num("Game " <> rest) do
    String.to_integer(rest)
  end

  defp sum_tups({a1, b1, c1}, {a2, b2, c2}), do: {a1 + a2, b1 + b2, c1 + c2}
end
