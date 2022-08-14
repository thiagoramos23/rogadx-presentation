defmodule Chain do
  def counter(next_pid) do
    receive do
      n ->
        send(next_pid, n + 1)
    end
  end

  def create_processes(n) do
    last =
      Enum.reduce(1..n, self(), fn _, send_to ->
        spawn(Chain, :counter, [send_to])
      end)

    send(last, 0)

    receive do
      process_number when is_integer(process_number) ->
        "Result is #{process_number}"
    end
  end

  def run(n) do
    IO.puts(inspect(:timer.tc(Chain, :create_processes, [n])))
  end
end

# elixir --erl "+P 100000000" -r lib/concurrency/second_example/chain.ex -e "Chain.run(1_000_000)"
