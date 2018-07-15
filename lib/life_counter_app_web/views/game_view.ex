defmodule LifeCounterAppWeb.GameView do
  use LifeCounterAppWeb, :view

  alias LifeCounterApp.GameHelper

  def friendly_name(name) do
    name |> GameHelper.friendly_name()
  end
end
