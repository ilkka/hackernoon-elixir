defmodule FirestormData.PostTest do
  alias FirestormData.{Category, User, Thread, Post, Repo}
  use ExUnit.Case
  import Ecto.Query

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    {:ok, category} = %Category{title: "Elixir"} |> Repo.insert
    {:ok, thread} = %Thread{category_id: category.id, title: "Elixir rocks"} |> Repo.insert
    {:ok, ahto} = %User{username: "ahto", email: "ahto@simakuut.io", name: "Ahto Simakuutio"} |> Repo.insert
    {:ok, category: category, thread: thread, ahto: ahto}
  end

  test "creating a post", %{thread: thread, ahto: ahto} do
    changeset =
      %Post{}
      |> Post.changeset(%{thread_id: thread.id, body: "Aw yeah", user_id: ahto.id})
    
    assert {:ok, _} = Repo.insert changeset
  end

  describe "given some posts" do
    setup [:create_other_users, :create_sample_posts]

    test "finding a post by user", %{firstpost: firstpost, ahto: ahto} do
      query =
        from p in Post,
          where: p.user_id == ^ahto.id

      posts = Repo.all query
      assert firstpost in posts
    end
  end

  defp create_other_users(_) do
    jorma =
      %User{username: "jorma", email: "jorma@ter.as", name: "Jorma Teräs"}
      |> Repo.insert!
    {:ok, jorma: jorma}
  end

  defp create_sample_posts(%{thread: thread, ahto: ahto, jorma: jorma}) do
    first =
      %Post{}
      |> Post.changeset(%{thread_id: thread.id, user_id: ahto.id, body: "Quite"})
      |> Repo.insert!
    
    second =
      %Post{}
      |> Post.changeset(%{thread_id: thread.id, user_id: jorma.id, body: "Right"})
      |> Repo.insert!

    {:ok, firstpost: first, secondpost: second}
  end
end