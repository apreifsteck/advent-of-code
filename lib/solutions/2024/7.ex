defmodule AdventOfCode.Solutions.Y2024.S7 do
  use AdventOfCode.Solution

  @moduledoc """
  """

  def solve!(data) do
    data
  end

  def parse_data(data) do
    data
    # This one is a little weird so. You can look forward, backward, up,
    # down, forwards along both diagonals, and backwards along both diagonals.
    # So I think that's... 8 directions in total?
    # Rather than mess with indicies and directions, I think what I'll do
    # is do some memory amplification and copy the input on each direction and then
    # concatenate them all together and search for occurrences of XMAS with
    # each "virtual row"
    #
    # This will make the solution vastly simpler (only have to do a regex
    # search through each row and count the hits) at the cost of multiplying the size of
    # the input by 8 times
  end
end
