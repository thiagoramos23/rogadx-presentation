defmodule Concurrency.Calculator do
  def sum_list_numbers(list_of_numbers) do
    list_of_numbers
    |> Enum.reduce(0, fn number, acc -> acc + number end)
  end

  def factorial(0), do: 1

  def factorial(number) do
    number * factorial(number - 1)
  end
end
