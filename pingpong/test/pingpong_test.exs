defmodule PingpongTest do
  use ExUnit.Case
  doctest Pingpong

  test "it responds to a ping with a pong" do
    # spawn runs a function from a module with the given args
    # in a new process, which dies when the function
    # completes.
    ping = spawn Ping, :start, []
    # send a message to a process, the tuple is our message
    # which contains both a sort of action ("ping") and a
    # return address (self() returns our PID)
    send ping, {:ping, self()}
    # assert that we got a reply
    assert_receive {:pong, ^ping}
  end
end
