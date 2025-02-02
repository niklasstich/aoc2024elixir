defmodule Mix.Tasks.D01.P2 do
  use Mix.Task

  import AdventOfCode.Day01
  import AdventOfCode.Input

  @shortdoc "Day 01 Part 2"
  def run(args) do
    input = get!(1)
#     input = """
# 3   4
# 4   3
# 2   5
# 1   3
# 3   9
# 3   3
#     """

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_2: fn -> input |> part2() end}),
      else:
        input
        |> part2()
        |> IO.inspect(label: "Part 2 Results")
  end
end
