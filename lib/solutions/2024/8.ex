defmodule AdventOfCode.Solutions.Y2024.S8 do
  use AdventOfCode.Solution, use_prior_solution: true

  @moduledoc """
  """

  def solve!(data) do
    # This time I think we can just use a Nx.window_reduce() function
    # to create a sliding window over the input where we see if the
    # window is equal to the X-MAS. The trick here will be to figure out
    # how to elegantly handle characters we don't care about
    # Maybe we could multiply the input tensor by another tensor that zeros
    # out those positions but leaves the last positions we care about untouched.
    # so
    # [
    #  1 0 1
    #  0 1 0
    #  1 0 1
    # ]
    # The other tricky part is that each MAS can be written forwards or backwards,
    # so that's a total of 4 unique combinations that we'll have to account for as well
    data
  end
end
