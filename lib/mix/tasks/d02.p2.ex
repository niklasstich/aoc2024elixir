defmodule Mix.Tasks.D02.P2 do
  use Mix.Task

  import AdventOfCode.Day02
  import AdventOfCode.Input

  @shortdoc "Day 02 Part 2"
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
      do: Benchee.run(%{part_2: fn -> input |> part2() end}),
      else:
        input
        |> part2()
        |> IO.inspect(label: "Part 2 Results")
  end
end
