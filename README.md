# Sliding Tiles

Implemented using the [tabletop](https://github.com/Catsuko/tabletop) library.

## Playing a Game

Use the `SlidingTiles.ConsoleClient` module to play a game in your elixir console:

```elixir
iex> SlidingTiles.ConsoleClient.main()

  -    -    -    -    -  
  -    -    -    -    -  
  -    2    -    -    -  
  -    -    -    -    -  

```

Input the direction you want to move the tiles:
- (`u`)p
- (`d`)own
- (`l`)eft
- (`r`)ight

After each move, a new tile will be added to the board. If two tiles with the same value
slide into one or the other, they will combine which doubles their value!

The game ends when there are no possible moves left, try to get the highest value tile possible!
