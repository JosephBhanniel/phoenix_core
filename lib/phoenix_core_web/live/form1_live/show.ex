defmodule PhoenixCoreWeb.Form1Live.Show do
  use PhoenixCoreWeb, :live_view

  alias PhoenixCore.Forms

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:form1, Forms.get_form1!(id))}
  end

  defp page_title(:show), do: "Show Form1"
  defp page_title(:edit), do: "Edit Form1"
end
