defmodule StatefulprocTest do
  use ExUnit.Case
  doctest Statefulproc

  test "starting the counter" do
    {:ok, pid} = Counter.start(0)
    assert is_pid(pid)
  end

  test "getting the value" do
    {:ok, pid} = Counter.start(0)
    assert {:ok, 0} = Counter.get_value(pid)
  end

  test "incrementing the counter" do
    {:ok, pid} = Counter.start(0)
    :ok = Counter.increment(pid)
    assert {:ok, 1} = Counter.get_value(pid)
  end

  test "decrementing the counter" do
    {:ok, pid} = Counter.start(1)
    :ok = Counter.decrement(pid)
    assert {:ok, 0} = Counter.get_value(pid)
  end
end
