defmodule Scoreboard.Application do
  use Application

  @impl true
  def start(_type, _args), do: Supervisor.start_link(children(), opts())

  defp children do
    [
      Scoreboard
    ]
  end

  defp opts do
    [
      strategy: :one_for_one,
      name: Scoreboard.Supervisor
    ]
  end
end
