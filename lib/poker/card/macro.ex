defmodule Poker.Card.Macro do
  @moduledoc"""
  Card related macros
  """

  defmacro value(card) do
    quote do
      elem(unquote(card), 1)
    end
  end

  defmacro suit(card) do
    quote do
      elem(unquote(card), 2)
    end
  end

  defmacro rank(card) do
    quote do
      elem(unquote(card), 3)
    end
  end
end
