defmodule SlidingTiles.Turn do

  def slide(board, :up) do
    slide(board, {0, 1})
  end

  def slide(board, :left) do
    slide(board, {-1, 0})
  end

  def slide(board, :right) do
    moves = SlidingTiles.occupied_positions(board)
      |> Enum.sort(fn {x1, _y1}, {x2, _y2} -> x1 > x2 end)
      |> Enum.reduce([], fn {x, y} = pos, moves ->
        free_spaces_ahead = Enum.count x..2//1, fn ahead_x ->
          !Tabletop.occupied?(board, {ahead_x+1, y})
        end
        if free_spaces_ahead == 0, do: moves, else: moves ++ [move: {pos, {x + free_spaces_ahead, y}}]
      end)
    Tabletop.take_turn(board, moves)
  end

  def slide(board, :down) do
    slide(board, {0, -1})
  end

  def slide(board, _slide_direction) do
    board
  end

end
