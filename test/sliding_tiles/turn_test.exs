defmodule SlidingTiles.TurnTest do
  use ExUnit.Case
  doctest SlidingTiles.Turn

  describe "sliding right" do
    test "[O _ _ _] -> [_ _ _ O]" do
      board = SlidingTiles.fresh_board()
        |> SlidingTiles.Turn.slide(:right)
      assert not Tabletop.occupied?(board, {0, 0})
      assert Tabletop.occupied?(board, {3, 0})
    end

    test "[O O _ _] -> [_ _ O O]" do
      board = SlidingTiles.fresh_board()
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(3), {1, 0}})
        |> SlidingTiles.Turn.slide(:right)
      assert not Tabletop.occupied?(board, {0, 0})
      assert not Tabletop.occupied?(board, {1, 0})
      assert Tabletop.occupied?(board, {2, 0})
      assert Tabletop.occupied?(board, {3, 0})
    end

    test "[O _ _ O] -> [_ _ O O]" do
      board = SlidingTiles.fresh_board()
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(3), {3, 0}})
        |> SlidingTiles.Turn.slide(:right)
      assert not Tabletop.occupied?(board, {0, 0})
      assert Tabletop.occupied?(board, {2, 0})
      assert Tabletop.occupied?(board, {3, 0})
    end

    test "[O _ O O] -> [_ O O O]" do
      board = SlidingTiles.fresh_board()
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(3), {2, 0}})
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(4), {3, 0}})
        |> SlidingTiles.Turn.slide(:right)
      assert not Tabletop.occupied?(board, {0, 0})
      assert Tabletop.occupied?(board, {1, 0})
      assert Tabletop.occupied?(board, {2, 0})
      assert Tabletop.occupied?(board, {3, 0})
    end
  end

end
