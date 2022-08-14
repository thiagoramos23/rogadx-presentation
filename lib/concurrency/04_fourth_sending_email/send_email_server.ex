defmodule Concurrency.SendEmailServer do
  use GenServer

  # [:email, :retries, :status, :max_retries]
  def init(args \\ %{}) do
    args = Map.merge(args, %{retries: 0, status: :pending})
    args = Map.put_new(args, :max_retries, 5)
    {:ok, args}
  end

  def handle_cast({:send_email, args}, state) do
    case Concurrency.SendEmailService.send_email(args[:email]) do
      {:ok, _message} ->
        {:noreply, state}

      {:error, _message} ->
        new_state = Map.put(state, :status, :failed)
        {:noreply, new_state}
    end
  end
end
