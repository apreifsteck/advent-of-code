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

  def solve(implenentation), do: implenentation.solve!()
  def solve(implementation, data), do: implementation.solve!(data)
end
