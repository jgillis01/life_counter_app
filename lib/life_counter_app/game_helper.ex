defmodule LifeCounterApp.GameHelper do
  def friendly_summary do
    LifeCounter.Game.summary
    |> Enum.map(&friendly_name/1)
  end

  defp friendly_name(player) do
    name =
      player.name
      |> String.split("-")
      |> hd

    %{name: name, points: player.points}
  end
end
