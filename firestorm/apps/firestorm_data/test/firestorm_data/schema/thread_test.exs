defmodule FirestormData.ThreadTest do
  alias FirestormData.{Category, Thread, Repo}
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
end