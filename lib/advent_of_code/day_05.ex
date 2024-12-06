defmodule AdventOfCode.Day05 do
  import Utils.Enum

  def parse(input) do
    [rules | rest] = input |> String.split("\n\n")
    [prints | _] = rest
    rules = rules |> String.split("\n")
    prints = prints |> String.split("\n") |> drop_last
    {rules, prints}
  end

  def generate_rule_map(rules) do
    rules |> Enum.map(&parse_rule/1) |> Enum.reduce(%{}, &generate_rule_map_acc/2)
  end

  def generate_rule_map_acc({first, second}, acc) do
    list = Map.get(acc, second)
    list = if list == nil, do: [first], else: [first | list]
    Map.put(acc, second, list)
  end

  def parse_rule(rule) do
    [first | rest] = String.split(rule, "|") |> Enum.map(& String.to_integer(&1))
    [second | _] = rest
    {first, second}
  end

  def is_row_valid?(row, rules) do
    row |> reduce_while_with_rest(true, & is_num_valid?(&1, &2, &3, rules))
  end

  def is_num_valid?(n, true, rest, rules) do
    rules = rules[n]
    if rules == nil, do: {:cont, true}, else:
      (if rest |> Enum.any?(& rules |> Enum.member?(&1)), do: {:halt, false}, else: {:cont, true})
  end

  def middle_in_correct_order(nums, rules) do
    numcount = Enum.count(nums)
    # rules = complete_partial_order(rules)
    nums |> Enum.reduce_while(nil, fn n, _ ->
      rules = rules[n]
      if rules == nil, do: {:cont, nil}, else:
        (
          if nums |> Enum.count(& Enum.member?(rules, &1)) == div(numcount, 2), do: {:halt, n}, else: {:cont, nil}
        )
    end)
  end

  def part1(args) do
    {rules, prints} = parse(args)
    rules = generate_rule_map(rules)
    prints |> Enum.map(fn str -> String.split(str, ",") |> Enum.map(& String.to_integer(&1)) end) |> Enum.filter(& is_row_valid?(&1, rules))
      |> Enum.map(fn nums -> Enum.at(nums, div(Enum.count(nums), 2)) end) |> Enum.sum()
  end

  def part2(args) do
    {rules, prints} = parse(args)
    rules = generate_rule_map(rules)
    prints |> Enum.map(fn str -> String.split(str, ",") |> Enum.map(& String.to_integer(&1)) end) |> Enum.filter(& !is_row_valid?(&1, rules))
      |> Enum.reduce(& middle_in_correct_order(&1, rules)) |> Enum.sum()
  end
end
