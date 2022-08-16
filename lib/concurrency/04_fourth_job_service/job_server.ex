defmodule Concurrency.JobServer do
  use GenServer

  def execute_job(pid) do
    GenServer.cast(pid, :execute)
  end

  def init(args) do
    job = Concurrency.Job.new(args)
    {:ok, job}
  end

  def handle_cast(:execute, job) do
    case job.function.() do
      {:ok, _message} ->
        {:noreply, job}

      {:error, _message} ->
        new_state = Map.put(job, :status, :failed)
        {:noreply, new_state}
    end
  end
end
