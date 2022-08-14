defmodule Concurrency.CalculatorService do
  alias Concurrency.Calculator

  def calculate_factorial(number) do
    caller = self()

    with {:ok, pid} <-
           Concurrency.CalculatorSupervisor
           |> Task.Supervisor.start_child(fn ->
             send(caller, {:factorial, self(), do_calculation(number)})
           end) do
      Process.monitor(pid)
      {:ok, pid}
    end
  end

  defp do_calculation(number) do
    number
    |> String.to_integer()
    |> Calculator.factorial()
  end
end
