defmodule AdventOfCode.Solutions.Y2024.S7 do
  use AdventOfCode.Solution

  @moduledoc """
  """

  def solve!(data) do
    base = data
    rev_base = extract(base, :reverse)

    vertical = extract(base, :vertical)
    rev_vertical = extract(vertical, :reverse)

    diagonal = extract(base, :main_diagonal)
    rev_diagonal = extract(diagonal, :reverse)

    off_diagonal = extract(base, :off_diagonal)
    rev_off_diagonal = extract(off_diagonal, :reverse)

    [
      base,
      rev_base,
      vertical,
      rev_vertical,
      diagonal,
      rev_diagonal,
      off_diagonal,
      rev_off_diagonal
    ]
    |> Stream.flat_map(&Nx.to_list/1)
    |> Stream.map(&to_string/1)
    |> Stream.flat_map(&Regex.scan(~r/XMAS/, &1))
    |> Enum.to_list()
    |> Enum.count()
  end

  def parse_data(data) do
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
    base =
      data
      |> Enum.to_list()
      |> Enum.map(fn string ->
        string
        |> String.trim()
        |> String.to_charlist()
      end)
      |> Nx.tensor(names: [:row, :col])
  end

  def extract(data, :vertical) do
    Nx.transpose(data)
  end

  def extract(data, :main_diagonal) do
    {rows, _cols} = Nx.shape(data)
    bound = rows - 1

    for offset <- -bound..bound do
      # as bound increases, we should pad mode and more
      Nx.take_diagonal(data, offset: offset)
      |> Nx.pad(117, [{0, abs(offset), 0}])
    end
    |> Nx.stack()
  end

  def extract(data, :off_diagonal) do
    data
    |> Nx.reverse(axes: [:col])
    |> extract(:main_diagonal)
  end

  def extract(data, :reverse) do
    Nx.reverse(data, axes: [1])
  end

  def data_as_tensor(data) do
    data
    |> Enum.to_list()
    |> Enum.map(fn string ->
      string
      |> String.trim()
      |> String.to_charlist()
    end)
    |> Nx.tensor(names: [:row, :col])
  end
end
