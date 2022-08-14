defmodule Hello do
  def hello do
    receive do
      {sender, message} ->
        send(sender, {:ok, "Hello #{message}"})
        hello()
    end
  end
end

# pid = spawn(Hello, :hello, [])
# send(pid, {self, "World"})
