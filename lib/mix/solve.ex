defmodule Mix.Tasks.Solve do
  {:ok, _} = Application.ensure_all_started(:req)
  @shortdoc "Runs the solution for the given day and year"
  use Mix.Task
  require Mix.Generator

  @impl Mix.Task
  def run(args) do
    %Optimus.ParseResult{args: %{solution_number: solution_number}, options: %{year: year}} =
      Optimus.new!(
        name: "solution_runner",
        allow_unknown_args: false,
        args: [
          solution_number: [
            value_name: "solution_number",
            help: "The problem number to generate solution for",
            required: true,
            parser: :integer
          ]
        ],
        options: [
          year: [
            value_name: "year",
            short: "-y",
            help: "The year of the puzzle solution you want",
            required: false,
            parser: :integer,
            default: NaiveDateTime.utc_now().year |> Integer.to_string()
          ]
        ]
      )
      |> Optimus.parse!(args)

      solution_number
      |> AdventOfCode.Solutions.get_day_from_sol()
      |> AdventOfCode.DataFetcher.download_data(year)

      IO.puts(AdventOfCode.Solutions.get_solution(solution_number, year: year))
  end
end
