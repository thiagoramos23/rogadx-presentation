defmodule ConcurrencyWeb.SendEmailLive do
  use ConcurrencyWeb, :live_view

  require Logger

  alias Concurrency.SendEmailRunner

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_event("send_email", %{"email_form" => %{"email" => email}}, socket) do
    SendEmailRunner.send_email(email)
    {:noreply, socket |> assign(:message, "Email will be send")}
  end

  def handle_info({:DOWN, _ref, :process, _pid, _reason}, socket) do
    Logger.info("DOWN DOWN DOWN")
    {:noreply, socket}
  end
end
