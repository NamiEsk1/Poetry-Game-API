defmodule PoetryGameApi.PoemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PoetryGameApi.Poems` context.
  """

  @doc """
  Generate a poem.
  """
  def poem_fixture(attrs \\ %{}) do
    {:ok, poem} =
      attrs
      |> Enum.into(%{
        text: "some text"
      })
      |> PoetryGameApi.Poems.create_poem()

    poem
  end
end
