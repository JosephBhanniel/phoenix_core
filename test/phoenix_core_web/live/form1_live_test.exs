defmodule PhoenixCoreWeb.Form1LiveTest do
  use PhoenixCoreWeb.ConnCase

  import Phoenix.LiveViewTest
  import PhoenixCore.FormsFixtures

  @create_attrs %{account_number: 42, account_type: "some account_type", amount: 42, bank_name: "some bank_name", full_name: "some full_name"}
  @update_attrs %{account_number: 43, account_type: "some updated account_type", amount: 43, bank_name: "some updated bank_name", full_name: "some updated full_name"}
  @invalid_attrs %{account_number: nil, account_type: nil, amount: nil, bank_name: nil, full_name: nil}

  defp create_form1(_) do
    form1 = form1_fixture()
    %{form1: form1}
  end

  describe "Index" do
    setup [:create_form1]

    test "lists all tbl_form1", %{conn: conn, form1: form1} do
      {:ok, _index_live, html} = live(conn, ~p"/tbl_form1")

      assert html =~ "Listing Tbl form1"
      assert html =~ form1.account_type
    end

    test "saves new form1", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/tbl_form1")

      assert index_live |> element("a", "New Form1") |> render_click() =~
               "New Form1"

      assert_patch(index_live, ~p"/tbl_form1/new")

      assert index_live
             |> form("#form1-form", form1: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#form1-form", form1: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/tbl_form1")

      html = render(index_live)
      assert html =~ "Form1 created successfully"
      assert html =~ "some account_type"
    end

    test "updates form1 in listing", %{conn: conn, form1: form1} do
      {:ok, index_live, _html} = live(conn, ~p"/tbl_form1")

      assert index_live |> element("#tbl_form1-#{form1.id} a", "Edit") |> render_click() =~
               "Edit Form1"

      assert_patch(index_live, ~p"/tbl_form1/#{form1}/edit")

      assert index_live
             |> form("#form1-form", form1: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#form1-form", form1: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/tbl_form1")

      html = render(index_live)
      assert html =~ "Form1 updated successfully"
      assert html =~ "some updated account_type"
    end

    test "deletes form1 in listing", %{conn: conn, form1: form1} do
      {:ok, index_live, _html} = live(conn, ~p"/tbl_form1")

      assert index_live |> element("#tbl_form1-#{form1.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#tbl_form1-#{form1.id}")
    end
  end

  describe "Show" do
    setup [:create_form1]

    test "displays form1", %{conn: conn, form1: form1} do
      {:ok, _show_live, html} = live(conn, ~p"/tbl_form1/#{form1}")

      assert html =~ "Show Form1"
      assert html =~ form1.account_type
    end

    test "updates form1 within modal", %{conn: conn, form1: form1} do
      {:ok, show_live, _html} = live(conn, ~p"/tbl_form1/#{form1}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Form1"

      assert_patch(show_live, ~p"/tbl_form1/#{form1}/show/edit")

      assert show_live
             |> form("#form1-form", form1: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#form1-form", form1: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/tbl_form1/#{form1}")

      html = render(show_live)
      assert html =~ "Form1 updated successfully"
      assert html =~ "some updated account_type"
    end
  end
end
