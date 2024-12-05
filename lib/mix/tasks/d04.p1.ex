defmodule Mix.Tasks.D04.P1 do
  use Mix.Task

  import AdventOfCode.Day04
  import AdventOfCode.Input

  @shortdoc "Day 04 Part 1"
  def run(args) do
    input = get!(4)
#     input = """
# MMMSXXMASM
# MSAMXMSMSA
# AMXSXMAAMM
# MSAMASMSMX
# XMASAMXAMM
# XXAMMXXAMA
# SMSMSASXSS
# SAXAMASAAA
# MAMMMXMMMM
# MXMXAXMASX
# """

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_1: fn -> input |> part1() end}),
      else:
        input
        |> part1()
        |> IO.inspect(label: "Part 1 Results")
  end
end
