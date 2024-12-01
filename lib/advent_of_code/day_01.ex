defmodule AdventOfCode.Day01 do
  defp parallel_map(list, fun) do
    list
    |> Enum.chunk_every(100)
    |> Enum.map(&Task.async(fn -> Enum.map(&1, fun) end))
    |> Task.await_many()
    |> List.flatten()
  end

  def parse_line(line) do
    [w1, w2] = String.split(line)
    {Integer.parse(w1) |> elem(0), Integer.parse(w2) |> elem(0)}
  end

  def parse_input(args) do
    args |> String.split("\n", trim: true) |> parallel_map(&parse_line/1) |> Enum.unzip()
  end

  def part1(args) do
    {l1, l2} = parse_input(args)
    task1 = Task.async(fn -> Enum.sort(l1) end)
    task2 = Task.async(fn -> Enum.sort(l2) end)

    l1 = Task.await(task1)
    l2 = Task.await(task2)
    Enum.zip(l1, l2) |> Enum.map(fn {a, b} -> abs(a - b) end) |> Enum.sum()
  end

  def part2(args) do
    {l1, l2} = parse_input(args)
    l2 = l2 |> Enum.reduce(%{}, fn n, acc -> Map.update(acc, n, 1, &(&1+1)) end)
    l1 |> parallel_map(fn n -> case l2[n] do
        nil -> 0
        int -> int
      end
      *n
    end) |> Enum.sum()
  end
end
