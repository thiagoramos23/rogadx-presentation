defmodule Concurrency.Job do
  defstruct [:id, :work, status: "new", retries: 0, max_retries: 5, params: nil]

  def new(args) do
    %Concurrency.Job{id: random_job_id(), work: args.work, params: args.params}
  end

  defp random_job_id() do
    :crypto.strong_rand_bytes(10) |> Base.url_encode64(padding: false)
  end
end
