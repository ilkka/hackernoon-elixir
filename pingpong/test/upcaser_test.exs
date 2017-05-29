defmodule UpcaserTest do
  use ExUnit.Case
  doctest Upcaser

  test "it responds to a string with the same string in uppercase" do
    assert {:ok, upcaser} = Upcaser.start
    assert is_pid upcaser
    send upcaser, {self(), {:upcase, "my hovercraft is full of eels"}}
    assert_receive {:ok, "MY HOVERCRAFT IS FULL OF EELS"}
  end
end
