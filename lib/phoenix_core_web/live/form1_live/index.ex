defmodule PhoenixCoreWeb.Form1Live.Index do
  use PhoenixCoreWeb, :live_view

  alias PhoenixCore.Forms
  alias PhoenixCore.Forms.Form1

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :tbl_form1, Forms.list_tbl_form1())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Form1")
    |> assign(:form1, Forms.get_form1!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Form1")
    |> assign(:form1, %Form1{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Tbl form1")
    |> assign(:form1, nil)
  end

  @impl true
  def handle_info({PhoenixCoreWeb.Form1Live.FormComponent, {:saved, form1}}, socket) do
    {:noreply, stream_insert(socket, :tbl_form1, form1)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    form1 = Forms.get_form1!(id)
    {:ok, _} = Forms.delete_form1(form1)

    {:noreply, stream_delete(socket, :tbl_form1, form1)}
  end
end
