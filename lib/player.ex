defmodule ExMon.Player do
  @required_keys [:name, :moves, :life]
  @max_life 100

  @enforce_keys @required_keys

  defstruct @required_keys

  def build(name, attack_one, attack_two, heal) do
    %ExMon.Player{
      name: name,
      moves: %{
        attack_one: attack_one,
        attack_two: attack_two,
        heal: heal,
      },
      life: @max_life
    }
  end
end
