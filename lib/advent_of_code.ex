defmodule AdventOfCode do
  @moduledoc """
  Documentation for `AdventOfCode`.
  """

  def main(argv) do
    %Optimus.ParseResult{args: %{puzzle_number: puzzle_number}, options: opts} =
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
        ],
        options: [
          year: [
            value_name: "year",
            short: "-y",
            long: "--year",
            help: "The year of the puzzle solution you want",
            required: false,
            parser: :integer,
            default: NaiveDateTime.utc_now().year
          ]
        ]
      )
      |> Optimus.parse!(argv)

    IO.puts(__MODULE__.Solutions.get_solution(puzzle_number, opts))
  end
end
