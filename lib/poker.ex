defmodule Poker do
  @moduledoc """
  Main module of Poker app.
  """

  alias Poker.{Hand, Ranking}

  @doc """
  It receives a Keyword list with the player id as key and the input string for each player's hand as value.

  ## Examples

  iex> input1 = "2H 3D 5S 9C KD"
  iex> input2 = "2C 3H 4S 8C AH"
  iex> Poker.process [player_1: input1, player_2: input2]
  Player 1 has high card: 13, 9, 5, 3, 2
  Player 2 has high card: 14, 8, 4, 3, 2
  Player 2 wins
  """
  def process([player_1: input1, player_2: input2]) do
    p1_hand = Hand.parse(input1)
    IO.puts "Player 1 has #{Hand.to_string(p1_hand)}"

    p2_hand = Hand.parse(input2)
    IO.puts "Player 2 has #{Hand.to_string(p2_hand)}"

    result = case Ranking.compare_hands(p1_hand, p2_hand) do
      0 -> "It's a tie"
      1 -> "Player 1 wins"
      2 -> "Player 2 wins"
    end
    IO.puts result
  end
end
