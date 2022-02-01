defmodule SlidingTiles.Turn do

  def slide(board, :up) do
    take_turn(board, [], {0, 1})
  end

  def slide(board, :left) do
    positions = Enum.map(0..3, fn y -> {0, y} end)
    take_turn(board, positions, {-1, 0})
  end

  def slide(board, :right) do
    positions = Enum.map(0..3, fn y -> {3, y} end)
    take_turn(board, positions, {1, 0})
  end

  def slide(board, :down) do
    take_turn(board, [], {0, -1})
  end

  defp take_turn(board, starting_positions, direction) do
    moves = starting_positions
      |> Enum.map(fn pos -> moves_from(board, pos, direction) end)
      |> List.flatten()
    Tabletop.take_turn(board, moves)
  end

  defp moves_from(board, {x, y} = pos, {x_dir, y_dir} = dir, moves \\ [], empty_count \\ 0) do
    cond do
      !Tabletop.in_bounds?(board, pos) ->
        moves
      Tabletop.occupied?(board, pos) ->
        {{next_x, next_y} = next_pos, combined_moves} = check_for_combinations(board, moves, pos, dir)
        updated_moves = add_moves_for_position(pos, dir, combined_moves, empty_count)
        next_distance = abs(x - next_x) + abs(y - next_y) - 1
        moves_from(board, next_pos, dir, updated_moves, empty_count + next_distance)
      true ->
        moves_from(board, {x - x_dir, y - y_dir}, dir, moves, empty_count + 1)
    end
  end

  defp check_for_combinations(board, moves, pos, {x_dir, y_dir}) do
    %Tabletop.Piece{id: id} = Tabletop.get_piece(board, pos)
    case SlidingTiles.find_next_piece(board, pos, {-x_dir, -y_dir}) do
      {{next_x, next_y} = next_pos, %Tabletop.Piece{id: ^id} = piece} ->
        {{next_x - x_dir, next_y - y_dir}, moves ++ [remove: next_pos, add: {SlidingTiles.double(piece), pos}]}
      {next_pos, _} ->
        {next_pos, moves}
    end
  end

  defp add_moves_for_position({x, y} = pos, {x_dir, y_dir}, moves, empty_count) do
    if empty_count == 0 do
      moves
    else
      destination = {x + (x_dir * empty_count), (y + y_dir * empty_count)}
      moves ++ [move: {pos, destination}]
    end
  end

end
