defmodule Link do
  import :timer, only: [sleep: 1]

  def boom do
    sleep(500)
    exit(:boom)
  end

  def run do
    # Does not end show the error
    # pid = spawn(Link, :boom, [])

    # It does show the error and kill the client
    # pid = spawn_link(Link, :boom, [])

    Process.flag(:trap_exit, true)
    pid = spawn_link(Link, :boom, [])

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
