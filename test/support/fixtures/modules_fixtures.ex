defmodule PhoenixCore.ModulesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixCore.Modules` context.
  """

  @doc """
  Generate a module.
  """
  def module_fixture(attrs \\ %{}) do
    {:ok, module} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        url: "some url"
      })
      |> PhoenixCore.Modules.create_module()

    module
  end
end
