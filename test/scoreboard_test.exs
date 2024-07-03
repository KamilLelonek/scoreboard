defmodule ScoreboardTest do
  use ExUnit.Case

  setup do
    on_exit(fn ->
      Agent.update(Scoreboard, fn _state -> %{} end)
    end)
  end

  test "start a new game" do
    Scoreboard.start_game("Mexico", "Canada")

    assert Scoreboard.summary() == ["Mexico 0 - Canada 0"]
  end

  test "update score of an existing game" do
    Scoreboard.start_game("Mexico", "Canada")
    Scoreboard.update_score("Mexico", "Canada", 1, 2)

    assert Scoreboard.summary() == ["Mexico 1 - Canada 2"]
  end

  test "finish an existing game" do
    Scoreboard.start_game("Mexico", "Canada")
    Scoreboard.finish_game("Mexico", "Canada")

    assert Scoreboard.summary() == []
  end

  test "summary of multiple games" do
    Scoreboard.start_game("Mexico", "Canada")
    Scoreboard.start_game("Spain", "Brazil")
    Scoreboard.start_game("Germany", "France")
    Scoreboard.start_game("Uruguay", "Italy")
    Scoreboard.start_game("Argentina", "Australia")

    Scoreboard.update_score("Mexico", "Canada", 0, 5)
    Scoreboard.update_score("Spain", "Brazil", 10, 2)
    Scoreboard.update_score("Germany", "France", 2, 2)
    Scoreboard.update_score("Uruguay", "Italy", 6, 6)
    Scoreboard.update_score("Argentina", "Australia", 3, 1)

    assert [
             "Uruguay 6 - Italy 6",
             "Spain 10 - Brazil 2",
             "Mexico 0 - Canada 5",
             "Argentina 3 - Australia 1",
             "Germany 2 - France 2"
           ] = Scoreboard.summary()
  end

  test "summary after finishing a game" do
    Scoreboard.start_game("Mexico", "Canada")
    Scoreboard.start_game("Spain", "Brazil")
    Scoreboard.start_game("Germany", "France")
    Scoreboard.start_game("Uruguay", "Italy")
    Scoreboard.start_game("Argentina", "Australia")

    Scoreboard.update_score("Mexico", "Canada", 0, 5)
    Scoreboard.update_score("Spain", "Brazil", 10, 2)
    Scoreboard.update_score("Germany", "France", 2, 2)
    Scoreboard.update_score("Uruguay", "Italy", 6, 6)
    Scoreboard.update_score("Argentina", "Australia", 3, 1)

    Scoreboard.finish_game("Germany", "France")

    assert [
             "Uruguay 6 - Italy 6",
             "Spain 10 - Brazil 2",
             "Mexico 0 - Canada 5",
             "Argentina 3 - Australia 1"
           ] = Scoreboard.summary()
  end

  test "update score of a non-existing game" do
    Scoreboard.start_game("Mexico", "Canada")
    Scoreboard.update_score("Spain", "Brazil", 1, 1)

    assert Scoreboard.summary() == ["Mexico 0 - Canada 0"]
  end
end
