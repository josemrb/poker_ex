# Poker

It’s a small program to compare a pair of poker hands and to indicate which, if either, is the winner.

## Build

```sh
$ git clone git@github.com:josemrb/poker_ex.git
$ cd poker_ex
$ mix deps.get
$ mix escript.build
```

## Usage

```sh
$ ./poker --player-1=”2H 3D 5S 9C KD” --player-2=”5S 7S 8S 6D 9C”
Player 1 has high card: 13, 9, 5, 3, 2
Player 2 has straight: 9
Player 2 wins
# alternative alias
$ ./poker -p “2H 3D 5S 9C KD” -q “5S 7S 8S 8D 9C”
Player 1 has high card: 13, 9, 5, 3, 2
Player 2 has one pair: 8, 9, 7, 5
Player 2 wins
```

## Copyright and License

Copyright (c) 2017 Jose Miguel Rivero Bruno

The source code is licensed under The MIT License (MIT)
