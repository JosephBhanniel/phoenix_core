defmodule PhoenixCore.Modules do
  @moduledoc """
  The Modules context.
  """

  import Ecto.Query, warn: false
  alias PhoenixCore.Repo

  alias PhoenixCore.Modules.Module

  def list_tbl_modules do
    Repo.all(Module)
  end

  def get_module!(id), do: Repo.get!(Module, id)

  def create_module(attrs \\ %{}) do
    %Module{}
    |> Module.changeset(attrs)
    |> Repo.insert()
  end


  def update_module(%Module{} = module, attrs) do
    module
    |> Module.changeset(attrs)
    |> Repo.update()
  end


  def delete_module(%Module{} = module) do
    Repo.delete(module)
  end

  def change_module(%Module{} = module, attrs \\ %{}) do
    Module.changeset(module, attrs)
  end
end
