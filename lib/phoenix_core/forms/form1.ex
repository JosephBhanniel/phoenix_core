defmodule PhoenixCore.Forms.Form1 do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tbl_form1" do
    field :account_number, :integer
    field :account_type, :string
    field :amount, :integer
    field :bank_name, :string
    field :full_name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(form1, attrs) do
    form1
    |> cast(attrs, [:full_name, :account_number, :bank_name, :account_type, :amount])
    #|> validate_required([:full_name, :account_number, :bank_name, :account_type, :amount])
  end
end
