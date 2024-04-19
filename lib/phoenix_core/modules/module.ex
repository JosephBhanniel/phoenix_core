defmodule PhoenixCore.Modules.Module do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tbl_modules" do
    field :name, :string
    field :description, :string
    field :url, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(module, attrs) do
    module
    |> cast(attrs, [:name, :description, :url])
    |> validate_required([:name, :description, :url])
  end
end
