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
    alias FirestormData.{Post, Thread, Repo}
    import Ecto.Query
    from p in Post,
      order_by: [desc: p.inserted_at],
      left_join: t in Thread, on: [id: p.thread_id],
      where: t.category_id == ^category.id,
      limit: 3,
      distinct: t.id,
      select: t
  end
end