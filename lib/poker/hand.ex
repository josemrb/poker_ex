defmodule Poker.Hand do
  @moduledoc"""
  Hand related functions.
  """

  alias Poker.Card
  alias Poker.Hand.Rank

  @doc """
  Parse valid input string into a :hand tuple.

  ## Examples

  iex> Hand.parse("AH 2H 3H 4H 5H")
  {:hand,
    {:hand_rank, :straight_flush, 9, [5]},
    [{:card, "A", "H", 14},
     {:card, "5", "H", 5},
     {:card, "4", "H", 4},
     {:card, "3", "H", 3},
     {:card, "2", "H", 2}]}
  """
  def parse(input) when is_binary(input) and byte_size(input) == 14 do
    cards = input
            |> String.split
            |> Enum.map(&Card.parse/1)
            |> Enum.sort(&Card.sort/2)
    {:hand, Rank.evaluate_cards(cards), cards}
  end

  @doc"""
  Return a binary which corresponds to the text representation of the :hand tuple.

  ## Examples

  iex> poker_hand = Hand.parse("AH 2H 3H 4H 5H")
  iex> Hand.to_string(poker_hand)
  "straight flush: 5"
  """
  def to_string({:hand, hand_rank, _cards}) do
    Rank.to_string(hand_rank)
  end
end
