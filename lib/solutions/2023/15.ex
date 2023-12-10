defmodule AdventOfCode.Solutions.Y2023.S15 do
  use AdventOfCode.Solution

  @moduledoc """
  """

  def solve!({instructions, paths}) do
    instructions
    |> Enum.reduce_while({0, "AAA"}, fn
      _, {path_len, "ZZZ"} ->
        {:halt, path_len}

      instruction, {path_len, current_node} ->
        direction = get_direction(instruction)

        next_node =
          paths
          |> Graph.out_neighbors(current_node)
          |> Enum.find(fn node_name ->
            case Graph.edges(paths, current_node, node_name) do
              [one] -> one.label == direction
              [left, right] when left.label == direction -> left
              [_left, right] -> right.label == direction
            end
          end)

        {:cont, {path_len + 1, next_node}}
    end)
  end

  defp get_direction("L"), do: :left
  defp get_direction("R"), do: :right

  def parse_data(data) do
    data =
      data
      |> Stream.map(&String.trim/1)
      |> Enum.reject(&(&1 == "" or &1 == "\n"))
      |> Enum.to_list()
      # |> dbg()

    instructions =
      data
      |> hd()
      |> String.split("")
      |> Enum.reject(&(&1 == ""))
      |> Stream.cycle()

    paths =
      data
      |> tl()
      |> Enum.map(&parse_path/1)
      |> Enum.reduce(Graph.new(), fn {node, left, right}, graph ->
        graph
        |> Graph.add_edge(node, left, label: :left)
        |> Graph.add_edge(node, right, label: :right)
      end)

    {instructions, paths}
  end

  defp parse_path(
         <<node::binary-size(3), " = (", left::binary-size(3), ", ", right::binary-size(3),
           _rest::binary>>
       ) do
    {node, left, right}
  end
end
