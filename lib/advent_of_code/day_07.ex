defmodule AdventOfCode.Day07 do

  def parse(input) do
    input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [head|tail] = String.split(line, ": ")
        [rest|_] = tail
        {String.to_integer(head), rest |> String.split(" ") |> Enum.map(& String.to_integer(&1))}
      end)
  end

  def permutate(_chars, 0), do: [[]]
  def permutate(chars, n) do
    for c <- chars, rest <- permutate(chars, n - 1), do: [c | rest]
  end

  def calc_rpn(list, target) do
    list
    |> Enum.reduce_while([], fn
      x, [a, b | rest] when x in ["+", "*", "||"] ->
        result =
          case x do
            "+" -> b + a
            "*" -> b * a
            "||" -> String.to_integer("#{a}#{b}")
          end
        if a > target, do: {:halt, [result]}, else: {:cont, [result | rest]}
      x, stack -> {:cont, [x | stack]}
    end)
    |> hd()
  end

  def part1(args) do
    process(args, ["+", "*"])
  end

  def part2(args) do
    process(args, ["+", "*", "||"])
  end

  defp process(args, symbols) do
    args
      |> parse()
      |> Task.async_stream(fn {target, list} ->
        permutations = permutate(symbols, Enum.count(list) - 1)
        if permutations |> Enum.map(&calc_rpn((list |> Enum.reverse()) ++ &1, target)) |> Enum.any?(& &1 == target), do: target, else: 0
      end)
      |> Enum.map(fn {:ok, result} -> result end)
      |> Enum.sum()
  end
end
