defmodule FirestormData.UserTest do
    alias FirestormData.{User, Repo}
    use ExUnit.Case

    setup do
        :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    end

    test "creating a user" do
        changeset =
            %User{}
            |> User.changeset(%{name: "Ahto Simakuutio",
                                email: "ahto@simakuut.io"})
        assert {:ok, _} = Repo.insert(changeset)
    end

    test "creating a user without an email" do
        changeset =
            %User{}
            |> User.changeset(%{name: "Ahto Simakuutio"})
        # TODO: silly to match the error message here
        assert {:email, {"can't be blank", [validation: :required]}} in changeset.errors
    end

    test "creating a user with an invalid email" do
        changeset =
            %User{}
            |> User.changeset(%{name: "Ahto Simakuutio", email: "invalid"})
        refute changeset.valid?
    end

    test "creating two users with the same email" do
        changeset =
            %User{}
            |> User.changeset(%{name: "Ahto Simakuutio",
                                email: "ahto@simakuut.io"})
        assert {:ok, _} = Repo.insert(changeset)
        {:error, new_changeset} = Repo.insert(changeset)
        assert {:email, {"has already been taken", []}} in new_changeset.errors
    end
end