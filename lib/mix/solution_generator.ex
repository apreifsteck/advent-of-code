defmodule Mix.Tasks.SolutionGenerator do
  @shortdoc "generates solution file and test for a particular day"
  use Mix.Task
  require Mix.Generator

  @impl Mix.Task
  def run(args) do
    %Optimus.ParseResult{args: %{day: day}, options: %{year: year}, flags: %{dryrun: dryrun?}} =
      Optimus.new!(
        name: "aoc_helper",
        allow_unknown_args: false,
        args: [
          day: [
            value_name: "day",
            help: "The problem day to generate template solution and test files for",
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
            default: NaiveDateTime.utc_now().year |> Integer.to_string()
          ]
        ],
        flags: [
          dryrun: [
            short: "-d",
            long: "--dry",
            help: "shows what files will be generated",
            default: false
          ]
        ]
      )
      |> Optimus.parse!(args)

    files_to_generate(day, year)
    |> Enum.each(fn path_list ->
      contents = template_for(path_list)
      path = Path.join(path_list)

      if dryrun? do
        IO.puts("Would create file for: #{path}\n")
        IO.puts(contents)
      else
        Mix.Generator.create_file(path, contents)
      end
    end)
  end

  defp files_to_generate(day, year) do
    base_solution = (day - 1) * 2 + 1
    part_two_solution = Integer.to_string(base_solution + 1)
    base_solution = Integer.to_string(base_solution)

    for base_dir <- ~w(lib test), solution_num <- [base_solution, part_two_solution] do
      case base_dir do
        "test" ->
          [base_dir, "solutions", year, "#{solution_num}_test.exs"]

        _ ->
          [base_dir, "solutions", year, "#{solution_num}.ex"]
      end
    end
  end

  defp template_for(["lib" | rest]) do
    sol_number = rest |> List.last() |> sol_num_from_file_name()
    solution_template(sol_number: sol_number)
  end

  defp template_for(["test" | rest]) do
    sol_number = rest |> List.last() |> sol_num_from_file_name()
    test_template(sol_number: sol_number)
  end

  defp sol_num_from_file_name(filename) do
    String.split(filename, ~r/\.|_/)
    |> hd()
  end

  Mix.Generator.embed_template(:test, """
  defmodule AdventOfCode.Solutions.Y2023.S<%= @sol_number %>Test do
    use ExUnit.Case, asnyc: true
    alias AdventOfCode.Solutions.Y2023.S<%= @sol_number %>, as: Solution

    @test_input \"\"\"
                \"\"\"
                |> String.split("\\n")
                |> Enum.reject(& &1 == "")

  <%= require Integer; if @sol_number |> String.to_integer() |> Integer.is_odd() do%>
    describe "parse_data/1" do
      test "works" do
        assert "" = @test_input |> Solution.parse_data()
      end
    end
  <% end %> 
    describe "solve!/1" do
      test "works" do
        assert nil = @test_input |> Solution.parse_data() |> Solution.solve!()
      end
    end
  end
  """)

  Mix.Generator.embed_template(:solution, """
  defmodule AdventOfCode.Solutions.Y2023.S<%= @sol_number %> do
  <%= require Integer; if @sol_number |> String.to_integer() |> Integer.is_odd() do%>use AdventOfCode.Solution
  <% else %>use AdventOfCode.Solution, use_prior_solution: true
  <% end %> 
    @moduledoc \"\"\"
    \"\"\"

    def solve!(data) do
      data
    end

  <%= require Integer; if @sol_number |> String.to_integer() |> Integer.is_odd() do%>
    def parse_data(data) do
      data
    end
  <% end %> 
  end
  """)
end
