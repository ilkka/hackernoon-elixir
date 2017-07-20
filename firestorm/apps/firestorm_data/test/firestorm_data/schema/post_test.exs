defmodule FirestormData.PostTest do
  alias FirestormData.{Category, User, Thread, Post, Repo}
  use ExUnit.Case
  import Ecto.Query
  import FirestormData.Factory

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "finding posts by a user" do
    test_user = insert(:user)
    [post1, post2, post3] = insert_list(3, :post, %{user: test_user})
    [post4, post5, post6] = insert_list(3, :post)

    post_ids =
      test_user
      |> Post.for_user
      |> Repo.all
      |> Enum.map(&(&1.id))

    assert post1.id in post_ids
    assert post2.id in post_ids
    assert post3.id in post_ids
    refute post4.id in post_ids
    refute post5.id in post_ids
    refute post6.id in post_ids
  end
end