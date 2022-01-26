defmodule SlidingTiles.TurnTest do
  use ExUnit.Case
  doctest SlidingTiles.Turn

  describe "sliding right" do
    test "[2 _ _ _] -> [_ _ _ 2]" do
      board = SlidingTiles.fresh_board()
        |> SlidingTiles.Turn.slide(:right)
      assert not Tabletop.occupied?(board, {0, 0})
      assert %Tabletop.Piece{id: 2} = Tabletop.get_piece(board, {3, 0})
    end

    test "[2 4 _ _] -> [_ _ 2 4]" do
      board = SlidingTiles.fresh_board()
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(4), {1, 0}})
        |> SlidingTiles.Turn.slide(:right)
      assert not Tabletop.occupied?(board, {0, 0})
      assert not Tabletop.occupied?(board, {1, 0})
      assert %Tabletop.Piece{id: 2} = Tabletop.get_piece(board, {2, 0})
      assert %Tabletop.Piece{id: 4} = Tabletop.get_piece(board, {3, 0})
    end

    test "[2 _ _ 4] -> [_ _ 2 4]" do
      board = SlidingTiles.fresh_board()
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(4), {3, 0}})
        |> SlidingTiles.Turn.slide(:right)
      assert not Tabletop.occupied?(board, {0, 0})
      assert %Tabletop.Piece{id: 2} = Tabletop.get_piece(board, {2, 0})
      assert %Tabletop.Piece{id: 4} = Tabletop.get_piece(board, {3, 0})
    end

    test "[2 _ 4 8] -> [_ 2 4 8]" do
      board = SlidingTiles.fresh_board()
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(4), {2, 0}})
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(8), {3, 0}})
        |> SlidingTiles.Turn.slide(:right)
      assert not Tabletop.occupied?(board, {0, 0})
      assert %Tabletop.Piece{id: 2} = Tabletop.get_piece(board, {1, 0})
      assert %Tabletop.Piece{id: 4} = Tabletop.get_piece(board, {2, 0})
      assert %Tabletop.Piece{id: 8} = Tabletop.get_piece(board, {3, 0})
    end

    test "[2 _ _ 2] -> [_ _ _ 4]" do
      board = SlidingTiles.fresh_board()
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(2), {3, 0}})
        |> SlidingTiles.Turn.slide(:right)
      assert not Tabletop.occupied?(board, {0, 0})
      assert %Tabletop.Piece{id: 4} = Tabletop.get_piece(board, {3, 0})
    end
  end

end
