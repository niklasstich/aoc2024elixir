defmodule Mix.Tasks.D06.P1 do
  use Mix.Task

  import AdventOfCode.Day06
  import AdventOfCode.Input

  @shortdoc "Day 06 Part 1"
  def run(args) do
    input = get!(6)
#     input = """
# ....#.....
# .........#
# ..........
# ..#.......
# .......#..
# ..........
# .#..^.....
# ........#.
# #.........
# ......#...
# """

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_1: fn -> input |> part1() end}),
      else:
        input
        |> part1()
        |> IO.inspect(label: "Part 1 Results")
  end
end
