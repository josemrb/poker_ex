defmodule Poker.CardTest do
  use ExUnit.Case, async: true
  alias Poker.Card
  doctest Poker.Card

  describe "Poker.Card.parse/1" do
    test "a card with suit clubs" do
      card_print = "2C"
      assert {:card, "2", "C", 2} == Card.parse(card_print)
    end

    test "a card with suit diamonds" do
      card_print = "3D"
      assert {:card, "3", "D", 3} == Card.parse(card_print)
    end

    test "a card with suit hearts" do
      card_print = "4H"
      assert {:card, "4", "H", 4} == Card.parse(card_print)
    end

    test "a card with suit spades" do
      card_print = "5S"
      assert {:card, "5", "S", 5} == Card.parse(card_print)
    end

    test "a card with number value" do
      card_print = "6C"
      assert {:card, "6", "C", 6} == Card.parse(card_print)
    end

    test "a card with symbol value" do
      card_print = "JH"
      assert {:card, "J", "H", 11} == Card.parse(card_print)
    end
  end

  describe "Poker.Card.rank/1" do
    test "return value" do
      card_print = "JH"
      card = Card.parse(card_print)
      assert 11 = Card.rank(card)
    end
  end

  describe "Poker.Card.cards_rank/1" do
    test "return value" do
      card_print = "JH"
      card = Card.parse(card_print)
      card2_print = "6C"
      card2 = Card.parse(card2_print)
      assert [11, 6] = Card.cards_rank([card, card2])
    end
  end

  describe "Poker.Card.sort/2" do
    test "when left is greater than or equal to right" do
      left_card = Card.parse("5S")
      right_card = Card.parse("3H")
      assert Card.sort(left_card, right_card)
    end

    test "when left is not greater than or equal to right" do
      left_card = Card.parse("7C")
      right_card = Card.parse("TD")
      refute Card.sort(left_card, right_card)
    end
  end
end
