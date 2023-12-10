defmodule AdventOfCode.Solutions.Y2023.S16 do
  use AdventOfCode.Solution, use_prior_solution: true

  @moduledoc """
  """

  def solve!({instructions, paths}) do
    starting_path_set = Graph.vertices(paths) |> verticies_ending_with("A")

    starting_path_set
    |> Enum.map(&find_steps_for_start_node(paths, &1, instructions))
    |> Enum.reduce(&lcm/2)
    |> dbg()

  end

  defp get_direction("L"), do: :left
  defp get_direction("R"), do: :right

  defp find_steps_for_start_node(paths, start_node, instructions) do
    instructions
    |> Enum.reduce_while(
      {0, start_node},
      fn instruction, {path_len, current_node} ->
        if ends_in_z?(current_node) do
          {:halt, path_len}
        else
          direction = get_direction(instruction)

          next_node = get_next_node_by_direction(paths, current_node, direction)

          {:cont, {path_len + 1, next_node}}
        end
      end
    )
  end

  defp get_next_node_by_direction(paths, node, direction) do
    next_node =
      paths
      |> Graph.out_neighbors(node)
      |> Enum.find(fn node_name ->
        case Graph.edges(paths, node, node_name) do
          [one] -> one.label == direction
          [left, right] when left.label == direction -> left
          [_left, right] -> right.label == direction
        end
      end)
  end


  defp verticies_ending_with(verticies, letter) do
    verticies
    |> Enum.filter(fn
      <<starting::binary-size(2), last_letter::binary>> -> letter == last_letter
    end)
  end

  defp ends_in_z?(<<starting::binary-size(2), "Z">>), do: true
  defp ends_in_z?(_), do: false


  def gcd(a, 0), do: a
	def gcd(0, b), do: b
	def gcd(a, b), do: gcd(b, rem(a,b))
	
	def lcm(0, 0), do: 0
	def lcm(a, b), do: Integer.floor_div((a*b), gcd(a,b))
end
