defmodule SlidingTiles.EffectsTest do
  use ExUnit.Case

  test "board starts with a 2 tile at a random position" do
    %Tabletop.Board{pieces: pieces} = SlidingTiles.new()
    piece = Map.values(pieces)
      |> Enum.find(fn item -> item end)
    assert %Tabletop.Piece{id: 2} = piece
  end

  describe "end of turn" do
    test "adds another 2 or 4 tile at a random position" do
      %Tabletop.Board{pieces: pieces} = SlidingTiles.new()
        |> SlidingTiles.Turn.slide(:down)
      tile_count = Map.values(pieces)
        |> Enum.filter(fn item -> item end)
        |> Enum.count(fn %Tabletop.Piece{id: id} -> id == 2 or id == 4 end)
      assert tile_count == 2
    end

    test "game is not over when board is full but moves can be made" do
    end

    test "game is over when board is full with no moves" do
    end
  end
end
