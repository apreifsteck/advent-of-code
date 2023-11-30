defmodule AdventOfCode.Solution do
  @doc """
  solves and returns the solution for the given day
  """
  @callback solve!() :: String.t()

  @doc """
  Solves a the given problem for a different dataset
  """
  @callback solve!(data :: term) :: String.t()

  @callback parse_data(data :: term) :: term
  @optional_callbacks parse_data: 1

  defmacro __using__(opts \\ [use_prior_solution: false]) do
    impl = 
      if opts[:use_prior_solution] do
        quote do 
          def parse_data(data), do: AdventOfCode.Solutions.get_prior_solution_module(__MODULE__).parse_data(data)
        end 
      else
        quote do 
          def parse_data(_data), do: (raise ArgumentError, "parse_data!/1 must be implemented")
        end 
      end

  	quote location: :keep do
      @behaviour AdventOfCode.Solution

      @impl true
      def solve!() do
        AdventOfCode.Solutions.get_day_from_sol(__MODULE__)
        |> AdventOfCode.DataFetcher.get_data()
        |> parse_data()
        |> solve!()
      end

      @impl true
      def solve!(data), do: (raise ArgumentError, "solve!/1 must be implemented" )
      @impl true
      unquote(impl)

      defoverridable([solve!: 1, parse_data: 1])
    end
  end

  def solve(implenentation), do: implenentation.solve!()
  def solve(implementation, data), do: implementation.solve!(data)
end
