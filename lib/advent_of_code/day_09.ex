defmodule AdventOfCode.Day09 do
  :space
  def parse_fs(input) do
    input
      |> String.trim()
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index()
      |> Enum.reduce([], fn {n, i}, acc ->
        if rem(i, 2) == 0 do
          [List.duplicate(div(i, 2), n) | acc]
        else
          [List.duplicate(:space, n) | acc]
        end
      end)
      |> Enum.flat_map(& &1)
      |> Enum.reverse()
  end

  def defragment(fs) do
    num_count = Enum.count(fs |> Enum.filter(&(&1 != :space)))
    rev_fs = fs
      |> Enum.with_index()
      |> Enum.reverse()
      |> Enum.filter(fn {n, _} -> n != :space end)
    free_spots = fs
      |> Enum.with_index()
      |> Enum.filter(fn {n, _} -> n == :space end)
      |> Enum.map(&elem(&1, 1))
    free_spots
      |> Enum.zip(rev_fs)
      |> Enum.reduce_while(fs, fn {i, {n, rem_i}}, acc ->
        new_acc = List.replace_at(acc, i, n)
          |> List.replace_at(rem_i, :space)
        if Enum.take(new_acc, num_count) |> Enum.count(&(&1 == :space)) > 0 do
          {:cont, new_acc}
        else
          {:halt, new_acc}
        end
      end)
      |> Enum.take(num_count)
  end

  def part1(args) do
    args |> parse_fs() |> defragment() |> Enum.with_index() |> Enum.reduce(0, fn {n, i}, acc -> acc + (n * i) end)
  end

  def part2(_args) do
  end
end
