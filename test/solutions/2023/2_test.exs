defmodule AdventOfCode.Solutions.Y2023.S2Test do
  use ExUnit.Case, asnyc: true
  alias AdventOfCode.Solutions.Y2023.S2, as: Solution

  @test_input """
              two1nine
              eightwothree
              abcone2threexyz
              xtwone3four
              4nineeightseven2
              zoneight234
              7pqrstsixteen 
              """
              |> String.split()

  @trouble_input """
                   xtwone3four
                   zoneight234
                 """
                 |> String.split()


  describe "solve!/1" do
    test "works" do
      assert 281 = Solution.solve!(@test_input)
    end

    test "works on hard input" do
      assert (24 + 14) == Solution.solve!(@trouble_input)
    end
  end

  describe "tokenize/1" do
    test "works" do
      cases = [
        {"13jlmhmcnvjzqsnthreeqdslgdlqzlmxgbmvzlsix3", 13},
        {"ppkeightwo5ggthreet", 83},
        {"61365q", 65},
        {"9sevensixrsrgmclkvthkgtxqtwovtlxfrdnllxvsghslh", 92},
        {"seven443six8three31", 71},
        {"two777vrlcxfsmrcnine576", 26},
        {"sevenine", 79}
      ]

      for {input, expected} <- cases do
        assert Solution.solve!(List.wrap(input)) == expected
      end
    end
  end
end
