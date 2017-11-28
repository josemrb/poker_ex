defmodule Poker.Hand do
  @moduledoc"""
  """

  alias Poker.Card

  def parse(input) when is_binary(input) and byte_size(input) == 14 do
    cards = input
            |> String.split
            |> Enum.map(&Card.parse/1)
            |> Enum.sort(&Card.sort/2)
    {:hand, evaluate(cards), cards}
  end

  defp cards_rank(cards) do
    cards
    |> Enum.map(&Card.rank/1)
  end

  defp cards_straight_rank(cards) do
    ranks = cards_rank(cards)
    last = List.last(ranks)
    if last == 2 do
      {second, _remaining_list} = List.pop_at(ranks, 1)
      [second]
    else
      [List.first(ranks)]
    end
  end

  defp evaluate([{:card, _, suit, rank}, {:card, _, suit, rank2},
                 {:card, _, suit, rank3}, {:card, _, suit, rank4}, {:card, _, suit, rank5}] = cards)
  when rank > rank2 > rank3 > rank4 > rank5
  and ((rank - rank5 == 4) or (rank == 14 and rank5 == 2 and (rank2 - rank5) == 3)) do
    {:straight_flush, 9, cards_straight_rank(cards)}
  end

  defp evaluate([{:card, _, _, kicker_rank}, {:card, value, _, quad_rank},
                 {:card, value, _, _}, {:card, value, _, _}, {:card, value, _, _}])
  do
    {:four_of_a_kind, 8, [quad_rank, kicker_rank]}
  end
  defp evaluate([{:card, value, _, _}, {:card, value, _, _},
                 {:card, value, _, _}, {:card, value, _, quad_rank}, {:card, _, _, kicker_rank}])
  do
    {:four_of_a_kind, 8, [quad_rank, kicker_rank]}
  end

  defp evaluate([{:card, value2, _, _}, {:card, value2, _, pair_rank},
                 {:card, value, _, _}, {:card, value, _, _}, {:card, value, _, triplet_rank}])
  do
    {:full_house, 7, [triplet_rank, pair_rank]}
  end
  defp evaluate([{:card, value, _, _}, {:card, value, _, _},
                 {:card, value, _, triplet_rank}, {:card, value2, _, _}, {:card, value2, _, pair_rank}])
  do
    {:full_house, 7, [triplet_rank, pair_rank]}
  end

  defp evaluate([{:card, _, suit, _}, {:card, _, suit, _},
                 {:card, _, suit, _}, {:card, _, suit, _}, {:card, _, suit, _}] = cards)
  do
    {:flush, 6, cards_rank(cards)}
  end

  defp evaluate([{:card, _, _, rank}, {:card, _, _, rank2},
                 {:card, _, _, rank3}, {:card, _, _, rank4}, {:card, _, _, rank5}] = cards)
  when rank > rank2 > rank3 > rank4 > rank5
  and ((rank - rank5 == 4) or (rank == 14 and rank5 == 2 and (rank2 - rank5) == 3)) do
    {:straight, 5, cards_straight_rank(cards)}
  end

  defp evaluate([{:card, _, _, high_kicker_rank}, {:card, _, _, low_kicker_rank},
                 {:card, value, _, _}, {:card, value, _, _}, {:card, value, _, triplet_rank}])
  do
    {:three_of_a_kind, 4, [triplet_rank, high_kicker_rank, low_kicker_rank]}
  end
  defp evaluate([{:card, _, _, high_kicker_rank}, {:card, value, _, triplet_rank},
                 {:card, value, _, _}, {:card, value, _, _}, {:card, _, _, low_kicker_rank}])
  do
    {:three_of_a_kind, 4, [triplet_rank, high_kicker_rank, low_kicker_rank]}
  end
  defp evaluate([{:card, value, _, _}, {:card, value, _, triplet_rank},
                 {:card, value, _, _}, {:card, _, _, high_kicker_rank}, {:card, _, _, low_kicker_rank}])
  do
    {:three_of_a_kind, 4, [triplet_rank, high_kicker_rank, low_kicker_rank]}
  end

  defp evaluate([{:card, _, _, kicker_rank}, {:card, value, _, high_pair_rank},
                 {:card, value, _, _}, {:card, value2, _, _}, {:card, value2, _, low_pair_rank}])
  do
    {:two_pairs, 3, [high_pair_rank, low_pair_rank, kicker_rank]}
  end
  defp evaluate([{:card, value, _, _}, {:card, value, _, high_pair_rank},
                 {:card, _, _, kicker_rank}, {:card, value2, _, _}, {:card, value2, _, low_pair_rank}])
  do
    {:two_pairs, 3, [high_pair_rank, low_pair_rank, kicker_rank]}
  end
  defp evaluate([{:card, value, _, _}, {:card, value, _, high_pair_rank},
                 {:card, value2, _, _}, {:card, value2, _, low_pair_rank}, {:card, _, _, kicker_rank}])
  do
    {:two_pairs, 3, [high_pair_rank, low_pair_rank, kicker_rank]}
  end

  defp evaluate([{:card, _, _, kicker_rank}, {:card, _, _, kicker2_rank},
    {:card, _, _, kicker3_rank}, {:card, value, _, _}, {:card, value, _, pair_rank}])
  do
    {:one_pair, 2, [pair_rank, kicker_rank, kicker2_rank, kicker3_rank]}
  end
  defp evaluate([{:card, _, _, kicker_rank}, {:card, _, _, kicker2_rank},
                 {:card, value, _, _}, {:card, value, _, pair_rank}, {:card, _, _, kicker3_rank}])
  do
    {:one_pair, 2, [pair_rank, kicker_rank, kicker2_rank, kicker3_rank]}
  end
  defp evaluate([{:card, _, _, kicker_rank}, {:card, value, _, pair_rank},
                 {:card, value, _, _}, {:card, _, _, kicker2_rank}, {:card, _, _, kicker3_rank}])
  do
    {:one_pair, 2, [pair_rank, kicker_rank, kicker2_rank, kicker3_rank]}
  end
  defp evaluate([{:card, value, _, _}, {:card, value, _, pair_rank},
                 {:card, _, _, kicker_rank}, {:card, _, _, kicker2_rank}, {:card, _, _, kicker3_rank}])
  do
    {:one_pair, 2, [pair_rank, kicker_rank, kicker2_rank, kicker3_rank]}
  end

  defp evaluate([_, _, _, _, _] = cards), do: {:high_card, 1, cards_rank(cards)}
end
