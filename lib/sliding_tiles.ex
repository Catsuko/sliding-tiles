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

  # Move to tabletop module, useful! travel(board, starting_position, next_func)
  # should return a stream and then consumers can use from there
  def find_next_piece(board, starting_pos, {x_dir, y_dir}) do
    Stream.unfold(starting_pos, fn {x, y} = pos ->
      next_pos = {x + x_dir, y + y_dir}
      if pos == starting_pos or (Tabletop.in_bounds?(board, pos) and !Tabletop.occupied?(board, pos)) do
        {next_pos, next_pos}
      else
        nil
      end
    end)
      |> Stream.map(fn pos -> {pos, Tabletop.get_piece(board, pos)} end)
      |> Enum.to_list()
      |> List.last()
  end

end
