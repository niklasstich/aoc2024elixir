defmodule AdventOfCode.Day08 do
  import Utils.Parse

  def parse(input) do
    input |> String.split("\n", trim: true) |> to_padded_2dmap(0)
  end

  def find_antinodes(points) do
    for {x1, y1} <- points, {x2, y2} <- points, x1 != x2 && y1 != y2 do
      {x1 + (2 * (x2 - x1)), y1 + (2 * (y2 - y1))}
    end
  end

  def find_antinodes_p2(points, bottom_right) do
    for {x1, y1} <- points, {x2, y2} <- points, x1 != x2 && y1 != y2
    do
      0..100 |> Enum.reduce_while([], fn n, acc ->
        if in_bounds({x1 + (n * (x2 - x1)), y1 + (n * (y2 - y1))}, bottom_right),
          do: {:cont, [{x1 + (n * (x2 - x1)), y1 + (n * (y2 - y1))} | acc]},
          else: {:halt, acc}
      end)
    end

  end

  def in_bounds({x, y}, {max_x, max_y}) do
    x >= 0 and x <= max_x and y >= 0 and y <= max_y
  end

  def part1(args) do
    map = parse(args)
    bottom_right = map |> Map.keys() |> Enum.max(fn {x1, y1}, {x2, y2} -> x1+y1 >= x2+y2 end)
    # group coords by letter
    map
      |> Enum.group_by(& elem(&1, 1), & elem(&1, 0))
      |> Map.drop(["."])
      |> Enum.flat_map(fn {_, v} -> v |> find_antinodes() end)
      |> Enum.uniq()
      |> Enum.filter(fn pos -> in_bounds(pos, bottom_right) end)
      |> Enum.count()
  end

  def part2(args) do
    map = parse(args)
    bottom_right = map |> Map.keys() |> Enum.max(fn {x1, y1}, {x2, y2} -> x1+y1 >= x2+y2 end)
    # group coords by letter
    map
      |> Enum.group_by(& elem(&1, 1), & elem(&1, 0))
      |> Map.drop(["."])
      |> Enum.flat_map(fn {_, v} -> v |> find_antinodes_p2(bottom_right) end)
      |> Enum.flat_map(& &1)
      |> Enum.uniq()
      |> Enum.count()
  end
end
