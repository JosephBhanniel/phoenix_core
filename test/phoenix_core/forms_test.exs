defmodule PhoenixCore.FormsTest do
  use PhoenixCore.DataCase

  alias PhoenixCore.Forms

  describe "tbl_form1" do
    alias PhoenixCore.Forms.Form1

    import PhoenixCore.FormsFixtures

    @invalid_attrs %{account_number: nil, account_type: nil, amount: nil, bank_name: nil, full_name: nil}

    test "list_tbl_form1/0 returns all tbl_form1" do
      form1 = form1_fixture()
      assert Forms.list_tbl_form1() == [form1]
    end

    test "get_form1!/1 returns the form1 with given id" do
      form1 = form1_fixture()
      assert Forms.get_form1!(form1.id) == form1
    end

    test "create_form1/1 with valid data creates a form1" do
      valid_attrs = %{account_number: 42, account_type: "some account_type", amount: 42, bank_name: "some bank_name", full_name: "some full_name"}

      assert {:ok, %Form1{} = form1} = Forms.create_form1(valid_attrs)
      assert form1.account_number == 42
      assert form1.account_type == "some account_type"
      assert form1.amount == 42
      assert form1.bank_name == "some bank_name"
      assert form1.full_name == "some full_name"
    end

    test "create_form1/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Forms.create_form1(@invalid_attrs)
    end

    test "update_form1/2 with valid data updates the form1" do
      form1 = form1_fixture()
      update_attrs = %{account_number: 43, account_type: "some updated account_type", amount: 43, bank_name: "some updated bank_name", full_name: "some updated full_name"}

      assert {:ok, %Form1{} = form1} = Forms.update_form1(form1, update_attrs)
      assert form1.account_number == 43
      assert form1.account_type == "some updated account_type"
      assert form1.amount == 43
      assert form1.bank_name == "some updated bank_name"
      assert form1.full_name == "some updated full_name"
    end

    test "update_form1/2 with invalid data returns error changeset" do
      form1 = form1_fixture()
      assert {:error, %Ecto.Changeset{}} = Forms.update_form1(form1, @invalid_attrs)
      assert form1 == Forms.get_form1!(form1.id)
    end

    test "delete_form1/1 deletes the form1" do
      form1 = form1_fixture()
      assert {:ok, %Form1{}} = Forms.delete_form1(form1)
      assert_raise Ecto.NoResultsError, fn -> Forms.get_form1!(form1.id) end
    end

    test "change_form1/1 returns a form1 changeset" do
      form1 = form1_fixture()
      assert %Ecto.Changeset{} = Forms.change_form1(form1)
    end
  end
end
