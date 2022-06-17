defmodule ExMon do
  alias ExMon.{Game, Player}
  alias ExMon.Game.{Actions, Status}

  @computer_name "Thanos"

  def create_player(name, attack_one, attack_two, heal) do
    Player.build(name, attack_one, attack_two, heal)
  end

  def start_game(player) do
    @computer_name
    |> create_player("infinite_gauntler_meteor", "snap", "time stone")
    |> Game.start(player)

    Status.print_round_message()
  end

  def make_move(move) do
    move
    |> Actions.fetch_move()
    |> do_move()
  end

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)

  defp do_move({:ok, move}) do
    case move do
      :heal -> "cura"
      move -> Actions.attack(move)
      end
  end
end
