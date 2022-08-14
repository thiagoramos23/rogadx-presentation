defmodule Concurrency.Cache do
  def start() do
    :ets.new(:concurrency, [:named_table])
  end

  def insert(number, value) do
    :ets.insert(:concurrency, {number, value})
  end

  def list() do
    :ets.all()
  end
end
