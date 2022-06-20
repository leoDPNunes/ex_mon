defmodule ExMon do
  alias ExMon.{Game, Player}
  alias ExMon.Game.{Actions, Status}

  @computer_moves [:attack_one, :attack_two, :heal]
  @computer_name "Thanos"

  def create_player(name, attack_one, attack_two, heal) do
    Player.build(name, attack_one, attack_two, heal)
  end

  def start_game(player) do
    @computer_name
    |> create_player("infinite_gauntler_meteor", "snap", "time stone")
    |> Game.start(player)

    Status.print_round_message(Game.info())
  end

  def make_move(move) do
    Game.info()
    |> Map.get(:status)
    |> handle_status_move(move)

    computer_move(Game.info())
  end

  defp handle_status_move(:game_over, _move), do: Status.print_round_message(Game.info())
  
  defp handle_status_move(_other, move) do
    move
    |> Actions.fetch_move()
    |> do_move()
  end

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)

  defp do_move({:ok, move}) do
    case move do
      :heal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Status.print_round_message(Game.info())
  end

  defp computer_move(%{turn: :computer, status: :continue}) do
    move = {:ok, Enum.random(@computer_moves)}
    do_move(move)
  end

  defp computer_move(_), do: :ok
end
