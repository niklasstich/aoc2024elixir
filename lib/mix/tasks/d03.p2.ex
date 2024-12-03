defmodule Mix.Tasks.D03.P2 do
  use Mix.Task

  import AdventOfCode.Day03
  import AdventOfCode.Input

  @shortdoc "Day 03 Part 2"
  def run(args) do
    input = get!(3)
    # input = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_2: fn -> input |> part2() end}),
      else:
        input
        |> part2()
        |> IO.inspect(label: "Part 2 Results")
  end
end
