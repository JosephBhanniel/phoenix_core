defmodule PhoenixCore.Repo.Migrations.CreateTblForm1 do
  use Ecto.Migration

  def change do
    create table(:tbl_form1) do
      add :full_name, :string
      add :account_number, :integer
      add :bank_name, :string
      add :account_type, :string
      add :amount, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
