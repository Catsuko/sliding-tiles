defmodule SlidingTiles do

  def fresh_board do
    Tabletop.Board.square(4)
      |> Tabletop.Actions.apply(:add, {tile(2), {0,0}})
  end

  def new do
    Tabletop.Board.square(4)
      |> Tabletop.Board.assign(game_over: false)
      |> Tabletop.Board.add_effects(&add_random_tile/1)
      |> Tabletop.Board.add_effects(&check_game_over/1)
      |> Tabletop.take_turn([])
  end

  def tile(n) do
    %Tabletop.Piece{id: n}
  end

  def double(%Tabletop.Piece{id: id}) do
    %Tabletop.Piece{id: id * 2}
  end

  def find_next_piece(board, starting_pos, dir) do
    Tabletop.travel(board, starting_pos, fn pos -> Tabletop.Grid.add(pos, dir) end)
      |> Stream.drop_while(fn {pos, piece} -> pos == starting_pos or piece == nil end)
      |> Stream.take(1)
      |> Enum.at(0, {{-1, -1}, nil})
  end

  def add_random_tile(board) do
    positions = empty_positions(board)
    if Enum.any?(positions) do
      random_position = Enum.random(positions)
      Tabletop.Actions.apply(board, :add, {tile(2), random_position})
    else
      board
    end
  end

  def check_game_over(board) do
    if empty_positions?(board) or combination_exists?(board) do
      board
    else
      Tabletop.Board.assign(board, game_over: true)
    end
  end

  def combination_exists?(board) do
    Tabletop.neighbours(board, {0, 0}, &Tabletop.Grid.cardinal_points/1)
      |> Stream.map(fn {pos_a, pos_b} ->
        {Tabletop.get_piece(board, pos_a), Tabletop.get_piece(board, pos_b)}
      end)
      |> Enum.any?(&Tabletop.Piece.equal?/2)
  end

  def empty_positions?(board) do
    Enum.any?(empty_positions(board))
  end


  def empty_positions(%Tabletop.Board{pieces: pieces} = board) do
    Map.keys(pieces)
      |> Enum.reject(fn pos -> Tabletop.occupied?(board, pos) end)
  end

end
