defmodule Utils.Enum do
  def except_first([], _value), do: []
  def except_first([value | tail], value), do: tail
  def except_first([head | tail], value) do
    [head | except_first(tail, value)]
  end

  def reject_index(enum, index) do
    enum |> Enum.with_index() |> Enum.reject(fn {_, i} -> i == index end) |> Enum.map(& elem(&1, 0))
  end
end
