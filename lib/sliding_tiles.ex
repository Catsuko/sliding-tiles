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

  def find_next_piece(board, starting_pos, {x_dir, y_dir}) do
    Tabletop.travel(board, starting_pos, fn {x, y} -> {x + x_dir, y + y_dir} end)
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
    # TODO: any possible moves? -> mark game over!
    board
  end

  def empty_positions(%Tabletop.Board{pieces: pieces} = board) do
    Map.keys(pieces)
      |> Enum.reject(fn pos -> Tabletop.occupied?(board, pos) end)
  end

end
