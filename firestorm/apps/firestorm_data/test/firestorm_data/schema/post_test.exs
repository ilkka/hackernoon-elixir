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

    test "finding posts by user", %{posts: [firstpost | _], ahto: ahto} do
      query =
        from p in Post,
          where: p.user_id == ^ahto.id,
          preload: [:user]

      posts = Repo.all query
      assert firstpost.id in Enum.map(posts, &(&1.id))
      assert hd(posts).user.username == "ahto"
    end

    test "counting posts in a thread", %{threads: [thread | _]} do
      query =
        from p in Post,
          where: p.thread_id == ^thread.id

      postcount = Repo.aggregate(query, :count, :id)
      assert postcount == 2
    end
    
    test "find three most recently updated threads", %{threads: threads} do
      assert true
    end
  end

  defp create_other_users(_) do
    jorma =
      %User{username: "jorma", email: "jorma@ter.as", name: "Jorma Teräs"}
      |> Repo.insert!
    {:ok, jorma: jorma}
  end

  defp create_sample_posts(%{category: category, ahto: ahto, jorma: jorma}) do
    thread1 =
      %Thread{category_id: category.id, title: "Thread1"} |> Repo.insert!
    thread1post1 =
      %Post{thread_id: thread1.id, user_id: ahto.id, body: "Thread1post1"} |> Repo.insert!
    thread1post2 =
      %Post{thread_id: thread1.id, user_id: jorma.id, body: "Thread1post2"} |> Repo.insert!
    thread2 =
      %Thread{category_id: category.id, title: "Thread2"} |> Repo.insert!
    thread2post =
      %Post{thread_id: thread2.id, user_id: ahto.id, body: "Thread2post"} |> Repo.insert!
    thread3 =
      %Thread{category_id: category.id, title: "Thread3"} |> Repo.insert!
    thread3post =
      %Post{thread_id: thread3.id, user_id: jorma.id, body: "Thread3post"} |> Repo.insert!

    {:ok, threads: [thread1, thread2, thread3], posts: [thread1post1, thread1post2, thread2post, thread3post]}
  end

end