defmodule Flatt do
  def flatten(list), do: flatten(list, []) |> Enum.reverse()
  def flatten([h | t], acc) when h == [], do: flatten(t, acc)
  def flatten([h | t], acc) when is_list(h), do: flatten(t, flatten(h, acc))
  def flatten([h | t], acc), do: flatten(t, [h | acc])
  def flatten([], acc), do: acc
end
