defmodule Concurrency.CalculatorServer do
  # use GenServer

  # def start_link() do
  #   GenServer.start_link(__MODULE__, %{})
  # end

  # def factorial(pid, number) do
  #   GenServer.cast(pid, {:factorial, number})
  # end

  # def get_state(pid) do
  #   GenServer.call(pid, :state)
  # end

  # def init(args \\ %{}) do
  #   {:ok, args}
  # end

  # def handle_cast({:factorial, number}, state) do
  #   result = Concurrency.Calculator.factorial(number)
  #   new_state = Map.put(state, number, result)
  #   {:noreply, new_state}
  # end

  # def handle_call(:state, _from, state) do
  #   {:reply, state, state}
  # end
end
