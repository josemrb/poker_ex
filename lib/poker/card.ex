defmodule Poker.Card do
  @moduledoc"""
  Card related functions
  """

  @suits ["C", "D", "H", "S"]
  @values ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]

  @doc """
  Parse valid input string into a :card tuple.

  ## Examples

  iex> Poker.Card.parse("2C")
  {:card, "2", "C", 2}

  iex> Poker.Card.parse("TD")
  {:card, "T", "D", 10}
  """
  def parse(<<value::binary-size(1), suit::binary-size(1)>>) when suit in @suits and value in @values do
    {:card, value, suit, find_card_rank(value)}
  end

  def rank({:card, _, _, rank}), do: rank

  def cards_rank(cards) do
    cards
    |> Enum.map(&rank/1)
  end

  def sort({:card, _, _, rank}, {:card, _, _, rank2}) do
    rank >= rank2
  end

  defp find_card_rank(value) do
    @values
    |> Enum.find_index(fn(x) -> x == value end)
    |> Kernel.+(2)
  end
end
