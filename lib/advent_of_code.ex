defmodule AdventOfCode do
  @moduledoc """
  Documentation for `AdventOfCode`.
  """

  def main(argv) do
    %Optimus.ParseResult{args: %{puzzle_number: puzzle_number}} =
      Optimus.new!(
        name: "aoc_helper",
        about:
          "A command line tool to print solutions for the advent of code." <>
            "Overkill? Yes, but I wanted to see how to build a command line app.",
        allow_unknown_args: false,
        args: [
          puzzle_number: [
            value_name: "PUZZLE_NUMBER",
            help: "The puzzle number to give the solution of for the current year",
            required: true,
            parser: :integer,
            default: 0
          ]
        ]
      )
      |> Optimus.parse!(argv)

    get_solution(puzzle_number)
  end

  @doc """
  Hello world.

  ## Examples

      iex> AdventOfCode.hello()
      :world

  """
  def get_solution(day) do
    year = NaiveDateTime.utc_now().year
    year_module_name = String.to_existing_atom("Y#{year}")
    solution_number_atom = String.to_existing_atom("S#{day}")

    [__MODULE__, Solutions, year_module_name, solution_number_atom]
    |> Module.safe_concat()
    |> AdventOfCode.Solution.solve()
  end

  def get_prior_solution_module(module) do
    {solution_header, _last} =
      module
      |> Module.split()
      |> Enum.split(-1)

    solution_header
    |> Enum.join(".")
    |> Module.safe_concat("S#{get_solution_number_from_module(module) - 1}")
  end

  defp get_solution_number_from_module(module) do
    module
    |> Module.split
    |> Enum.reverse()
    |> hd()
    |> String.trim_leading("S")
    |> String.to_integer()
  end

  def get_day_from_sol(module) do
    module
    |> get_solution_number_from_module()
    |> Kernel./(2)
    |> Float.round()
    |> trunc
  end
end
