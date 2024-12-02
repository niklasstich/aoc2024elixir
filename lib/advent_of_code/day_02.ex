defmodule AdventOfCode.Day02 do
  :asc
  :desc
  def parse_line(line) do
    line |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def parse_input(input) do
    input |> String.split("\n") |> Enum.filter(& &1 != "") |> Enum.map(&parse_line/1)
  end

  def line_safe?(line) do
    line |> Enum.reduce({true, nil, nil}, &line_safe_acc/2) |> elem(0)
  end

  def line_safe_acc(n, {safe, previous, prevdir}) do
      case {safe, previous, prevdir} do
        {_, nil, _} -> {true, n, nil}
        {false, _, _} -> {false, n, nil}
        {true, _, _} ->
          d = previous - n
          absd = abs(d)
          dir = if d >= 0, do: :asc, else: :desc

          if absd < 1 || absd > 3 || (prevdir != nil && prevdir != dir) do
            {false, n, nil}
          else
            {true, n, dir}
          end
      end
  end

  def part1(args) do
    args |> parse_input() |> Enum.map(&line_safe?/1) |> Enum.count(& &1)
  end

  def part2(_args) do
  end
end
