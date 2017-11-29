defmodule Poker.HandTest do
  use ExUnit.Case, async: true
  alias Poker.Hand
  doctest Poker.Hand

  describe "Poker.Hand.parse/1" do
    test "return a tuple" do
      input = "7S JD TH 8C 9H"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, _, _, _}, _} = output
    end

    test "straight_flush with Ace low" do
      input = "AH 2H 3H 4H 5H"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :straight_flush, 9, [5]}, _} = output
    end

    test "straight_flush with Ace high" do
      input = "AH KH QH JH TH"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :straight_flush, 9, [14]}, _} = output
    end

    test "straight_flush" do
      input = "5H 6H 7H 8H 9H"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :straight_flush, 9, [9]}, _} = output
    end

    test "straight_flush case 2" do
      input = "7H JH TH 8H 9H"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :straight_flush, 9, [11]}, _} = output
    end

    test "four_of_a_kind with high quad" do
      input = "7S 7D 7H 7C 3H"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :four_of_a_kind, 8, [7, 3]}, _} = output
    end

    test "four_of_a_kind with high kicker" do
      input = "7S 7D 7H 7C TH"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :four_of_a_kind, 8, [7, 10]}, _} = output
    end

    test "full_house with high triplet" do
      input = "9S 9D 9H 4C 4H"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :full_house, 7, [9, 4]}, _} = output
    end

    test "full_house with high pair" do
      input = "7S 7D 7H 9C 9H"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :full_house, 7, [7, 9]}, _} = output
    end

    test "flush" do
      input = "9S 8S 3S 4S 2S"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :flush, 6, [9, 8, 4, 3, 2]}, _} = output
    end

    test "straight with Ace low" do
      input = "AS 2C 3H 4S 5S"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :straight, 5, [5]}, _} = output
    end

    test "straight with Ace high" do
      input = "AC KS QH JD TH"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :straight, 5, [14]}, _} = output
    end

    test "straight" do
      input = "5H 6H 7H 8C 9H"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :straight, 5, [9]}, _} = output
    end

    test "straight case 2" do
      input = "7S JH TD 8C 9H"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :straight, 5, [11]}, _} = output
    end

    test "three of a kind" do
      input = "7S 7H 7D 4C 2H"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :three_of_a_kind, 4, [7, 4, 2]}, _} = output
    end

    test "three of a kind case 2" do
      input = "7S 4H 4D 4C 2H"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :three_of_a_kind, 4, [4, 7, 2]}, _} = output
    end

    test "three of a kind case 3" do
      input = "7S 4H 2D 2C 2H"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :three_of_a_kind, 4, [2, 7, 4]}, _} = output
    end

    test "two pairs" do
      input = "7S 7H 4D 4C 2H"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :two_pairs, 3, [7, 4, 2]}, _} = output
    end

    test "two pairs case 2" do
      input = "7S 4H 4D 2C 2H"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :two_pairs, 3, [4, 2, 7]}, _} = output
    end

    test "two pairs case 3" do
      input = "7S 7H 4D 2C 2H"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :two_pairs, 3, [7, 2, 4]}, _} = output
    end

    test "one pair" do
      input = "7S 7H 5D 4C 2H"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :one_pair, 2, [7, 5, 4, 2]}, _} = output
    end

    test "one pair case 2" do
      input = "7S 4H 4D 3C 2H"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :one_pair, 2, [4, 7, 3, 2]}, _} = output
    end

    test "one pair case 3" do
      input = "7S 4H 3D 3C 2H"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :one_pair, 2, [3, 7, 4, 2]}, _} = output
    end

    test "one pair case 4" do
      input = "7S 6H 4D 2C 2H"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :one_pair, 2, [2, 7, 6, 4]}, _} = output
    end

    test "high card" do
      input = "7S 5H 3D 2C TH"
      output = Hand.parse(input)
      assert  {:hand, {:hand_rank, :high_card, 1, [10, 7, 5, 3, 2]}, _} = output
    end
  end
end
