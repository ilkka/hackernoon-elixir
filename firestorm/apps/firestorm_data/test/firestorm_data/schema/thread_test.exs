defmodule FirestormData.ThreadTest do
  alias FirestormData.{Category, Thread, Repo}
  import FirestormData.Factory
  use ExUnit.Case

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    {:ok, category} = %Category{title: "Elixir"} |> Repo.insert
    # This last bit is us returning test metadata that gets passed to
    # the individual tests
    {:ok, category: category}
  end

  test "creating a thread", %{category: category} do
    changeset =
      %Thread{}
      |> Thread.changeset(%{category_id: category.id, title: "Elixir rocks"})

    assert {:ok, _} = Repo.insert changeset
  end

  test "finding the three threads with the most recent posts in a given category" do
    # build out basics: one category, 5 threads, 3 posts each
    category = insert(:category)
    threads = insert_list(5, :thread, %{category: category})
    for thread <- threads do
      insert_list(3, :post, %{thread: thread})
    end
    # now pick threads 1, 3 and 5 and add a post to each after a delay
    [thread1, thread2, thread3, thread4, thread5] = threads
    :timer.sleep 1
    insert(:post, %{thread: thread1})
    insert(:post, %{thread: thread3})
    insert(:post, %{thread: thread5})
    # now insert a post without specifying the thread, which means
    # that a thread (and hence a category) will be built out for it
    other_thread_post = insert(:post)

    recent_threads =
      category
      |> Thread.get_recent_threads
      |> Repo.all

    thread_ids =
      recent_threads
      |> Enum.map(&(&1.id))

    assert thread1.id in thread_ids
    assert thread3.id in thread_ids
    assert thread5.id in thread_ids
    refute thread2.id in thread_ids
    refute thread4.id in thread_ids
    refute other_thread_post.thread_id in thread_ids
  end
end