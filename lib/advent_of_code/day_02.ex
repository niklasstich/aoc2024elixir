defmodule AdventOfCode.Day02 do
  alias Utils.EnumUtils
  :asc
  :desc
  def parse_line(line) do
    line |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def parse_input(input) do
    input |> String.split("\n") |> Enum.filter(& &1 != "") |> Enum.map(&parse_line/1)
  end

  def line_safe?(line) do
    line |> Enum.with_index() |> Enum.reduce({true, nil, nil, []}, &line_safe_acc/2) |> elem(0)
  end

  def line_safe_dampened?(line) do
    lineidx = Enum.with_index(line)
    pass1 = lineidx |> Enum.reduce({true, nil, nil, []}, &line_safe_acc/2)
    if elem(pass1, 0) do
      true
    else
      idxs = elem(pass1, 3) |> Enum.flat_map(& [&1, &1-1, 0])
      idxs |> Enum.map(fn i -> line_safe_dampened_inner?(lineidx, i) end) |> Enum.any?(& &1)
    end
  end

  defp line_safe_dampened_inner?(line, i) do
    line |> EnumUtils.reject_index(i) |> Enum.reduce({true, nil, nil, []}, &line_safe_acc/2) |> elem(0)
  end

  def line_safe_acc({n, i}, {safe, previous, prevdir, failedon}) do
      case {safe, previous, prevdir, failedon} do
        {true, nil, nil, _} -> {true, n, nil, failedon}
        #stop updating when we failed so we can get both previous and n we failed on
        #{false, _, _, _} -> {false, previous, nil, failedon}
        {_, _, _, _} ->
          d = previous - n
          absd = abs(d)
          dir = if d >= 0, do: :asc, else: :desc

          if absd < 1 || absd > 3 || (prevdir != nil && prevdir != dir) do
            {false, n, dir, [i | failedon]}
          else
            {safe, n, dir, failedon}
          end
      end
  end

  def part1(args) do
    args |> parse_input() |> Enum.map(&line_safe?/1) |> Enum.count(& &1)
  end

  def part2(args) do
    args |> parse_input() |> Enum.map(&line_safe_dampened?/1) |> Enum.count(& &1)
  end
end
