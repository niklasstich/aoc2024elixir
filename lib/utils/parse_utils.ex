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

  def to_string_2d(map) do
    # Get all the coordinates
    coords = Map.keys(map)

    # Find the boundaries of the map
    {min_x, max_x} = coords |> Enum.map(&elem(&1, 0)) |> Enum.min_max()
    {min_y, max_y} = coords |> Enum.map(&elem(&1, 1)) |> Enum.min_max()

    # Generate rows by iterating over y-axis
    min_y..max_y
    |> Enum.map(fn y ->
      # For each row (y), generate its columns (x)
      min_x..max_x
      |> Enum.map(fn x ->
        {val, _dir} = Map.get(map, {x, y}, " ") # Default to " " if the coordinate is missing
        val
      end)
      |> Enum.join("") # Join the row into a string
    end)
    |> Enum.join("\n") # Join all rows with newline characters
  end
end
