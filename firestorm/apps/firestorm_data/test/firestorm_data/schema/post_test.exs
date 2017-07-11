defmodule FirestormData.PostTest do
  alias FirestormData.{Category, User, Thread, Post, Repo}
  use ExUnit.Case

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    {:ok, category} = %Category{title: "Elixir"} |> Repo.insert
    {:ok, thread} = %Thread{category_id: category.id, title: "Elixir rocks"} |> Repo.insert
    {:ok, user} = %User{username: "ahto", email: "ahto@simakuut.io"} |> Repo.insert
    {:ok, category: category, thread: thread, user: user}
  end

  test "creating a post", %{thread: thread, user: user} do
    changeset =
      %Post{}
      |> Post.changeset(%{thread_id: thread.id, body: "Aw yeah", user_id: user.id})
    
    assert {:ok, _} = Repo.insert changeset
  end
end