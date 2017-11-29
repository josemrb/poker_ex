defmodule Poker.Ranking do
  @moduledoc"""
  Ranking related functions.
  """

  def compare_hands({:hand, hand_rank, _}, {:hand, hand_rank2, _}) do
    compare_hand_rank_values(hand_rank, hand_rank2)
  end

  defp compare_hand_rank_values({:hand_rank, _, value, card_ranks}, {:hand_rank, _, value, card_ranks2}) do
    compare_card_rank_values(card_ranks, card_ranks2)
  end
  defp compare_hand_rank_values({:hand_rank, _, value, _}, {:hand_rank, _, value2, _}),
    do: integer_comparator(value, value2)

  defp compare_card_rank_values(card_ranks, card_ranks2) do
    result = compare_lists(card_ranks, card_ranks2, &integer_comparator/2)
    Enum.reduce_while(result, hd(result), fn(item, acc) ->
      if item == 0 do
        {:cont, acc}
      else
        if item == acc do
          {:cont, acc}
        else
          {:halt, item}
        end
      end
    end)
  end

  defp compare_lists([], [], _), do: []
  defp compare_lists([head | tail], [head2 | tail2], func) do
    [func.(head, head2) | compare_lists(tail, tail2, func)]
  end

  defp integer_comparator(int, int2) when int == int2, do: 0
  defp integer_comparator(int, int2) when int > int2, do: 1
  defp integer_comparator(int, int2) when int < int2, do: 2
end
