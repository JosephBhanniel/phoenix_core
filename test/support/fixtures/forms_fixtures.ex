defmodule PhoenixCore.FormsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixCore.Forms` context.
  """

  @doc """
  Generate a form1.
  """
  def form1_fixture(attrs \\ %{}) do
    {:ok, form1} =
      attrs
      |> Enum.into(%{
        account_number: 42,
        account_type: "some account_type",
        amount: 42,
        bank_name: "some bank_name",
        full_name: "some full_name"
      })
      |> PhoenixCore.Forms.create_form1()

    form1
  end
end
