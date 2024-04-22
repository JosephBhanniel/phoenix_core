defmodule PhoenixCore.Forms do
  @moduledoc """
  The Forms context.
  """

  import Ecto.Query, warn: false
  alias PhoenixCore.Repo

  alias PhoenixCore.Forms.Form1

  @doc """
  Returns the list of tbl_form1.

  ## Examples

      iex> list_tbl_form1()
      [%Form1{}, ...]

  """
  def list_tbl_form1 do
    Repo.all(Form1)
  end

  @doc """
  Gets a single form1.

  Raises `Ecto.NoResultsError` if the Form1 does not exist.

  ## Examples

      iex> get_form1!(123)
      %Form1{}

      iex> get_form1!(456)
      ** (Ecto.NoResultsError)

  """
  def get_form1!(id), do: Repo.get!(Form1, id)

  @doc """
  Creates a form1.

  ## Examples

      iex> create_form1(%{field: value})
      {:ok, %Form1{}}

      iex> create_form1(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_form1(attrs \\ %{}) do
    %Form1{}
    |> Form1.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a form1.

  ## Examples

      iex> update_form1(form1, %{field: new_value})
      {:ok, %Form1{}}

      iex> update_form1(form1, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_form1(%Form1{} = form1, attrs) do
    form1
    |> Form1.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a form1.

  ## Examples

      iex> delete_form1(form1)
      {:ok, %Form1{}}

      iex> delete_form1(form1)
      {:error, %Ecto.Changeset{}}

  """
  def delete_form1(%Form1{} = form1) do
    Repo.delete(form1)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking form1 changes.

  ## Examples

      iex> change_form1(form1)
      %Ecto.Changeset{data: %Form1{}}

  """
  def change_form1(%Form1{} = form1, attrs \\ %{}) do
    Form1.changeset(form1, attrs)
  end
end
