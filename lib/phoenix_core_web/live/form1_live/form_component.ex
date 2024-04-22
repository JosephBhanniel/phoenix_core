defmodule PhoenixCoreWeb.Form1Live.FormComponent do
  use PhoenixCoreWeb, :live_component

  alias PhoenixCore.Forms

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage form1 records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="form1-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:full_name]} type="text" label="Full name" />
        <.input field={@form[:account_number]} type="number" label="Account number" />
        <.input field={@form[:bank_name]} type="text" label="Bank name" />
        <.input field={@form[:account_type]} type="text" label="Account type" />
        <.input field={@form[:amount]} type="number" label="Amount" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Form1</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{form1: form1} = assigns, socket) do
    changeset = Forms.change_form1(form1)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"form1" => form1_params}, socket) do
    changeset =
      socket.assigns.form1
      |> Forms.change_form1(form1_params)
      |> Map.put(:action, :validate)
    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"form1" => form1_params}, socket) do
    save_form1(socket, socket.assigns.action, form1_params)
  end

  defp save_form1(socket, :edit, form1_params) do
    case Forms.update_form1(socket.assigns.form1, form1_params) do
      {:ok, form1} ->
        notify_parent({:saved, form1})

        {:noreply,
         socket
         |> put_flash(:info, "Form1 updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_form1(socket, :new, form1_params) do
    case Forms.create_form1(form1_params) do
      {:ok, form1} ->
        notify_parent({:saved, form1})

        {:noreply,
         socket
         |> put_flash(:info, "Form1 created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
