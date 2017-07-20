ExUnit.start()
# When testing, run in manual ownership mode
# Note that if doing async task stuff this will cause problems
# (see https://medium.com/@qertoip/making-sense-of-ecto-2-sql-sandbox-and-connection-ownership-modes-b45c5337c6b7)
Ecto.Adapters.SQL.Sandbox.mode(FirestormData.Repo, :manual)
{:ok, _} = Application.ensure_all_started(:ex_machina)