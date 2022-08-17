defmodule Concurrency.JobServer do
  use GenServer, restart: :transient

  require Logger

  alias Concurrency.Job

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(args) do
    state = Concurrency.Job.new(args)
    Logger.info("INIT Job #{state.id}. Execute work for with params: #{state.params}")
    Process.monitor(self())
    {:ok, state, {:continue, :execute}}
  end

  def handle_continue(:execute, state) do
    new_state = execute_work(state) |> handle_result(state)

    case new_state.status do
      "error" ->
        Process.send_after(self(), :retry, 4000)
        {:noreply, new_state}

      "failed" ->
        Logger.error("The Job #{new_state.id} failed and will not be attempted anymore")
        {:stop, :normal, new_state}

      _ ->
        Logger.info("Job #{new_state.id} exiting after completion")
        {:stop, :normal, new_state}
    end
  end

  def handle_info(:retry, state) do
    {:noreply, state, {:continue, :execute}}
  end

  defp handle_result({:ok, _data}, state) do
    Logger.info("Job #{state.id} Completed with success!")
    %Job{state | status: "done"}
  end

  defp handle_result({:error, _message}, %{status: "new"} = state) do
    Logger.error("Job #{state.id} has errors!")
    %Job{state | status: "error"}
  end

  defp handle_result({:error, _message}, %{status: "error"} = state) do
    new_state = %Job{state | retries: state.retries + 1}

    Logger.error(
      "Willl retry Job #{new_state.id} that has errors. This is the attempt: #{new_state.retries} of #{new_state.max_retries}"
    )

    if new_state.retries > new_state.max_retries do
      %Job{new_state | status: "failed"}
    else
      new_state
    end
  end

  defp execute_work(state) do
    if is_nil(state.params) do
      state.work.()
    else
      state.work.(state.params)
    end
  end
end
