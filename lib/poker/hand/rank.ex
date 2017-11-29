defmodule Poker.Hand.Rank do
  alias Poker.Card

  def to_string({:hand_rank, name, _, card_ranks}) do
    case name do
      :straight_flush ->
        "straight flush: #{inspect(card_ranks)}"
      :four_of_a_kind ->
        "four of a kind: #{inspect(card_ranks)}"
      :full_house ->
        "full house: #{inspect(card_ranks)}"
      :flush ->
        "flush: #{inspect(card_ranks)}"
      :straight ->
        "straight: #{inspect(card_ranks)}"
      :three_of_a_kind ->
        "three of a kind: #{inspect(card_ranks)}"
      :two_pairs ->
        "two pairs: #{inspect(card_ranks)}"
      :one_pair ->
        "one_pair: #{inspect(card_ranks)}"
      :high_card ->
        "high card: #{inspect(card_ranks)}"
    end
  end

  def evaluate_cards([{:card, _, suit, rank}, {:card, _, suit, rank2},
                 {:card, _, suit, rank3}, {:card, _, suit, rank4}, {:card, _, suit, rank5}] = cards)
  when rank > rank2 > rank3 > rank4 > rank5
  and ((rank - rank5 == 4) or (rank == 14 and rank5 == 2 and (rank2 - rank5) == 3)) do
    {:hand_rank, :straight_flush, 9, cards_straight_rank(cards)}
  end

  def evaluate_cards([{:card, _, _, kicker_rank}, {:card, value, _, quad_rank},
                 {:card, value, _, _}, {:card, value, _, _}, {:card, value, _, _}])
  do
    {:hand_rank, :four_of_a_kind, 8, [quad_rank, kicker_rank]}
  end
  def evaluate_cards([{:card, value, _, _}, {:card, value, _, _},
                 {:card, value, _, _}, {:card, value, _, quad_rank}, {:card, _, _, kicker_rank}])
  do
    {:hand_rank, :four_of_a_kind, 8, [quad_rank, kicker_rank]}
  end

  def evaluate_cards([{:card, value2, _, _}, {:card, value2, _, pair_rank},
                 {:card, value, _, _}, {:card, value, _, _}, {:card, value, _, triplet_rank}])
  do
    {:hand_rank, :full_house, 7, [triplet_rank, pair_rank]}
  end
  def evaluate_cards([{:card, value, _, _}, {:card, value, _, _},
                 {:card, value, _, triplet_rank}, {:card, value2, _, _}, {:card, value2, _, pair_rank}])
  do
    {:hand_rank, :full_house, 7, [triplet_rank, pair_rank]}
  end

  def evaluate_cards([{:card, _, suit, _}, {:card, _, suit, _},
                 {:card, _, suit, _}, {:card, _, suit, _}, {:card, _, suit, _}] = cards)
  do
    {:hand_rank, :flush, 6, Card.cards_rank(cards)}
  end

  def evaluate_cards([{:card, _, _, rank}, {:card, _, _, rank2},
                 {:card, _, _, rank3}, {:card, _, _, rank4}, {:card, _, _, rank5}] = cards)
  when rank > rank2 > rank3 > rank4 > rank5
  and ((rank - rank5 == 4) or (rank == 14 and rank5 == 2 and (rank2 - rank5) == 3)) do
    {:hand_rank, :straight, 5, cards_straight_rank(cards)}
  end

  def evaluate_cards([{:card, _, _, high_kicker_rank}, {:card, _, _, low_kicker_rank},
                 {:card, value, _, _}, {:card, value, _, _}, {:card, value, _, triplet_rank}])
  do
    {:hand_rank, :three_of_a_kind, 4, [triplet_rank, high_kicker_rank, low_kicker_rank]}
  end
  def evaluate_cards([{:card, _, _, high_kicker_rank}, {:card, value, _, triplet_rank},
                 {:card, value, _, _}, {:card, value, _, _}, {:card, _, _, low_kicker_rank}])
  do
    {:hand_rank, :three_of_a_kind, 4, [triplet_rank, high_kicker_rank, low_kicker_rank]}
  end
  def evaluate_cards([{:card, value, _, _}, {:card, value, _, triplet_rank},
                 {:card, value, _, _}, {:card, _, _, high_kicker_rank}, {:card, _, _, low_kicker_rank}])
  do
    {:hand_rank, :three_of_a_kind, 4, [triplet_rank, high_kicker_rank, low_kicker_rank]}
  end

  def evaluate_cards([{:card, _, _, kicker_rank}, {:card, value, _, high_pair_rank},
                 {:card, value, _, _}, {:card, value2, _, _}, {:card, value2, _, low_pair_rank}])
  do
    {:hand_rank, :two_pairs, 3, [high_pair_rank, low_pair_rank, kicker_rank]}
  end
  def evaluate_cards([{:card, value, _, _}, {:card, value, _, high_pair_rank},
                 {:card, _, _, kicker_rank}, {:card, value2, _, _}, {:card, value2, _, low_pair_rank}])
  do
    {:hand_rank, :two_pairs, 3, [high_pair_rank, low_pair_rank, kicker_rank]}
  end
  def evaluate_cards([{:card, value, _, _}, {:card, value, _, high_pair_rank},
                 {:card, value2, _, _}, {:card, value2, _, low_pair_rank}, {:card, _, _, kicker_rank}])
  do
    {:hand_rank, :two_pairs, 3, [high_pair_rank, low_pair_rank, kicker_rank]}
  end

  def evaluate_cards([{:card, _, _, kicker_rank}, {:card, _, _, kicker2_rank},
    {:card, _, _, kicker3_rank}, {:card, value, _, _}, {:card, value, _, pair_rank}])
  do
    {:hand_rank, :one_pair, 2, [pair_rank, kicker_rank, kicker2_rank, kicker3_rank]}
  end
  def evaluate_cards([{:card, _, _, kicker_rank}, {:card, _, _, kicker2_rank},
                 {:card, value, _, _}, {:card, value, _, pair_rank}, {:card, _, _, kicker3_rank}])
  do
    {:hand_rank, :one_pair, 2, [pair_rank, kicker_rank, kicker2_rank, kicker3_rank]}
  end
  def evaluate_cards([{:card, _, _, kicker_rank}, {:card, value, _, pair_rank},
                 {:card, value, _, _}, {:card, _, _, kicker2_rank}, {:card, _, _, kicker3_rank}])
  do
    {:hand_rank, :one_pair, 2, [pair_rank, kicker_rank, kicker2_rank, kicker3_rank]}
  end
  def evaluate_cards([{:card, value, _, _}, {:card, value, _, pair_rank},
                 {:card, _, _, kicker_rank}, {:card, _, _, kicker2_rank}, {:card, _, _, kicker3_rank}])
  do
    {:hand_rank, :one_pair, 2, [pair_rank, kicker_rank, kicker2_rank, kicker3_rank]}
  end

  def evaluate_cards([_, _, _, _, _] = cards), do: {:hand_rank, :high_card, 1, Card.cards_rank(cards)}

  defp cards_straight_rank(cards) do
    ranks = Card.cards_rank(cards)
    last = List.last(ranks)
    if last == 2 do
      {second, _remaining_list} = List.pop_at(ranks, 1)
      [second]
    else
      [List.first(ranks)]
    end
  end
end
