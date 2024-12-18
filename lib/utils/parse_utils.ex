defmodule Utils.Parse do

  defp pad_input(lines, padding, padding_char) do
    # we only need the length of the first line
    [firstline | _] = lines
    len = String.length(firstline)
    # make enough padding dots
    padline = 1..(len+2*padding) |> Enum.map(fn _ -> padding_char end) |> Enum.join()
    padding_list = padline |> List.duplicate(padding)
    padding_list ++ Enum.map(lines, & "#{String.duplicate(padding_char, padding)}#{&1}#{String.duplicate(padding_char, padding)}") ++ padding_list
  end
  def to_padded_2dmap(lines, padding \\ 1, padding_char \\ ".") do
    lines = if padding > 0, do: pad_input(lines, padding, padding_char), else: lines
    lines |> Enum.with_index() |> Enum.reduce(%{}, fn {line, linenum}, acc ->
      line_to_2dmap_values({line, linenum}, acc)
    end)
  end

  defp line_to_2dmap_values({line, linenum}, acc) do
    line |> String.graphemes() |> Enum.with_index() |> Enum.reduce(acc, fn {c, col}, acc ->
      Map.put(acc, {col, linenum}, c)
    end)
  end

  def to_string_2d(map) do
    {max_x, _} = Enum.max_by(map, fn {{x, _}, _} -> x end) |> elem(0)
    {_, max_y} = Enum.max_by(map, fn {{_, y}, _} -> y end) |> elem(0)

    for y <- 0..max_y do
      for x <- 0..max_x do
        Map.get(map, {x, y}, " ")
      end
      |> Enum.join("")
    end
    |> Enum.join("\n")
  end
end
