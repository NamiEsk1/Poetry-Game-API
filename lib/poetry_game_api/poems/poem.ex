defmodule PoetryGameApi.Poems.Poem do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "poems" do
    field :text, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(poem, attrs) do
    poem
    |> cast(attrs, [:text])
    |> validate_required([:text])
    |> validate_format(:text, ~r/^\w+\s\w+\sThe\s\w+\s\w+$/, message: "nope!")
    |> validate_length(:text, max: 50)
  end
end
