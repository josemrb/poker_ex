defmodule Poker.Hand do
  @moduledoc"""
  """

  alias Poker.Card
  alias Poker.Hand.Rank

  def parse(input) when is_binary(input) and byte_size(input) == 14 do
    cards = input
            |> String.split
            |> Enum.map(&Card.parse/1)
            |> Enum.sort(&Card.sort/2)
    {:hand, Rank.evaluate_cards(cards), cards}
  end

  def to_string({:hand, hand_rank, cards}) do
    Rank.to_string(hand_rank)
  end
end
