defmodule PoetryGameApiWeb.PoemJSON do
  alias PoetryGameApi.Poems.Poem

  @doc """
  Renders a list of poems.
  """
  def index(%{poems: poems}) do
    %{data: for(poem <- poems, do: data(poem))}
  end

  @doc """
  Renders a single poem.
  """
  def show(%{poem: poem}) do
    %{data: data(poem)}
  end

  defp data(%Poem{} = poem) do
    %{
      id: poem.id,
      text: poem.text
    }
  end
end
