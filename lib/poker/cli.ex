defmodule Poker.CLI do
  @moduledoc"""
  Command-line Interface functions.
  Poker.CLI is the entrypoint for the escript.

  It takes the parameters passed from the command line, then parses them, and sends them
  to the Poker module for processing.
  """

  def main(args \\ System.argv) do
    args
    |> parse_args
    |> Poker.process
  end

  def parse_args(args) do
    {options, _} = OptionParser.parse!(args,
                                      strict: [player_1: :string, player_2: :string],
                                      aliases: [p: :player_1, q: :player_2])
    options
  end
end
