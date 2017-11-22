defmodule Poker.CardTest do
  use ExUnit.Case, async: true
  alias Poker.Card

  describe "Poker.Card.parse/1" do
    test "a card with suit clubs" do
      card_print = "2C"
      assert Card.parse(card_print) == %Card{rank: 2, suit: "C", value: "2"}
    end

    test "a card with suit diamonds" do
      card_print = "3D"
      assert Card.parse(card_print) == %Card{rank: 3, suit: "D", value: "3"}
    end

    test "a card with suit hearts" do
      card_print = "4H"
      assert Card.parse(card_print) == %Card{rank: 4, suit: "H", value: "4"}
    end

    test "a card with suit spades" do
      card_print = "5S"
      assert Card.parse(card_print) == %Card{rank: 5, suit: "S", value: "5"}
    end

    test "a card with number value" do
      card_print = "6C"
      assert Card.parse(card_print) == %Card{rank: 6, suit: "C", value: "6"}
    end

    test "a card with symbol value" do
      card_print = "JH"
      assert Card.parse(card_print) == %Card{rank: 11, suit: "H", value: "J"}
    end
  end
end
