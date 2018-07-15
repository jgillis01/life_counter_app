defmodule LifeCounterAppWeb.GameView do
  use LifeCounterAppWeb, :view

  def friendly_name(name) do
    name
    |> String.split("-")
    |> hd
  end
end
