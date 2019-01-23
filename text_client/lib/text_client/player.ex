defmodule TextClient.Player do
  alias TextClient.{Prompter, State, Summary, Mover}

  def play(%State{tally: %{ game_state: :won}}) do
    exit_with_message("You won!")
  end

  def play(%State{tally: %{ game_state: :lost}}) do
    exit_with_message("Whomp, you lost.")
  end

  def play(game=%State{tally: %{ game_state: :good_guess}}) do
    continue_with_message(game, "Good guess!")
  end

  def play(game=%State{tally: %{ game_state: :bad_guess}}) do
    continue_with_message(game, "Bad guess :<")
  end

  def play(game=%State{tally: %{ game_state: :already_used}}) do
    continue_with_message(game, "You used that letter already")
  end

  def play(game) do
    continue(game)
  end

  def continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept()
    |> Mover.move()
    |> play()
  end

  def prompt(game) do
    game
  end

  def make_move(game) do
    game
  end

  defp continue_with_message(game, message) do
    IO.puts(message)
    continue(game)
  end

  defp exit_with_message(message) do
    IO.puts(message)
    exit(:normal)
  end
end
