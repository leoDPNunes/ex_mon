defmodule ExMon do
  alias ExMon.{Game, Player}
  alias ExMon.Game.Status

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
end
