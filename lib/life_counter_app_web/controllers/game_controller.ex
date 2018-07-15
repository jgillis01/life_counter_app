defmodule LifeCounterAppWeb.GameController do
  use LifeCounterAppWeb, :controller

  def index(conn, _params) do
    player = get_session(conn, :current_player)
    mode = get_session(conn, :mode) || "one_for_one"
    game_player = player |> find_player()
    render_or_redirect(conn, game_player, mode)
  end

  defp render_or_redirect(conn, player, _mode) when player == nil do
    redirect conn, to: session_path(conn, :new)
  end

  defp render_or_redirect(conn, player, "one_for_one") do
    render conn, "one_for_one.html",
      current_player: player.name,
      game_summary: LifeCounter.Game.summary
  end

  defp render_or_redirect(conn, player, "all_for_one") do
    render conn, "all_for_one.html",
    current_player: player.name,
    game_summary: LifeCounter.Game.summary
  end

  defp find_player(player) do
    LifeCounter.Game.summary()
    |> Enum.filter(& &1.name == player)
    |> List.first()
  end
end
