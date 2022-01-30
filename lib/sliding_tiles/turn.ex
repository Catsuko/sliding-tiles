defmodule SlidingTiles.Turn do

  def slide(board, :up) do
    slide(board, {0, 1})
  end

  def slide(board, :left) do
    slide(board, {-1, 0})
  end

  def slide(board, :right) do
    slide(board, {-1, 0})
  end

  def slide(board, :down) do
    slide(board, {0, -1})
  end

  def slide(board, slide_direction) do
    moves = 0..3
      |> Enum.map(fn y -> moves_from(board, {3, y}, slide_direction) end)
      |> List.flatten()
    Tabletop.take_turn(board, moves)
  end

  defp moves_from(board, {x, y} = pos, {x_dir, y_dir} = dir, moves \\ [], empty_count \\ 0) do
    cond do
      !Tabletop.in_bounds?(board, pos) ->
        moves
      Tabletop.occupied?(board, pos) ->
        {{next_x, next_y} = next_pos, combined_moves} = check_for_combinations(board, moves, pos, dir)
        updated_moves = add_moves_for_position(pos, combined_moves, empty_count)
        next_distance = abs(x - next_x) + abs(y - next_y) - 1
        moves_from(board, next_pos, dir, updated_moves, empty_count + next_distance)
      true ->
        moves_from(board, {x + x_dir, y + y_dir}, dir, moves, empty_count + 1)
    end
  end

  defp check_for_combinations(board, moves, pos, {x_dir, y_dir} = dir) do
    %Tabletop.Piece{id: id} = Tabletop.get_piece(board, pos)
    case SlidingTiles.find_next_piece(board, pos, dir) do
      {{next_x, next_y} = next_pos, %Tabletop.Piece{id: ^id} = piece} ->
        {{next_x + x_dir, next_y + y_dir}, moves ++ [remove: next_pos, add: {SlidingTiles.double(piece), pos}]}
      {next_pos, _} ->
        {next_pos, moves}
    end
  end

  defp add_moves_for_position({x, y} = pos, moves, empty_count) do
    if empty_count == 0 do
      moves
    else
      moves ++ [move: {pos, {x + empty_count, y}}]
    end
  end

end
