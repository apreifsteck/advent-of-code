defmodule AdventOfCode.Solutions do
  @spec get_solution(day :: integer(), [year: integer()] | nil) :: integer()
  def get_solution(day, options \\ %{}) do
    year = options[:year] || NaiveDateTime.utc_now().year

    sol_module_list = [__MODULE__, "Y#{year}", "S#{day}"]

    sol_module =
      try do
        Module.safe_concat(sol_module_list)
      catch
        :error, :badarg ->
          raise ArgumentError, "Solution module for day #{day} and year #{year} does not exist"
      end

    AdventOfCode.Solution.solve(sol_module)
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

  defp get_sol_num_and_year_from_module(module) do
    [day, year] =
      module
      |> Module.split()
      |> Enum.reverse()
      |> Enum.take(2)
      |> Enum.map(&String.trim_leading(&1, "Y"))
      |> Enum.map(&String.trim_leading(&1, "S"))
      |> Enum.map(&String.to_integer/1)

    {day, year}
  end

  defp get_solution_number_from_module(mod) do
    mod
    |> get_sol_num_and_year_from_module()
    |> elem(0)
  end

  def get_year_from_module(mod) do
    mod
    |> get_sol_num_and_year_from_module()
    |> elem(1)
  end

  @doc """
  gets the integer day number from variable sources, including
  module names or bare integers
  """
  @spec get_day_from_sol(module()) :: integer()
  def get_day_from_sol(module) when is_atom(module) do
    module
    |> get_solution_number_from_module()
    |> get_day_from_sol()
  end

  def get_day_from_sol(sol) when is_integer(sol) do
    sol
    |> Kernel./(2)
    |> Float.round()
    |> trunc
  end
end
