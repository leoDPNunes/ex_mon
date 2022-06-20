defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "it should start the game state" do
      player = Player.build("leo", "punch", "kick", "blessing")
      computer = Player.build("Freeza", "ki blast", "death beam", "regeneration")

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "it should return the current game state" do
      player = Player.build("leo", "punch", "kick", "blessing")
      computer = Player.build("Freeza", "ki blast", "death beam", "regeneration")

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{attack_one: "ki blast", attack_two: "death beam", heal: "regeneration"},
          name: "Freeza"
        },
        player: %Player{
          life: 100,
          moves: %{attack_one: "punch", attack_two: "kick", heal: "blessing"},
          name: "leo"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "it should return the updated game state" do

      player = Player.build("leo", "punch", "kick", "blessing")
      computer = Player.build("Freeza", "ki blast", "death beam", "regeneration")

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{attack_one: "ki blast", attack_two: "death beam", heal: "regeneration"},
          name: "Freeza"
        },
        player: %Player{
          life: 100,
          moves: %{attack_one: "punch", attack_two: "kick", heal: "blessing"},
          name: "leo"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()

      new_state = %{
        computer: %Player{
          life: 70,
          moves: %{attack_one: "ki blast", attack_two: "death beam", heal: "regeneration"},
          name: "Freeza"
        },
        player: %Player{
          life: 78,
          moves: %{attack_one: "punch", attack_two: "kick", heal: "blessing"},
          name: "leo"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "it should return the player info" do
      player = Player.build("leo", "punch", "kick", "blessing")
      computer = Player.build("Freeza", "ki blast", "death beam", "regeneration")

      Game.start(computer, player)

      expected_response = %Player{life: 100, moves: %{attack_one: "punch", attack_two: "kick", heal: "blessing"}, name: "leo"}

      assert expected_response == Game.player()
    end
  end

  describe "turn/0" do
    test "it should return which player has the turn" do

      player = Player.build("leo", "punch", "kick", "blessing")
      computer = Player.build("Freeza", "ki blast", "death beam", "regeneration")

      Game.start(computer, player)

      expected_response = :player

      assert expected_response == Game.turn()
    end
  end

  describe "fetch_player/1" do
    test "it should return the player info of the provided player" do

      player = Player.build("leo", "punch", "kick", "blessing")
      computer = Player.build("Freeza", "ki blast", "death beam", "regeneration")

      Game.start(computer, player)

      expected_response = %Player{life: 100, moves: %{attack_one: "ki blast", attack_two: "death beam", heal: "regeneration"}, name: "Freeza"}

      assert expected_response == Game.fetch_player(:computer)
    end
  end
end
