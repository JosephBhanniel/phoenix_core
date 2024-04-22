defmodule PhoenixCoreWeb.Form1Live.Wizard do
    use PhoenixCoreWeb, :live_view

    alias PhoenixCore.Forms
    alias PhoenixCore.Forms.Form1

    @impl true
    def mount(_params, _session, socket) do
        changeset = Forms.change_form1(%Form1{}, %{})

        {:ok, assign(socket, :progress, 0)
              |> assign(:layout, {PhoenixCoreWeb.Layouts, "forms"})
              |> assign_form(changeset)}
    end

    defp assign_form(socket, %Ecto.Changeset{} = changeset) do
        assign(socket, :form, to_form(changeset))
    end
    
    @impl true
    def handle_event(event, params, socket) do
        case event do
            "next" ->
                handle_next_page(socket, params)
            "prev" ->
                handle_prev_page(socket, params)
            "validate" ->
                handle_validate(socket, params)
        end
    end

    defp handle_next_page(socket, _params) do
        {:noreply, update(socket, :progress, &(&1 + 1))}
    end


    defp handle_prev_page(socket, _params) do
        {:noreply, update(socket, :progress, &(&1 - 1))}
    end

    defp handle_validate(socket, %{"form1" => params}) do        
        changeset =socket.assigns.form.data
                        |> Forms.change_form1(params)
                        |> Map.put(:action, :validate)

        {:noreply, assign_form(socket, changeset)}
    end
end