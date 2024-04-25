defmodule PoetryGameApi.PoemsTest do
  use PoetryGameApi.DataCase

  alias PoetryGameApi.Poems

  describe "poems" do
    alias PoetryGameApi.Poems.Poem

    import PoetryGameApi.PoemsFixtures

    @invalid_attrs %{text: nil}

    test "list_poems/0 returns all poems" do
      poem = poem_fixture()
      assert Poems.list_poems() == [poem]
    end

    test "get_poem!/1 returns the poem with given id" do
      poem = poem_fixture()
      assert Poems.get_poem!(poem.id) == poem
    end

    test "create_poem/1 with valid data creates a poem" do
      valid_attrs = %{text: "some text"}

      assert {:ok, %Poem{} = poem} = Poems.create_poem(valid_attrs)
      assert poem.text == "some text"
    end

    test "create_poem/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Poems.create_poem(@invalid_attrs)
    end

    test "update_poem/2 with valid data updates the poem" do
      poem = poem_fixture()
      update_attrs = %{text: "some updated text"}

      assert {:ok, %Poem{} = poem} = Poems.update_poem(poem, update_attrs)
      assert poem.text == "some updated text"
    end

    test "update_poem/2 with invalid data returns error changeset" do
      poem = poem_fixture()
      assert {:error, %Ecto.Changeset{}} = Poems.update_poem(poem, @invalid_attrs)
      assert poem == Poems.get_poem!(poem.id)
    end

    test "delete_poem/1 deletes the poem" do
      poem = poem_fixture()
      assert {:ok, %Poem{}} = Poems.delete_poem(poem)
      assert_raise Ecto.NoResultsError, fn -> Poems.get_poem!(poem.id) end
    end

    test "change_poem/1 returns a poem changeset" do
      poem = poem_fixture()
      assert %Ecto.Changeset{} = Poems.change_poem(poem)
    end
  end
end
