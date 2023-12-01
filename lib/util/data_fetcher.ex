defmodule AdventOfCode.DataFetcher do
  def get_data(day, year) do
    url = "https://adventofcode.com/#{inspect(year)}/day/#{inspect(day)}/input"

    filename =
      File.cwd!()
      |> Path.join(relative_file_name(day, year))

    if not File.exists?(filename) do
      cookie = System.fetch_env!("AOC_COOKIE")
      Req.get!(url,
        headers: [{"Cookie", cookie}],
        into: File.stream!(filename),
        compressed: false
      )
    end

    File.stream!(filename)
  end

  defp relative_file_name(day, year), do: "problem_input/#{year}/#{day}.txt"
end
