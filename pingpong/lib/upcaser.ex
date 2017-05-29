defmodule Upcaser do
  def start do
    pid = spawn Upcaser, :loop, []
    {:ok, pid}
  end

  def loop do
    receive do
      {pid, ref, {:upcase, str}} -> send pid, {:ok, ref, String.upcase(str)}
      {pid, _} -> send pid, {:error, "Unknown message type"}
    end
    loop()
  end

  def upcase(pid, str) do
    ref = make_ref()
    send pid, {self(), ref, {:upcase, str}}
    receive do
      {:ok, ^ref, str} -> {:ok, str}
    end
  end
end
