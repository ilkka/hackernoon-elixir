defmodule AgentTaskSupervisionPlayground.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias AgentTaskSupervisionPlayground.Bucket

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: AgentTaskSupervisionPlayground.Worker.start_link(arg1, arg2, arg3)
      # worker(AgentTaskSupervisionPlayground.Worker, [arg1, arg2, arg3]),
      supervisor(Task.Supervisor, [[name: SuperVizier]]),
      worker(Bucket, [OurBucket])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AgentTaskSupervisionPlayground.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
