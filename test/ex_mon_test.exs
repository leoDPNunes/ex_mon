defmodule ExMonTest do
  use ExUnit.Case

  alias ExMon.Player

  import ExUnit.CaptureIO

  describe "create_player/4" do
    test "it should return a player" do

      expected_response = %Player{life: 100, moves: %{attack_one: "punch", attack_two: "kick", heal: "heal"}, name: "leo"}

      assert expected_response == ExMon.create_player("leo", "punch", "kick", "heal")
    end
  end

  describe "start_game/1" do
    test "it should return a message when the game starts" do
      player = Player.build("leo", :punch, :kick, :heal)

      messages = capture_io(fn ->
        assert ExMon.start_game(player)
      end)

      assert messages =~ "The Game is Started!"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("leo", :punch, :kick, :heal)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "it should make a movement when the move is valid" do

      messages = capture_io(fn ->
        assert ExMon.make_move(:kick)
      end)

      assert messages =~ "The Player attacked the Computer dealing"
      assert messages =~ "It's computer turn!"
      assert messages =~ "It's player turn!"
      assert messages =~ "status: :continue"
    end

  test "it should return an error when the move is invalid" do

    messages = capture_io(fn ->
      assert ExMon.make_move(:jump)
    end)


    assert messages =~ "Invalid move: jump!"
    end
  end
end
