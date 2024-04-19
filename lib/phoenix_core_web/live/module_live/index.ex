defmodule PhoenixCoreWeb.ModuleLive.Index do
  use PhoenixCoreWeb, :live_view

  alias PhoenixCore.Modules
  alias PhoenixCore.Modules.Module

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :tbl_modules, Modules.list_tbl_modules())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Module")
    |> assign(:item, Modules.get_module!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Module")
    |> assign(:item, %Module{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Tbl modules")
    |> assign(:item, nil)
  end

  @impl true
  def handle_info({PhoenixCoreWeb.ModuleLive.FormComponent, {:saved, module}}, socket) do
    {:noreply, stream_insert(socket, :tbl_modules, module)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    module = Modules.get_module!(id)
    {:ok, _} = Modules.delete_module(module)

    {:noreply, stream_delete(socket, :tbl_modules, module)}
  end
end
