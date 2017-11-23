defmodule Poker.Card do
  defstruct [:rank, :suit, :value]

  @suits ["C", "D", "H", "S"]
  @values ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]

  def parse(<<value::binary-size(1), suit::binary-size(1)>>) when suit in @suits and value in @values do
    %Poker.Card{rank: value_rank(value), suit: suit, value: value}
  end

  def sort(card, another_card) do
    card.rank >= another_card.rank
  end

  defp value_rank(value) do
    @values
    |> Enum.find_index(fn(x) -> x == value end)
    |> Kernel.+(2)
  end
end
