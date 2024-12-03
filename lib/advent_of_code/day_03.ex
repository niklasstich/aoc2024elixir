defmodule AdventOfCode.Day03 do

  @regex ~r/mul\((\d*),(\d*)\)/
  def mult([_, a, b]) do
    String.to_integer(a) * String.to_integer(b)
  end

  def part1(args) do
    Regex.scan(@regex, args) |> Enum.map(&mult/1) |> Enum.sum()
  end

  def part2(args) do
    args |> String.split("do()") |> Enum.flat_map(& String.split(&1, "don't()") |> Enum.take(1))
      |> Enum.flat_map(& Regex.scan(@regex, &1)) |> Enum.map(&mult/1) |> Enum.sum()
  end
end
