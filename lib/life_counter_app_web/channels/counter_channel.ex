defmodule LifeCounterAppWeb.CounterChannel do
  use LifeCounterAppWeb, :channel

  def join("counter:update", _msg, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def handle_in("adjust_player", %{"name" => name, "adjustment" => adjustment}, socket) do
    LifeCounter.adjust_player(name, adjustment)
    summary = LifeCounterApp.GameHelper.friendly_summary()
    {:reply, {:ok, %{game: summary}}, socket}
  end

  def handle_in("reset_player", %{"name" => name}, socket) do
    LifeCounter.reset_player(name)
    summary = LifeCounterApp.GameHelper.friendly_summary()
    {:reply, {:ok, %{game: summary}}, socket}
  end


  def handle_in("player_leaving", %{"name" => name}, socket) do
    LifeCounter.remove_player(name)
    {:reply, {:ok, %{}}, socket}
  end

  def handle_info(:after_join, socket) do
    summary = LifeCounterApp.GameHelper.friendly_summary()
    push(socket, "game_summary", %{game: summary})
    {:noreply, socket}
  end

end
