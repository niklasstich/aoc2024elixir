defmodule Mix.Tasks.D03.P1 do
  use Mix.Task

  import AdventOfCode.Day03
  import AdventOfCode.Input

  @shortdoc "Day 03 Part 1"
  def run(args) do
    input = get!(3)
    # input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_1: fn -> input |> part1() end}),
      else:
        input
        |> part1()
        |> IO.inspect(label: "Part 1 Results")
  end
end
