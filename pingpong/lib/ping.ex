defmodule Ping do
  def start do
    loop()
  end

  def loop do
    receive do
      {:ping, from} -> send from, {:pong, self()}
    end
    loop()
  end
end
