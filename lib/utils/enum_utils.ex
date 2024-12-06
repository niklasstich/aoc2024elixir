defmodule Utils.Enum do
  def except_first([], _value), do: []
  def except_first([value | tail], value), do: tail
  def except_first([head | tail], value) do
    [head | except_first(tail, value)]
  end

  def reject_index(enum, index) do
    enum |> Enum.with_index() |> Enum.reject(fn {_, i} -> i == index end) |> Enum.map(& elem(&1, 0))
  end

  def drop_last(enum), do: enum |> Enum.slice(0, Enum.count(enum) - 1)

  def reduce_while_with_rest(enum, acc, func) do
    enum |> Enum.with_index() |> Enum.reduce_while(acc, fn {val, i}, acc -> func.(val, acc, Enum.drop(enum, i+1)) end)
  end
end
