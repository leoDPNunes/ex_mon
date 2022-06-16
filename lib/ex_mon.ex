defmodule ExMon do
  alias ExMon.Player
  def create_player(name, attack_one, attack_two, heal) do
    Player.build(name, attack_one, attack_two, heal)
  end
end
