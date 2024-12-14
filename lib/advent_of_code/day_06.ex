defmodule AdventOfCode.Day06 do
  import Utils.Parse
  import Utils.Vector

  @up {0,-1}
  :loop
  :noloop

  def parse(lines) do
    lines |> String.split("\n") |> Enum.filter(& String.length(&1) != 0) |> to_padded_2dmap(1, "&")
  end

  def next_pos({x,y}, vec), do: vector_add_int({x,y}, vec)

  def step(map, {x,y}, dir, _steps) do
    char_under = Map.fetch!(map, {x,y})
    case char_under do
      {"&", _} -> map
      {"X", _} -> step_internal(map, {x,y}, dir, 0, &step/4)
      {_, _} -> step_internal(map, {x,y}, dir, 0, &step/4)
    end
  end

  def step_loop_detect(map, {x,y}, dir, steps) do
    char_under = Map.fetch!(map, {x,y})
    # IO.inspect(to_string_2d(map))
    case char_under do
      {"&", _} -> {map, :noloop, steps}
      {"X", ddir} when ddir === dir -> {map, :loop, steps}
      {"X", _} -> step_internal(map, {x,y}, dir, steps, &step_loop_detect/4)
      {_, _} -> step_internal(map, {x,y}, dir, steps, &step_loop_detect/4)
    end
  end

  def step_internal(map, {x,y}, dir, steps, f) do
    map = Map.put(map, {x,y}, {"X", dir})
    next = next_pos({x,y}, dir)
    {char_under_next, _dir} = Map.fetch!(map, next)
    {next, dir} = if char_under_next == "#" do
      dir = rotate_rounded(dir, :math.pi/2)
      {next_pos({x,y}, dir), dir}
    else
      {next, dir}
    end
    f.(map, next, dir, steps+1)
  end

  def adapt_map({x,y}, map), do: Map.put(map, {x,y}, {"#", nil})

  def part1(args) do
    map = args |> parse() |> Enum.map(fn {key, value} -> {key, {value, nil}} end) |> Map.new()
    initial_pos = map |> Enum.find(fn {_key, {value, _dir}} -> value == "^" end) |> elem(0)
    map = step(map, initial_pos, @up, 0)
    map |> Enum.count(fn {_key, {value, _dir}} -> value == "X" end)
  end

  def part2(args) do
    map = args |> parse() |> Enum.map(fn {key, value} -> {key, {value, nil}} end) |> Map.new()
    initial_pos = map |> Enum.find(fn {_key, {value, _dir}} -> value == "^" end) |> elem(0)
    tempmap = step(map, initial_pos, @up, 0)
    candidates = tempmap |> Enum.filter(fn {_key, {value, _dir}} -> value == "X" end) |> Enum.map(fn {key, _} -> key end)
    cand_len = Enum.count(candidates)
    candidates = candidates |> Enum.reject(& &1==initial_pos)
    # candidates = candidates |> Enum.take(1)
    IO.inspect(Enum.count(candidates))
    # candidates = tempmap |> Map.keys()
    candidates |> Enum.map(& {&1,adapt_map(&1, map)})
      |> Enum.map(fn {replaced_pos, map} ->
          {map, loop, steps} = step_loop_detect(map, initial_pos, @up, 0)
          IO.inspect("#{steps}/#{cand_len}")
         {replaced_pos, {map, loop}}
        end)
      |> Enum.count(fn {_replaced_pos, {_map, loop}} -> loop == :loop end)
  end
end
