defmodule SlidingTiles do

  def fresh_board do
    Tabletop.Board.square(4)
      |> Tabletop.Actions.apply(:add, {tile(2), {0,0}})
  end

  def tile(n) do
    %Tabletop.Piece{id: n}
  end

  def occupied_positions(%Tabletop.Board{pieces: pieces} = board) do
    Map.keys(pieces)
      |> Enum.filter(fn pos -> Tabletop.occupied?(board, pos) end)
  end

end
