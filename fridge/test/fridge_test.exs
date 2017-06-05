defmodule FridgeTest do
  use ExUnit.Case
  doctest Fridge

  test "putting a thing in the fridge" do
    {:ok, fridge} = GenServer.start_link Fridge, [], []
    assert :ok == GenServer.call(fridge, {:store, :bacon})
  end

  test "taking a thing from the fridge" do
    {:ok, fridge} = GenServer.start_link Fridge, [], []
    GenServer.call(fridge, {:store, :bacon})
    assert {:ok, :bacon} == GenServer.call(fridge, {:take, :bacon})
  end

  test "taking something from the fridge that is not there" do
    {:ok, fridge} = GenServer.start_link Fridge, [], []
    assert :not_found == GenServer.call(fridge, {:take, :bacon})
  end

end
