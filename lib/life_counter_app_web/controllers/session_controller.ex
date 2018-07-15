defmodule LifeCounterAppWeb.SessionController do
  use LifeCounterAppWeb, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"name" => name, "starting_points" => starting_points}) do
    player =
      name
      |> LifeCounter.add_player(String.to_integer(starting_points))

    conn
    |> put_session(:current_player, player)
    |> redirect(to: game_path(conn, :index))
  end
end
