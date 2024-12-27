defmodule AdventOfCode.Day09 do
  import Utils.Enum

  :space
  :file
  def parse_fs(input) do
    input
      |> String.trim()
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {n, i}, acc ->
        type = if rem(i, 2) == 0, do: :file, else: :space
        file_idx = div(i, 2)
        Map.put(acc, i, {type, n, file_idx})
      end)
  end

  def is_space?({k,v}), do: elem(v, 0) == :space

  def defragment(fs) do
    num_count = fs |> Enum.reject(&is_space?/1) |> Enum.count()
    rev_fs = fs
      |> Enum.reject(&is_space?/1)
      |> Enum.reverse()
    free_spots = fs
      |> Enum.filter(&is_space?/1)
    IO.inspect(num_count, label: "num_count")
    IO.inspect(free_spots, label: "free_spots")
    IO.inspect(rev_fs, label: "rev_fs")
    defragment(fs, free_spots, rev_fs, num_count, false)
  end

  def is_dense?(fs, num_count), do: fs |> Enum.take(num_count) |> Enum.count(&is_space?/1) == 0

  def defragment(fs, _, _, _, dense) when dense, do: fs
  def defragment(fs, [{free_i, {free_label, free_n, free_i_original}} | free_rest], [{rev_i, {rev_label, rev_n, rev_i_original}} | rev_rest], num_count, dense \\ false) do
    IO.inspect(free_i, label: "free_i")
    IO.inspect(free_label, label: "free_label")
    IO.inspect(free_n, label: "free_n")
    IO.inspect(free_i_original, label: "free_i_original")
    IO.inspect(rev_i, label: "rev_i")
    IO.inspect(rev_label, label: "rev_label")
    IO.inspect(rev_n, label: "rev_n")
    IO.inspect(rev_i_original, label: "rev_i_original")
    case {free_n, rev_n} do
      # rev_head fits perfectly into free_head
      {n, n} ->
        fs = Map.replace(fs, free_i, {:file, n, rev_i_original})
        IO.inspect(fs)
        defragment(fs, free_rest, rev_rest, num_count, is_dense?(fs, num_count))
      # free_head smaller than rev_head
      {n, m} when n < m ->
        fs = Map.replace(fs, free_i, {:file, n, rev_i_original})
        rev_rest = [{rev_i, {:file, m - n, rev_i_original}} | rev_rest]
        IO.inspect(fs)
        defragment(fs, free_rest, rev_rest, num_count, is_dense?(fs, num_count))
      # free_head larger than rev_head
      {n, m} when n > m ->
        fs = Map.replace(fs, free_i, {:file, m, rev_i_original})
        fs = put_between(fs, free_i + 1, {:space, n - m, free_i_original})
        free_rest = free_rest |> Map.new(fn {k, v} -> {k + 1, v} end)
        free_rest = if n-m>0, do: [{free_i+1, {:file, n - m, free_i_original}} | free_rest], else: free_rest
        IO.inspect(fs)
        defragment(fs, free_rest, rev_rest, num_count, is_dense?(fs, num_count))
    end
  end

  def part1(args) do
    args
      |> parse_fs()
      |> defragment()
      # |> Enum.with_index()
      # |> Enum.reduce(0, fn {n, i}, acc -> acc + (n * i) end)
  end

  def part2(_args) do
  end
end
