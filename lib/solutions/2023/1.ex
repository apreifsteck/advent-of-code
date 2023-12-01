defmodule AdventOfCode.Solutions.Y2023.S1 do
	use AdventOfCode.Solution

  @moduledoc """
  The newly-improved calibration document consists of lines of text; each line originally contained a specific calibration value that the Elves now need to recover. On each line, the calibration value can be found by combining the first digit and the last digit (in that order) to form a single two-digit number.

  For example:

  1abc2
  pqr3stu8vwx
  a1b2c3d4e5f
  treb7uchet
  In this example, the calibration values of these four lines are 12, 38, 15, and 77. Adding these together produces 142.

  Consider your entire calibration document. What is the sum of all of the calibration values?
  """
  
  def solve!(data) do
    data
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(&Enum.reject(&1, fn x -> x in ?a..?z end))
    |> Enum.map(fn 
      [h] -> [h, h]
      [h | tl] -> [h, List.last(tl)]
    end)
    |> Enum.map(&IO.chardata_to_string/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end
  
  def parse_data(data) do
    data
    |> Stream.flat_map(&String.split/1)
  end
end
