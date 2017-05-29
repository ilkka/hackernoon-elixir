defmodule Upcaser do
  def start do
    pid = spawn Upcaser, :loop, []
    {:ok, pid}
  end

  def loop do
    receive do
      {pid, {:upcase, str}} -> send pid, {:ok, String.upcase(str)}
      {pid, _} -> send pid, {:error, "Unknown message type"}
    end
    loop()
  end
end
