defmodule Monitor do
  import :timer, only: [sleep: 1]

  def boom do
    sleep(500)
    exit(:boom)
  end

  def run do
    # Does not end show the error
    # pid = spawn(Link, :boom, [])

    # It does show the error
    pid = spawn_monitor(Link, :boom, [])
    IO.puts(inspect(pid))

    receive do
      message ->
        IO.puts("Message received: #{inspect(message)}")
    after
      1000 ->
        IO.puts("I suspect we have an error.")
    end
  end
end
