defmodule PoetryGameApiWeb.PoemControllerTest do
  use PoetryGameApiWeb.ConnCase

  import PoetryGameApi.PoemsFixtures

  alias PoetryGameApi.Poems.Poem

  @create_attrs %{
    text: "some text"
  }
  @update_attrs %{
    text: "some updated text"
  }
  @invalid_attrs %{text: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all poems", %{conn: conn} do
      conn = get(conn, ~p"/api/poems")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create poem" do
    test "renders poem when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/poems", poem: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/poems/#{id}")

      assert %{
               "id" => ^id,
               "text" => "some text"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/poems", poem: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update poem" do
    setup [:create_poem]

    test "renders poem when data is valid", %{conn: conn, poem: %Poem{id: id} = poem} do
      conn = put(conn, ~p"/api/poems/#{poem}", poem: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/poems/#{id}")

      assert %{
               "id" => ^id,
               "text" => "some updated text"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, poem: poem} do
      conn = put(conn, ~p"/api/poems/#{poem}", poem: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete poem" do
    setup [:create_poem]

    test "deletes chosen poem", %{conn: conn, poem: poem} do
      conn = delete(conn, ~p"/api/poems/#{poem}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/poems/#{poem}")
      end
    end
  end

  defp create_poem(_) do
    poem = poem_fixture()
    %{poem: poem}
  end
end
