defmodule ConcurrencyWeb.PageController do
  use ConcurrencyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
