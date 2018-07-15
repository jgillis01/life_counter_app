defmodule LifeCounterApp.CounterSink do
  use GenServer
  require Logger

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    Registry.register(LifeCounter.Notifier, "player_joined", self())
    Registry.register(LifeCounter.Notifier, "player_left", self())
    Registry.register(LifeCounter.Notifier, "player_adjusted", self())
    Registry.register(LifeCounter.Notifier, "player_reset", self())
    {:ok, []}
  end

  def handle_info({:player_joined, player}, state) do
    game = LifeCounterApp.GameHelper.friendly_summary()

    broadcast("player_joined", %{game: game})
    {:noreply, state}
  end

  def handle_info({:player_adjusted, player}, state) do
    game = LifeCounterApp.GameHelper.friendly_summary()

    broadcast("player_adjusted", %{game: game})
    {:noreply, state}
  end

  def handle_info({:player_left, player}, state) do
    game = LifeCounterApp.GameHelper.friendly_summary()
    broadcast("player_left", %{game: game})
    {:noreply, state}
  end

  def handle_info({:player_reset, player}, state) do
    game = LifeCounterApp.GameHelper.friendly_summary()
    broadcast("player_reset", %{game: game})
    {:noreply, state}
  end
  defp broadcast(message, player) do
    LifeCounterAppWeb.Endpoint.broadcast! "counter:update", message, player
  end
end
