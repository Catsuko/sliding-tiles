defmodule SlidingTiles do

  def fresh_board do
    Tabletop.Board.square(4)
      |> Tabletop.Actions.apply(:add, {tile(2), {0,0}})
  end

  def tile(n) do
    %Tabletop.Piece{id: n}
  end

  def double(%Tabletop.Piece{id: id}) do
    %Tabletop.Piece{id: id * 2}
  end

  def find_next_piece(board, starting_pos, {x_dir, y_dir}) do
    Tabletop.travel(board, starting_pos, fn {x, y} -> {x + x_dir, y + y_dir} end)
      |> Stream.drop_while(fn {pos, piece} -> pos == starting_pos or piece == nil end)
      |> Stream.take(1)
      |> Enum.at(0, {{-1, -1}, nil})
  end

end
