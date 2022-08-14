defmodule Concurrency.SendEmailService do
  def send_email(email) do
    Process.sleep(3000)

    if email == "thiago@remote.com" do
      {:error, "Email unreachable"}
    end

    {:ok, email}
  end
end
