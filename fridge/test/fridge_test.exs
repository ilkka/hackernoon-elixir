defmodule FridgeTest do
  use ExUnit.Case
  doctest Fridge

  test "putting a thing in the fridge" do
    {:ok, fridge} = Fridge.start_link
    assert :ok == Fridge.store(fridge, :bacon)
  end

  test "taking a thing from the fridge" do
    {:ok, fridge} = Fridge.start_link
    Fridge.store(fridge, :bacon)
    assert {:ok, :bacon} == Fridge.take(fridge, :bacon)
  end

  test "taking something from the fridge that is not there" do
    {:ok, fridge} = Fridge.start_link
    assert :not_found == Fridge.take(fridge, :bacon)
  end

end
