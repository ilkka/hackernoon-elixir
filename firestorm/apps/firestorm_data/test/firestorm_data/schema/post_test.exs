defmodule FirestormData.PostTest do
  alias FirestormData.{Category, User, Thread, Post, Repo}
  use ExUnit.Case
  import Ecto.Query

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

end