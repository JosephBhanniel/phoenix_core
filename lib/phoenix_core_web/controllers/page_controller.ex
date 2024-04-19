defmodule PhoenixCoreWeb.PageController do
  use PhoenixCoreWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end


  def modules(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :modules, layout: false)
  end
end
