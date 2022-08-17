defmodule Concurrency.SendEmailRunner do
  alias Concurrency.SendEmailService

  def send_emails() do
    email_list()
    |> Enum.each(&send_email/1)
  end

  def send_email(email) do
    work = &SendEmailService.send_email/1

    DynamicSupervisor.start_child(
      Concurrency.DynamicJobSupervisor,
      {Concurrency.JobSupervisor, %{work: work, params: email}}
    )
  end

  defp email_list() do
    [
      "lucas@remote.com",
      "rafael@rogadx.com",
      "thiago@remote.com"
    ]
  end
end
