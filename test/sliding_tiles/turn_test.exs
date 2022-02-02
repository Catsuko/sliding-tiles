defmodule SlidingTiles.TurnTest do
  use ExUnit.Case
  doctest SlidingTiles.Turn

  describe "sliding up" do
    test "[2 _ _ 2] -> [4 _ _ _]" do
      board = SlidingTiles.fresh_board()
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(2), {0, 3}})
        |> SlidingTiles.Turn.slide(:up)
      assert %Tabletop.Piece{id: 4} = Tabletop.get_piece(board, {0, 0})
      assert not Tabletop.occupied?(board, {0, 3})
    end

    test "[2 2 2 _] -> [4 2 _ _]" do
      board = SlidingTiles.fresh_board()
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(2), {0, 1}})
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(2), {0, 2}})
        |> SlidingTiles.Turn.slide(:up)
      assert %Tabletop.Piece{id: 4} = Tabletop.get_piece(board, {0, 0})
      assert %Tabletop.Piece{id: 2} = Tabletop.get_piece(board, {0, 1})
      assert not Tabletop.occupied?(board, {0, 2})
    end
  end

  describe "sliding down" do
    test "[2 _ _ _ ] -> [ _ _ _ 2]" do
      board = SlidingTiles.fresh_board()
        |> SlidingTiles.Turn.slide(:down)
      assert %Tabletop.Piece{id: 2} = Tabletop.get_piece(board, {0, 3})
      assert not Tabletop.occupied?(board, {0, 0})
    end

    test "[2 4 _ _ ] -> [ _ _ 2 4]" do
      board = SlidingTiles.fresh_board()
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(4), {0, 1}})
        |> SlidingTiles.Turn.slide(:down)
      assert %Tabletop.Piece{id: 2} = Tabletop.get_piece(board, {0, 2})
      assert %Tabletop.Piece{id: 4} = Tabletop.get_piece(board, {0, 3})
      assert not Tabletop.occupied?(board, {0, 0})
      assert not Tabletop.occupied?(board, {0, 1})
    end

    test "[2 2 2 _] -> [_ _ 2 4]" do
      board = SlidingTiles.fresh_board()
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(2), {0, 1}})
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(2), {0, 2}})
        |> SlidingTiles.Turn.slide(:down)
      assert %Tabletop.Piece{id: 4} = Tabletop.get_piece(board, {0, 3})
      assert %Tabletop.Piece{id: 2} = Tabletop.get_piece(board, {0, 2})
      assert not Tabletop.occupied?(board, {0, 0})
      assert not Tabletop.occupied?(board, {0, 1})
    end

    test "[2 2 16 _] -> [_ _ 4 16]" do
      board = SlidingTiles.fresh_board()
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(2), {0, 1}})
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(16), {0, 2}})
        |> SlidingTiles.Turn.slide(:down)
      assert %Tabletop.Piece{id: 16} = Tabletop.get_piece(board, {0, 3})
      assert %Tabletop.Piece{id: 4} = Tabletop.get_piece(board, {0, 2})
      assert not Tabletop.occupied?(board, {0, 0})
      assert not Tabletop.occupied?(board, {0, 1})
    end
  end

  describe "sliding left" do
    test "[2 _ _ _] -> [2 _ _ _]" do
      board = SlidingTiles.fresh_board()
        |> SlidingTiles.Turn.slide(:left)
      assert %Tabletop.Piece{id: 2} = Tabletop.get_piece(board, {0, 0})
    end

    test "[_ _ _ 2] -> [2 _ _ _]" do
      board = SlidingTiles.fresh_board()
        |> Tabletop.Actions.apply(:move, {{0, 0}, {3, 0}})
        |> SlidingTiles.Turn.slide(:left)
      assert %Tabletop.Piece{id: 2} = Tabletop.get_piece(board, {0, 0})
      assert not Tabletop.occupied?(board, {3, 0})
    end

    test "[_ 2 _ 4] -> [2 4 _ _]" do
      board = SlidingTiles.fresh_board()
        |> Tabletop.Actions.apply(:move, {{0, 0}, {1, 0}})
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(4), {3, 0}})
        |> SlidingTiles.Turn.slide(:left)
      assert %Tabletop.Piece{id: 2} = Tabletop.get_piece(board, {0, 0})
      assert %Tabletop.Piece{id: 4} = Tabletop.get_piece(board, {1, 0})
      assert not Tabletop.occupied?(board, {3, 0})
    end

    test "[2 2 _ _] -> [4 _ _ _]" do
      board = SlidingTiles.fresh_board()
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(2), {1, 0}})
        |> SlidingTiles.Turn.slide(:left)
      assert %Tabletop.Piece{id: 4} = Tabletop.get_piece(board, {0, 0})
      assert not Tabletop.occupied?(board, {1, 0})
    end

    test "[2 _ 2 2] -> [4 2 _ _]" do
      board = SlidingTiles.fresh_board()
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(2), {2, 0}})
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(2), {3, 0}})
        |> SlidingTiles.Turn.slide(:left)

      assert not Tabletop.occupied?(board, {2, 0})
      assert not Tabletop.occupied?(board, {3, 0})
      assert %Tabletop.Piece{id: 2} = Tabletop.get_piece(board, {1, 0})
      assert %Tabletop.Piece{id: 4} = Tabletop.get_piece(board, {0, 0})
    end

    test "[2 2 2 2] -> [4 4 _ _]" do
      board = SlidingTiles.fresh_board()
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(2), {1, 0}})
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(2), {2, 0}})
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(2), {3, 0}})
        |> SlidingTiles.Turn.slide(:left)

      assert not Tabletop.occupied?(board, {2, 0})
      assert not Tabletop.occupied?(board, {3, 0})
      assert %Tabletop.Piece{id: 4} = Tabletop.get_piece(board, {0, 0})
      assert %Tabletop.Piece{id: 4} = Tabletop.get_piece(board, {1, 0})
    end
  end

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

    test "[2 2 2 2] -> [_ _ 4 4]" do
      board = SlidingTiles.fresh_board()
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(2), {1, 0}})
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(2), {2, 0}})
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(2), {3, 0}})
        |> SlidingTiles.Turn.slide(:right)

      assert not Tabletop.occupied?(board, {0, 0})
      assert not Tabletop.occupied?(board, {1, 0})
      assert %Tabletop.Piece{id: 4} = Tabletop.get_piece(board, {2, 0})
      assert %Tabletop.Piece{id: 4} = Tabletop.get_piece(board, {3, 0})
    end

    test "[2 _ 2 2] -> [_ _ 2 4]" do
      board = SlidingTiles.fresh_board()
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(2), {2, 0}})
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(2), {3, 0}})
        |> SlidingTiles.Turn.slide(:right)

      assert not Tabletop.occupied?(board, {0, 0})
      assert not Tabletop.occupied?(board, {1, 0})
      assert %Tabletop.Piece{id: 2} = Tabletop.get_piece(board, {2, 0})
      assert %Tabletop.Piece{id: 4} = Tabletop.get_piece(board, {3, 0})
    end

    test "[_ 4 2 2] -> [_ _ 4 4]" do
      board = SlidingTiles.fresh_board()
        |> Tabletop.Actions.apply(:remove, {0, 0})
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(4), {1, 0}})
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(2), {2, 0}})
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(2), {3, 0}})
        |> SlidingTiles.Turn.slide(:right)

      assert not Tabletop.occupied?(board, {0, 0})
      assert not Tabletop.occupied?(board, {1, 0})
      assert %Tabletop.Piece{id: 4} = Tabletop.get_piece(board, {2, 0})
      assert %Tabletop.Piece{id: 4} = Tabletop.get_piece(board, {3, 0})
    end

    test "[8 2 8 2] -> [8 2 8 2" do
      board = SlidingTiles.fresh_board()
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(8), {0, 0}})
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(2), {1, 0}})
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(8), {2, 0}})
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(2), {3, 0}})
      assert board.pieces == SlidingTiles.Turn.slide(board, :right).pieces
    end
  end

end
