defmodule AdventOfCode.Day03 do

  @regex ~r/mul\((\d*),(\d*)\)/
  @regexp2 ~r/(?:\G(?!don't\(\))|do\(\))(?:(?!don't\(\)).)*?(?:mul\((\d*),(\d*)\))?/
  def mult([_, a, b]) do
    String.to_integer(a) * String.to_integer(b)
  end

  def part1(args) do
    Regex.scan(@regex, args) |> Enum.map(&mult/1) |> Enum.sum()
  end

  def part2(args) do
    Regex.scan(@regexp2, args) |> Enum.filter(& Enum.count(&1) == 3) |> Enum.map(&mult/1) |> Enum.sum()
  end
end
