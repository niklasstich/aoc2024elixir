defmodule Mix.Tasks.D08.P1 do
  use Mix.Task

  import AdventOfCode.Day08
  import AdventOfCode.Input

  @shortdoc "Day 08 Part 1"
  def run(args) do
    input = get!(8)
#     input =
# """
# ............
# ........0...
# .....0......
# .......0....
# ....0.......
# ......A.....
# ............
# ............
# ........A...
# .........A..
# ............
# ............
# """

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_1: fn -> input |> part1() end}),
      else:
        input
        |> part1()
        |> IO.inspect(label: "Part 1 Results")
  end
end
