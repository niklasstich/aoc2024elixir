defmodule Mix.Tasks.D02.P1 do
  use Mix.Task

  import AdventOfCode.Day02
  import AdventOfCode.Input

  @shortdoc "Day 02 Part 1"
  def run(args) do
    input = get!(2)
#     input = """
# 7 6 4 2 1
# 1 2 7 8 9
# 9 7 6 2 1
# 1 3 2 4 5
# 8 6 4 4 1
# 1 3 6 7 9
# """

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_1: fn -> input |> part1() end}),
      else:
        input
        |> part1()
        |> IO.inspect(label: "Part 1 Results")
  end
end
