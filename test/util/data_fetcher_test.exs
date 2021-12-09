defmodule AdventOfCode.DataFetcherTest do
  alias AdventOfCode.DataFetcher, as: Fetcher
  use ExUnit.Case

  describe "fetch_data/1" do
    test "fetches data for a given day" do
      assert %File.Stream{} = Fetcher.get_data(1)
    end
  end
end
