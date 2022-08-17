defmodule Concurrency.CountWordServer do
  use GenServer

  def start_link(_args) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def count_word(text) do
    GenServer.cast(__MODULE__, {:count_words, text})
  end

  def words_count() do
    GenServer.call(__MODULE__, :words_count)
  end

  def init(args) do
    {:ok, args}
  end

  def handle_call(:words_count, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:count_words, text}, state) do
    if text == "" do
      raise "Boom"
    end

    Process.sleep(4000)

    result =
      text
      |> String.split()
      |> Enum.count()

    {:noreply, Map.put_new(state, result, text)}
  end
end
