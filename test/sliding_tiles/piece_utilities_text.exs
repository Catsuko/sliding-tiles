defmodule SlidingTiles.PiecesUtilitiesTest do
  use ExUnit.Case

  describe "find_next_piece" do
    test "empty board" do
      result = Tabletop.Board.square(5)
        |> SlidingTiles.find_next_piece({0, 0}, {1, 0})
      assert {{5, 0}, nil} = result
    end

    test "piece on starting position" do
      result = Tabletop.Board.square(5)
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(1), {0, 0}})
        |> SlidingTiles.find_next_piece({0, 0}, {1, 0})
      assert {{5, 0}, nil} = result
    end

    test "piece to the right of starting position" do
      result = Tabletop.Board.square(5)
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(1), {1, 0}})
        |> SlidingTiles.find_next_piece({0, 0}, {1, 0})
      assert {{1, 0}, %Tabletop.Piece{id: 1}} = result
    end

    test "piece at the far right position" do
      result = Tabletop.Board.square(5)
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(1), {4, 0}})
        |> SlidingTiles.find_next_piece({0, 0}, {1, 0})
      assert {{4, 0}, %Tabletop.Piece{id: 1}} = result
    end

    test "piece above the starting position" do
      result = Tabletop.Board.square(5)
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(1), {0, 1}})
        |> SlidingTiles.find_next_piece({0, 0}, {0, 1})
      assert {{0, 1}, %Tabletop.Piece{id: 1}} = result
    end

    test "piece at the top position" do
      result = Tabletop.Board.square(5)
        |> Tabletop.Actions.apply(:add, {SlidingTiles.tile(1), {0, 4}})
        |> SlidingTiles.find_next_piece({0, 0}, {0, 1})
      assert {{0, 4}, %Tabletop.Piece{id: 1}} = result
    end
  end

end
