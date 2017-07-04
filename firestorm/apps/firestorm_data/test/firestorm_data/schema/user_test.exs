defmodule FirestormData.UserTest do
    alias FirestormData.{User, Repo}
    use ExUnit.Case

    setup do
        :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    end

    test "creating a user" do
        ahto = %User{name: "Ahto Simakuutio"}
        assert {:ok, _} = Repo.insert(ahto)
    end
end