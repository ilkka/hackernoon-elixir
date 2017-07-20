defmodule FirestormData.Thread do
  use Ecto.Schema
  import Ecto.Changeset

  schema "threads" do
    field :title, :string
    belongs_to :category, FirestormData.Category
    timestamps()
  end

  def changeset(thread, params \\ %{}) do
    thread
    |> cast(params, [:category_id, :title])
  end

  def get_recent_threads(category) do
    # alias FirestormData.{Post, Thread, Repo}
    import Ecto.Query
    # This version doesn't work, perhaps because of
    # "distinct: t.id" which forces an initial sort by thread
    # id, or something.
    # from p in Post,
    #   order_by: [desc: p.inserted_at],
    #   left_join: t in Thread, on: [id: p.thread_id],
    #   where: t.category_id == ^category.id,
    #   limit: 3,
    #   distinct: t.id,
    #   select: t
    __MODULE__
      |> join(:left_lateral,
              [t],
              p in fragment("SELECT thread_id, inserted_at FROM posts where posts.thread_id = ? ORDER BY posts.inserted_at DESC LIMIT 1", t.id))
      |> order_by([t, p], [desc: p.inserted_at])
      |> where(category_id: ^category.id)
      |> select([t], t)
      |> limit(3)
  end
end