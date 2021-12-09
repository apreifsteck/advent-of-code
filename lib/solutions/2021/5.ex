defmodule AdventOfCode.Solutions.Y2021.S5 do
  @moduledoc """

  """
  @behaviour AdventOfCode.Solution

  alias AdventOfCode.DataFetcher

  @impl true
  def parse_data(data) do
    data
    |> Stream.map(&String.trim/1)
    |> Stream.map(&get_digits/1)
  end

  defp get_digits(string) do
    string
    |> String.split("")
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&String.to_integer/1)
  end

  @impl true
  def solve!() do
    3
    |> DataFetcher.get_data()
    |> parse_data()
    |> solve!()
  end

  @impl true
  def solve!(data) do
    gamma_bin = gamma_bin(data)

    epsilon =
      gamma_bin
      |> epsilon_bin()
      |> Integer.undigits(2)

    gamma = Integer.undigits(gamma_bin, 2)

    (gamma * epsilon) |> Integer.to_string()
  end

  def gamma_bin(data) do
    summed_digits_base =
      data
      |> Enum.take(1)
      |> hd()
      |> length()
      |> then(fn len -> Enum.take(Stream.cycle([0]), len) end)

    data_length = Enum.count(data)

    data
    |> Enum.reduce(summed_digits_base, fn digit_list, summed_digits ->
      Enum.zip_reduce(digit_list, summed_digits, [], fn left, right, acc ->
        [left + right | acc]
      end)
      |> Enum.reverse()
    end)
    |> Enum.map(&if &1 >= data_length / 2, do: 1, else: 0)
  end

  def epsilon_bin(gamma_bin) do
    gamma_bin
    |> Enum.map(&(&1 - 1))
    |> Enum.map(&abs/1)
  end
end
