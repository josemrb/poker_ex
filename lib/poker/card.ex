defmodule Poker.Card do
  @moduledoc"""
  Card related functions
  """
  import Poker.Card.Macro, only: [rank: 1]

  @suits ["C", "D", "H", "S"]
  @values ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]

  def parse(<<value::binary-size(1), suit::binary-size(1)>>) when suit in @suits and value in @values do
    {:card, value, suit, find_rank(value)}
  end

  def sort(card, another_card) do
    rank(card) >= rank(another_card)
  end

  defp find_rank(value) do
    @values
    |> Enum.find_index(fn(x) -> x == value end)
    |> Kernel.+(2)
  end
end
