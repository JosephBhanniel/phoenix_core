defmodule PhoenixCoreWeb.PageController do
  use PhoenixCoreWeb, :controller
  alias PhoenixCore.Modules

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end


  def modules(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    module_items = Modules.list_tbl_modules()
    render(conn, :modules, module_items: module_items, layout: false)
  end
end
