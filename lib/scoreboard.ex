defmodule Scoreboard do
  use Agent

  @initial_state %{}

  def start_link(_opts), do: Agent.start_link(fn -> @initial_state end, name: __MODULE__)

  def start_game(home_team, away_team),
    do: Agent.update(__MODULE__, &Map.put(&1, {home_team, away_team}, build_state()))

  def finish_game(home_team, away_team),
    do: Agent.update(__MODULE__, &Map.delete(&1, {home_team, away_team}))

  def update_score(home_team, away_team, home_score, away_score) do
    Agent.update(
      __MODULE__,
      &(&1
        |> Map.has_key?({home_team, away_team})
        |> maybe_update_state(&1, home_score, away_score, home_team, away_team))
    )
  end

  def summary do
    __MODULE__
    |> Agent.get(
      &(&1
        |> generate_summary()
        |> sort())
    )
    |> print()
  end

  defp generate_summary(state) do
    Enum.map(state, fn {{home_team, away_team},
                        %{home_score: home_score, away_score: away_score, start_time: start_time}} ->
      {home_team, away_team, home_score, away_score, home_score + away_score, start_time}
    end)
  end

  defp maybe_update_state(false, state, _home_score, _away_score, _home_team, _away_team),
    do: state

  defp maybe_update_state(true, state, home_score, away_score, home_team, away_team) do
    Map.put(
      state,
      {home_team, away_team},
      build_state(home_score, away_score, find_start_time(state, home_team, away_team))
    )
  end

  defp build_state(home_score \\ 0, away_score \\ 0, start_time \\ :os.system_time(:microsecond)) do
    %{
      home_score: home_score,
      away_score: away_score,
      start_time: start_time
    }
  end

  defp find_start_time(state, home_team, away_team) do
    state
    |> Map.get({home_team, away_team})
    |> Map.get(:start_time)
  end

  defp sort(results), do: Enum.sort_by(results, &{-elem(&1, 4), -elem(&1, 5)})

  defp print(results) do
    Enum.map(results, fn {home_team, away_team, home_score, away_score, _total_score, _start_time} ->
      "#{home_team} #{home_score} - #{away_team} #{away_score}"
    end)
  end
end
