defmodule PhoenixCore.Repo.Migrations.CreateTblModules do
  use Ecto.Migration

  def change do
    create table(:tbl_modules) do
      add :name, :string
      add :description, :string
      add :url, :string

      timestamps(type: :utc_datetime)
    end
  end
end
