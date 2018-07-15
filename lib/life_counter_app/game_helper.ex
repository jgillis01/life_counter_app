defmodule LifeCounterApp.GameHelper do
  def friendly_summary do
    LifeCounter.Game.summary
    |> Enum.map(&friendly_player/1)
  end

  def friendly_player(player) do
    name = 
      player.name
      |> friendly_name()

    %{name: name, points: player.points}
  end

  def friendly_name(name) do
    name
      |> String.split("-")
      |> Enum.slice(0..-2)
      |> Enum.join("-")
  end

end
