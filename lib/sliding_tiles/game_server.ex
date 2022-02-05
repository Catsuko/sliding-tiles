defmodule SlidingTiles.GameServer do
  use GenServer

  # Client API

  def start_link(%Tabletop.Board{} = board) do
    GenServer.start_link(__MODULE__, board)
  end

  def take_turn(pid, direction) do
    GenServer.call(pid, {:take_turn, direction})
  end

  # Server API

  def init(%Tabletop.Board{} = board) do
    {:ok, board, 1000 * 60}
  end

  def handle_info(:timeout, state) do
    {:stop, :normal, state}
  end

  def handle_call({:take_turn, direction}, _from, board) do
    updated_board = SlidingTiles.Turn.slide(board, direction)
    {:reply, {:ok, updated_board}, updated_board}
  end

end
