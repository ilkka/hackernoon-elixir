use Mix.Config

config :firestorm_data, FirestormData.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "firestorm_data_repo_dev",
  username: System.get_env("POSTGRES_USER") || "postgres",
  password: System.get_env("POSTGRES_PASSWORD") || "postgres",
  hostname: System.get_env("POSTGRES_HOST") || "localhost",
  pool: Ecto.Adapters.SQL.Sandbox