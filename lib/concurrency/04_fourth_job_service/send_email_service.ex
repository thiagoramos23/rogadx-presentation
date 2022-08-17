defmodule Concurrency.SendEmailService do
  def send_email("thiago@remote.com") do
    Process.sleep(2000)
    {:error, "Email Unreachable"}
  end

  def send_email(email) do
    Process.sleep(2000)
    {:ok, email}
  end
end
