defmodule UpcaserTest do
  use ExUnit.Case
  doctest Upcaser

  test "it responds to a string with the same string in uppercase" do
    assert {:ok, upcaser_pid} = Upcaser.start
    assert is_pid upcaser_pid
    assert {:ok, "MY HOVERCRAFT IS FULL OF EELS"} =
      Upcaser.upcase upcaser_pid, "my hovercraft is full of eels"
  end
end
