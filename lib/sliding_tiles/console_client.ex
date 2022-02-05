defmodule SlidingTiles.ConsoleClient do

  def main do
    board = SlidingTiles.new()
    {:ok, pid} = SlidingTiles.GameServer.start_link(board)
    evaluate(board, pid)
  end

  def evaluate(board, pid) do
    board
      |> render_board()
      |> handle_outcome(pid)
  end

  def render_board(%Tabletop.Board{pieces: pieces} = board) do
    squares = Enum.map pieces, fn {_pos, piece} ->
      case piece do
        %Tabletop.Piece{id: id} ->
          id_str = Integer.to_string(id)
          String.pad_leading(id_str, 3)
            |> String.pad_trailing(5)
        _ ->
          "  -  "
      end
    end

    board_string = Enum.chunk_every(squares, 4)
      |> Enum.map(&Enum.join/1)
      |> List.flatten
      |> Enum.join("\n")

    IO.puts("\n" <> board_string <> "\n")
    board
  end

  def handle_outcome(board, pid) do
    if Tabletop.Board.get(board, :game_over) do
      render_outcome(board)
      ask_to_play_again()
    else
      take_turn(pid)
    end
  end

  def take_turn(pid) do
    direction = get_direction()

    try do
      take_turn(pid, direction)
    catch
      :exit, _ ->
        IO.puts("Sorry, your game timed out")
        ask_to_play_again()
    end
  end

  def take_turn(pid, direction) do
    case SlidingTiles.GameServer.take_turn(pid, direction) do
      {:ok, updated_board} ->
        evaluate(updated_board, pid)
      _ ->
        IO.puts "ERROR!"
    end
  end

  def render_outcome(%Tabletop.Board{turn: turn}) do
    IO.puts "\nGame Over!\nScore: #{turn}\n"
  end

  def ask_to_play_again do
    cond do
      String.match?(IO.gets("Do you want to play again?\n"), ~r/y.*/i) ->
        IO.puts("\n")
        main()
    end
  end

  defp get_direction() do
    case String.trim(IO.gets("\n")) do
      "l" ->
        :up
      "r" ->
        :down
      "u" ->
        :left
      "d" ->
        :right
      _ ->
        IO.puts("invalid input, use: 'l', 'r', 'u', 'd'")
        get_direction()
    end
  end

end
