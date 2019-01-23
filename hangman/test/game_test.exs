defmodule GameTest do

  use ExUnit.Case
  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "make move won or lost case" do
    for state <- [ :won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert ^game = Game.make_move(game, "x")
    end
  end

  test "first use of letter" do
    game = Game.new_game()
    game = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second use of letter" do
    game = Game.new_game()
    game = Game.make_move(game, "x")
    assert game.game_state != :already_used
    game = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "good guess" do
    game = Game.new_game("foo")
    game = Game.make_move(game, "f")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "guess word" do
    game = Game.new_game("foo")
    game = Game.make_move(game, "f")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    game = Game.make_move(game, "o")
    assert game.game_state == :won
    assert game.turns_left == 7
  end

  test "bad guess" do
    game = Game.new_game("foo")
    game = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "lost game" do
    game = Game.new_game("f")
    game = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
    game = Game.make_move(game, "y")
    assert game.game_state == :bad_guess
    assert game.turns_left == 5
    game = Game.make_move(game, "z")
    assert game.game_state == :bad_guess
    assert game.turns_left == 4
    game = Game.make_move(game, "b")
    assert game.game_state == :bad_guess
    assert game.turns_left == 3
    game = Game.make_move(game, "o")
    assert game.game_state == :bad_guess
    assert game.turns_left == 2
    game = Game.make_move(game, "l")
    assert game.game_state == :bad_guess
    assert game.turns_left == 1
    game = Game.make_move(game, "s")
    assert game.game_state == :lost
  end
end
