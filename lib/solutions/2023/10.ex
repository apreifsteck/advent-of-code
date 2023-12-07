defmodule AdventOfCode.Solutions.Y2023.S10 do
  use AdventOfCode.Solution, use_prior_solution: true

  @moduledoc """
  Everyone will starve if you only plant such a small number of seeds. Re-reading the almanac, it looks like the seeds: line actually describes ranges of seed numbers.

  The values on the initial seeds: line come in pairs. Within each pair, the first value is the start of the range and the second value is the length of the range. So, in the first line of the example above:

  seeds: 79 14 55 13
  This line describes two ranges of seed numbers to be planted in the garden. The first range starts with seed number 79 and contains 14 values: 79, 80, ..., 91, 92. The second range starts with seed number 55 and contains 13 values: 55, 56, ..., 66, 67.

  Now, rather than considering four seed numbers, you need to consider a total of 27 seed numbers.

  In the above example, the lowest location number can be obtained from seed number 82, which corresponds to soil 84, fertilizer 84, water 84, light 77, temperature 45, humidity 46, and location 46. So, the lowest location number is 46.

  Consider all of the initial seed numbers listed in the ranges on the first line of the almanac. What is the lowest location number that corresponds to any of the initial seed numbers?  
  """

  def solve!({seeds, maps}) do
    # Since the interpretation of the input has changed a bit, we will need to do some additional massaging
    # of the input
    maps = parse(maps)
    seed_ranges = get_seed_ranges(seeds) 
    |> hd() 
    |> List.wrap()
    |> Enum.flat_map(&get_interval_mappings_for_interval(&1, hd(maps)))

    maps = [seed_ranges | tl(maps)] |> dbg()

    compute_interval_mappings(maps)
    # |> dbg()
    # After this data will have the format of [{{s_start, s_end}, {d_start, d_end}}],
    # where s is source and starts with location, and d is destination and starts with humidity
    # so we're traversing the mappings backwards now  
    # get_interval_mappings_for_interval()
    # seed_ranges
    # |> Enum.flat_map(&get_interval_mappings_for_interval(&1, hd(maps), fn i, _ -> i end))
    # |> add_edge_set(Graph.new())
    # |> dbg()
    # |> then(&compute_interval_mappings(maps, &1))

    # starting with the intervals on the locations we're going to map those to other intervals
    # for each map in turn
    # compute_interval_mappings(maps)

    # For all edge pairs in the locations
    # 1. Add edge pair ({a, b}) to the graph. 
    # 2. For node b, get the intervals that it may map to N_b
    # 2a.  These should be the source intervals in the next item in the list of maps
    # 3. for all N_b, find the interval shift
    # 4. add an edge from b to all N_b
    # 5. For all N_b, go to step 2
  end

  def compute_interval_mappings(maps, g \\ Graph.new())

  def compute_interval_mappings([last], g) do
    add_edge_set(last, g)
  end

  def compute_interval_mappings([current_map, next | rest], g) do
    # add source-destination key pairs to the graph
    updated_graph = add_edge_set(current_map, g)

    current_intervals = Enum.map(current_map, &elem(&1, 1))
    # fan out sub intervals mappings for the current intervals
    sub_intervals = Enum.map(current_intervals, &get_interval_mappings_for_interval(&1, next)) |> dbg()

    updated_graph =
      current_intervals
      # the sub intervals contain the intervals that the current 
      |> Enum.zip(sub_intervals)
      |> Enum.reduce(updated_graph, fn {source_interval, list_of_trasition_intervals}, graph ->
        list_of_trasition_intervals
        |> Enum.map(&elem(&1, 0))
        |> Enum.reduce(graph, &Graph.add_edge(&2, source_interval, &1))
      end)

    # |> dbg()

    # recurse down fanned out paths
    compute_interval_mappings([List.flatten(sub_intervals) | rest], updated_graph)
  end

  defp add_edge_set(map, g) do
    Enum.reduce(map, g, fn {source_interval, dest_interval}, graph ->
      Graph.add_edge(graph, source_interval, dest_interval)
    end)
  end

  def get_interval_mappings_for_interval(current_interval, list_of_intervals, shifter \\ &translate_interval/2) do
    # find the interval in the list (I_b) that corresponds to the start of the given interval (I_a)
    # find where I_b ends.
    # If I_a ends before I_b, we return a single interval of {I_b start, I_b start + len(I_a)}
    # If I_a ends after I_b, we return a list of intervals: [{I_b start, I_b end}, get_interval_mappings_for_interval({I_b end (+1?), I_a end}, list_of_intervals)]
    {current_start, current_end} = current_interval

    {{s_start, s_end} = source_interval, {d_start, d_end} = dest_interval} =
      Enum.find(list_of_intervals, {current_interval, current_interval}, fn {{s_start, s_end}, _} =
                                                                              thing ->
        current_start >= s_start and current_start <= s_end
      end)

    shift = find_shift(source_interval, dest_interval)

    if current_end <= s_end do
      [{current_interval, shifter.(current_interval, shift)}]
    else
      interval = {current_start, s_end}

      [
        {interval, shifter.(interval, shift)}
        | get_interval_mappings_for_interval({s_end + 1, current_end}, list_of_intervals)
      ]
    end
  end

  defp find_shift(source_interval, dest_interval) do
    elem(dest_interval, 0) - elem(source_interval, 0)
  end

  defp translate_interval({start, finish}, shift), do: {start + shift, finish + shift}

  defp get_seed_ranges(seeds) do
    seeds
    |> Enum.chunk_every(2)
    |> Enum.map(fn [start_range, range_len] -> {start_range, start_range + range_len - 1} end)
  end

  defp parse(maps) do
    maps
    |> Enum.map(fn list_of_ranges ->
      Enum.map(list_of_ranges, fn {source_range, destination_range_start} ->
        {source_range_start, source_range_end} = source_range
        destination_range_end = destination_range_start + (source_range_end - source_range_start)
        {source_range, {destination_range_start, destination_range_end}}
      end)
    end)

    # |> Enum.reverse()
  end
end
