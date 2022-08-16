defmodule Concurrency.Job do
  defstruct [:function, status: :new, retries: 0, max_retries: 5]

  def new(args) do
    %Concurrency.Job{function: args.function}
  end
end
