defmodule FridgeApplication do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Fridge, [[name: Fridge]])
    ]

    opts = [strategy: :one_for_one, name: Fridge.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
