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
    lines = pad_input(lines, padding, padding_char)
    lines |> Enum.with_index() |> Enum.reduce(%{}, fn {line, linenum}, acc ->
      line_to_2dmap_values({line, linenum}, acc)
    end)
  end

  defp line_to_2dmap_values({line, linenum}, acc) do
    line |> String.graphemes() |> Enum.with_index() |> Enum.reduce(acc, fn {c, col}, acc ->
      Map.put(acc, {col, linenum}, c)
    end)
  end
end


# ............
# .XXXXXFFFFF.
