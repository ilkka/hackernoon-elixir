defmodule Ping do
  def start do
    # pattern match on messages and send replies
    receive do
      {:ping, from} -> send from, {:pong, self()}
    end
  end
end
