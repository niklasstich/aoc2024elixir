defmodule Mix.Tasks.D09.P2 do
  use Mix.Task

  import AdventOfCode.Day09
  import AdventOfCode.Input

  @shortdoc "Day 09 Part 2"
  def run(args) do
    # input = get!(9)
    input = "2333133121414131402"

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_2: fn -> input |> part2() end}),
      else:
        input
        |> part2()
        |> IO.inspect(label: "Part 2 Results")
  end
end
