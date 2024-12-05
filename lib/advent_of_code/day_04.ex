defmodule AdventOfCode.Day04 do
  import Utils.Parse
  import Utils.Vector

  @up {0,1}
  @down {0,-1}
  @left {-1,0}
  @right {1,0}
  @upleft vector_add_int(@up, @left)
  @upright vector_add_int(@up, @right)
  @downleft vector_add_int(@down, @left)
  @downright vector_add_int(@down, @right)
  @cardinals [@up, @down, @left, @right]
  @intercardinals [@upleft, @upright, @downleft, @downright]

  def next_coord({x,y}, {col, line}), do: vector_add_int({x,y}, {col, line})
  def opposite_dir(dir), do: flip(dir)

  def parse(input) do
    input |> String.split("\n") |> Enum.filter(& String.length(&1) != 0) |> to_padded_2dmap()
  end

  def find(matrix, word) do
    [first_letter | rest] = String.graphemes(word)
    first_letter_pos = matrix |> Map.filter(fn {_key, val} -> val == first_letter end) |> Map.keys()
    first_letter_pos |> Enum.map(fn {col, line} -> find_continuation({col, line}, rest, matrix) end) |> Enum.sum()
  end

  def find_cross(matrix, word) do
    pivot_idx = div(String.length(word),2)
    pivot = String.at(word, pivot_idx)
    pivot_pos = matrix |> Map.filter(fn {_key, val} -> val == pivot end) |> Map.keys()
    (pivot_pos |> Enum.map(fn {col, line} -> find_cross({col, line}, String.graphemes(word), matrix) end) |> Enum.filter(& &1==2) |> Enum.sum())/2
  end

  def find_continuation_dir(_, _, [], _), do: true
  def find_continuation_dir(dir, {col, line}, [char | rest], matrix) do
    if Map.get(matrix, {col, line}) == char do
      find_continuation_dir(dir, next_coord(dir, {col, line}), rest, matrix)
    else
      false
    end
  end

  def find_continuation({col, line}, rest, matrix) do
    @cardinals ++ @intercardinals |> Enum.map(& find_continuation_dir(&1, next_coord(&1, {col, line}), rest, matrix)) |> Enum.count(& &1)
  end

  def find_cross({col, line}, rest, matrix) do
    @intercardinals |> Enum.map(& find_continuation_dir(&1, next_coord(flip(&1), {col, line}), rest, matrix)) |> Enum.count((& &1))
  end

  def part1(args) do
    args |> parse() |> find("XMAS")
  end

  def part2(args) do
    args |> parse() |> find_cross("MAS")
  end
end
