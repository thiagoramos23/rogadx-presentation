defmodule ConcurrencyWeb.CalculatorLive do
  use ConcurrencyWeb, :live_view

  alias Concurrency.CalculatorService

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:results, [])}
  end

  def handle_event("save", %{"calculation" => %{"number" => number}}, socket) do
    {:ok, pid} = CalculatorService.calculate_factorial(number)
    operation = %{pid: pid, number: number, result: :calculating}

    {:noreply,
     socket
     |> assign(:results, [operation | socket.assigns.results])}
  end

  def handle_info({:factorial, pid, result}, socket) do
    {:noreply,
     socket
     |> assign(:results, update_result(pid, format_result(result), socket.assigns.results))}
  end

  def handle_info({:DOWN, _ref, :process, pid, _reason}, socket) do
    {:noreply,
     socket
     |> assign(:results, update_result(pid, :error, socket.assigns.results))}
  end

  defp format_result(result) do
    result
    |> Integer.to_string()
    |> String.slice(0..15)
  end

  defp update_result(pid, :error, results) do
    index =
      Enum.find_index(results, fn %{pid: old_pid, result: result} ->
        old_pid == pid && result == :calculating
      end)

    if is_nil(index) do
      results
    else
      item = Enum.at(results, index)
      update_list(results, item, index, :error)
    end
  end

  defp update_result(pid, new_result, results) do
    index = Enum.find_index(results, fn %{pid: old_pid} -> old_pid == pid end)
    item = Enum.at(results, index)
    update_list(results, item, index, new_result)
  end

  defp update_list(list, item, index, value) do
    List.replace_at(list, index, %{pid: item.pid, number: item.number, result: value})
  end
end
