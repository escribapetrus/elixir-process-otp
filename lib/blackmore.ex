defmodule Blackmore do
  use Application

  @impl true
  def start(_type, _args) do
    Blackmore.Supervisor.start_link(name: Blackmore.Supervisor)
  end
end


defmodule Blackmore.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    children = [
      {Blackmore.GenserverPlayer, name: :player}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
