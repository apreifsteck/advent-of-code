defmodule AdventOfCode.DataFetcher do
  @type day :: integer()
  @type year :: integer()

  @doc """
  Returns a File Stream to the problem input
  """
  @spec get_data(day(), year()) :: Stream.t()
  def get_data(day, year) do
    day
    |> download_data(year)
    |> File.stream!()
  end

  @doc """
  Downloads the solution from the internet, unless it's already on the system.
  Returns the file location of the problem input.
  """
  @spec download_data(day(), year()) :: :ok
  def download_data(day, year) do
    url = "https://adventofcode.com/#{inspect(year)}/day/#{inspect(day)}/input"

    filename =
      File.cwd!()
      |> Path.join(relative_file_name(day, year))

    if not File.exists?(filename) do
      folder = relative_folder(year)
      !File.exists?(folder) && File.mkdir_p!(folder)

      cookie = System.fetch_env!("AOC_COOKIE")
      Req.get!(url,
        headers: [{"Cookie", "session=#{cookie}"}],
        into: File.stream!(filename),
        compressed: false
      )
    end

    filename
  end

  defp relative_file_name(day, year), do: "#{relative_folder(year)}/#{day}.txt"
  defp relative_folder(year), do: "problem_input/#{year}"
end
