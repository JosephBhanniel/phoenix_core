defmodule PhoenixCore.ModulesTest do
  use PhoenixCore.DataCase

  alias PhoenixCore.Modules

  describe "tbl_modules" do
    alias PhoenixCore.Modules.Module

    import PhoenixCore.ModulesFixtures

    @invalid_attrs %{name: nil, description: nil, url: nil}

    test "list_tbl_modules/0 returns all tbl_modules" do
      module = module_fixture()
      assert Modules.list_tbl_modules() == [module]
    end

    test "get_module!/1 returns the module with given id" do
      module = module_fixture()
      assert Modules.get_module!(module.id) == module
    end

    test "create_module/1 with valid data creates a module" do
      valid_attrs = %{name: "some name", description: "some description", url: "some url"}

      assert {:ok, %Module{} = module} = Modules.create_module(valid_attrs)
      assert module.name == "some name"
      assert module.description == "some description"
      assert module.url == "some url"
    end

    test "create_module/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Modules.create_module(@invalid_attrs)
    end

    test "update_module/2 with valid data updates the module" do
      module = module_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", url: "some updated url"}

      assert {:ok, %Module{} = module} = Modules.update_module(module, update_attrs)
      assert module.name == "some updated name"
      assert module.description == "some updated description"
      assert module.url == "some updated url"
    end

    test "update_module/2 with invalid data returns error changeset" do
      module = module_fixture()
      assert {:error, %Ecto.Changeset{}} = Modules.update_module(module, @invalid_attrs)
      assert module == Modules.get_module!(module.id)
    end

    test "delete_module/1 deletes the module" do
      module = module_fixture()
      assert {:ok, %Module{}} = Modules.delete_module(module)
      assert_raise Ecto.NoResultsError, fn -> Modules.get_module!(module.id) end
    end

    test "change_module/1 returns a module changeset" do
      module = module_fixture()
      assert %Ecto.Changeset{} = Modules.change_module(module)
    end
  end
end
