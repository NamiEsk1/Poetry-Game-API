defmodule PoetryGameApiWeb.PoemController do
  use PoetryGameApiWeb, :controller

  alias PoetryGameApi.Poems
  alias PoetryGameApi.Poems.Poem

  action_fallback PoetryGameApiWeb.FallbackController

  def index(conn, _params) do
    poems = Poems.list_poems()
    render(conn, :index, poems: poems)
  end

  def create(conn, %{"poem" => poem_params}) do
    with {:ok, %Poem{} = poem} <- Poems.create_poem(poem_params) do
      list_of_poems = Poems.list_poems()

      # We only store a certain amount of poems before deleting the oldest
      if (length(list_of_poems) > Poems.max_poem_count()) do
        Poems.delete_poem(List.last(list_of_poems))
      end

      conn
      |> put_status(:created)
      |> render(:show, poem: poem)
    end
  end

  def show(conn, %{"id" => id}) do
    poem = Poems.get_poem!(id)
    render(conn, :show, poem: poem)
  end

  def update(conn, %{"id" => id, "poem" => poem_params}) do
    poem = Poems.get_poem!(id)

    with {:ok, %Poem{} = poem} <- Poems.update_poem(poem, poem_params) do
      render(conn, :show, poem: poem)
    end
  end

  def delete(conn, %{"id" => id}) do
    poem = Poems.get_poem!(id)

    with {:ok, %Poem{}} <- Poems.delete_poem(poem) do
      send_resp(conn, :no_content, "")
    end
  end
end
