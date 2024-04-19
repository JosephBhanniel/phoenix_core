defmodule PhoenixCoreWeb.ModuleLiveTest do
  use PhoenixCoreWeb.ConnCase

  import Phoenix.LiveViewTest
  import PhoenixCore.ModulesFixtures

  @create_attrs %{name: "some name", description: "some description", url: "some url"}
  @update_attrs %{name: "some updated name", description: "some updated description", url: "some updated url"}
  @invalid_attrs %{name: nil, description: nil, url: nil}

  defp create_module(_) do
    module = module_fixture()
    %{module: module}
  end

  describe "Index" do
    setup [:create_module]

    test "lists all tbl_modules", %{conn: conn, module: module} do
      {:ok, _index_live, html} = live(conn, ~p"/tbl_modules")

      assert html =~ "Listing Tbl modules"
      assert html =~ module.name
    end

    test "saves new module", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/tbl_modules")

      assert index_live |> element("a", "New Module") |> render_click() =~
               "New Module"

      assert_patch(index_live, ~p"/tbl_modules/new")

      assert index_live
             |> form("#module-form", module: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#module-form", module: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/tbl_modules")

      html = render(index_live)
      assert html =~ "Module created successfully"
      assert html =~ "some name"
    end

    test "updates module in listing", %{conn: conn, module: module} do
      {:ok, index_live, _html} = live(conn, ~p"/tbl_modules")

      assert index_live |> element("#tbl_modules-#{module.id} a", "Edit") |> render_click() =~
               "Edit Module"

      assert_patch(index_live, ~p"/tbl_modules/#{module}/edit")

      assert index_live
             |> form("#module-form", module: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#module-form", module: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/tbl_modules")

      html = render(index_live)
      assert html =~ "Module updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes module in listing", %{conn: conn, module: module} do
      {:ok, index_live, _html} = live(conn, ~p"/tbl_modules")

      assert index_live |> element("#tbl_modules-#{module.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#tbl_modules-#{module.id}")
    end
  end

  describe "Show" do
    setup [:create_module]

    test "displays module", %{conn: conn, module: module} do
      {:ok, _show_live, html} = live(conn, ~p"/tbl_modules/#{module}")

      assert html =~ "Show Module"
      assert html =~ module.name
    end

    test "updates module within modal", %{conn: conn, module: module} do
      {:ok, show_live, _html} = live(conn, ~p"/tbl_modules/#{module}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Module"

      assert_patch(show_live, ~p"/tbl_modules/#{module}/show/edit")

      assert show_live
             |> form("#module-form", module: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#module-form", module: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/tbl_modules/#{module}")

      html = render(show_live)
      assert html =~ "Module updated successfully"
      assert html =~ "some updated name"
    end
  end
end
