defmodule Concurrency.CountWordSupervisor do
  use Supervisor

  def start_link(args) do
    Supervisor.start_link(__MODULE__, args)
  end

  def init(args) do
    children = [
      {Concurrency.CountWordServer, args}
    ]

    options = [
      strategy: :one_for_one,
      max_seconds: 30
    ]

    Supervisor.init(children, options)
  end
end
