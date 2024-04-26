defmodule PoetryGameApi.Poems do
  @moduledoc """
  The Poems context.
  """

  import Ecto.Query, warn: false
  alias PoetryGameApi.Repo

  alias PoetryGameApi.Poems.Poem

  @max_poem_count 12
  def max_poem_count, do: @max_poem_count

  @doc """
  Returns the list of poems sorted by date and time submitted in descending order.

  ## Examples

      iex> list_poems()
      [%Poem{}, ...]

  """
  def list_poems do
    Repo.all(Poem) |> Enum.sort_by(& &1.inserted_at, {:desc, NaiveDateTime})
  end

  @doc """
  Gets a single poem.

  Raises `Ecto.NoResultsError` if the Poem does not exist.

  ## Examples

      iex> get_poem!(123)
      %Poem{}

      iex> get_poem!(456)
      ** (Ecto.NoResultsError)

  """
  def get_poem!(id), do: Repo.get!(Poem, id)

  @doc """
  Creates a poem.

  ## Examples

      iex> create_poem(%{field: value})
      {:ok, %Poem{}}

      iex> create_poem(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_poem(attrs \\ %{}) do
    %Poem{}
    |> Poem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a poem.

  ## Examples

      iex> update_poem(poem, %{field: new_value})
      {:ok, %Poem{}}

      iex> update_poem(poem, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_poem(%Poem{} = poem, attrs) do
    poem
    |> Poem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a poem.

  ## Examples

      iex> delete_poem(poem)
      {:ok, %Poem{}}

      iex> delete_poem(poem)
      {:error, %Ecto.Changeset{}}

  """
  def delete_poem(%Poem{} = poem) do
    Repo.delete(poem)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking poem changes.

  ## Examples

      iex> change_poem(poem)
      %Ecto.Changeset{data: %Poem{}}

  """
  def change_poem(%Poem{} = poem, attrs \\ %{}) do
    Poem.changeset(poem, attrs)
  end
end
