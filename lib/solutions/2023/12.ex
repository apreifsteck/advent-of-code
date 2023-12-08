defmodule AdventOfCode.Solutions.Y2023.S12 do
use AdventOfCode.Solution
 
  @moduledoc """
  """

  def solve!({race_time, record}) do
    race_time
    |> find_hold_durations_to_beat_record(record)
    |> Range.size()
    # data
    # |> Enum.map(&find_hold_durations_to_beat_record(elem(&1, 0), elem(&1, 1)))
    # |> Enum.map(&Range.size/1)
  end

  def parse_data(data) do
    [race_time, record] =  
    data
    |> Enum.map(&String.trim_leading(&1, "Time:"))
    |> Enum.map(&String.trim_leading(&1, "Distance:"))
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split/1)
    |> Enum.map(&Enum.join/1)
    |> Enum.map(&String.to_integer/1)

    {race_time, record}
  end

  defp find_hold_durations_to_beat_record(race_time, record) do
    hold_times = 0..Integer.floor_div(race_time, 2)

    minimum_hold_duration =
      Enum.find(hold_times, fn hold_time ->
        0 < -(hold_time ** 2) + race_time * hold_time - record
      end)
    maximum_hold_duration = race_time - minimum_hold_duration
    minimum_hold_duration..maximum_hold_duration
  end

 
end
