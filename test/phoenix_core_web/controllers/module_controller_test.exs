defmodule PhoenixCoreWeb.ModuleControllerTest do
  use PhoenixCoreWeb.ConnCase

  import PhoenixCore.ModulesFixtures

  @create_attrs %{name: "some name", description: "some description", url: "some url"}
  @update_attrs %{name: "some updated name", description: "some updated description", url: "some updated url"}
  @invalid_attrs %{name: nil, description: nil, url: nil}

  describe "index" do
    test "lists all tbl_modules", %{conn: conn} do
      conn = get(conn, ~p"/tbl_modules")
      assert html_response(conn, 200) =~ "Listing Tbl modules"
    end
  end

  describe "new module" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/tbl_modules/new")
      assert html_response(conn, 200) =~ "New Module"
    end
  end

  describe "create module" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/tbl_modules", module: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/tbl_modules/#{id}"

      conn = get(conn, ~p"/tbl_modules/#{id}")
      assert html_response(conn, 200) =~ "Module #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/tbl_modules", module: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Module"
    end
  end

  describe "edit module" do
    setup [:create_module]

    test "renders form for editing chosen module", %{conn: conn, module: module} do
      conn = get(conn, ~p"/tbl_modules/#{module}/edit")
      assert html_response(conn, 200) =~ "Edit Module"
    end
  end

  describe "update module" do
    setup [:create_module]

    test "redirects when data is valid", %{conn: conn, module: module} do
      conn = put(conn, ~p"/tbl_modules/#{module}", module: @update_attrs)
      assert redirected_to(conn) == ~p"/tbl_modules/#{module}"

      conn = get(conn, ~p"/tbl_modules/#{module}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, module: module} do
      conn = put(conn, ~p"/tbl_modules/#{module}", module: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Module"
    end
  end

  describe "delete module" do
    setup [:create_module]

    test "deletes chosen module", %{conn: conn, module: module} do
      conn = delete(conn, ~p"/tbl_modules/#{module}")
      assert redirected_to(conn) == ~p"/tbl_modules"

      assert_error_sent 404, fn ->
        get(conn, ~p"/tbl_modules/#{module}")
      end
    end
  end

  defp create_module(_) do
    module = module_fixture()
    %{module: module}
  end
end
