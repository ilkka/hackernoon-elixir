defmodule RpnServerTest do
  use ExUnit.Case
  doctest RpnServer

  test "pushing onto the stack" do
    RpnServer.Calculator.push(Default, 5)
    assert RpnServer.Calculator.peek(Default) == [5]
    RpnServer.Calculator.push(Default, 1)
    assert RpnServer.Calculator.peek(Default) == [1, 5]
  end

  test "is empty after clearing" do
    RpnServer.Calculator.clear(Default)
    assert RpnServer.Calculator.peek(Default) == []
  end

  test "adding" do
    RpnServer.Calculator.push(Default, 5)
    RpnServer.Calculator.push(Default, 1)
    RpnServer.Calculator.push(Default, :+)
    assert RpnServer.Calculator.pop(Default) == 6
  end

  test "subtracting" do
    RpnServer.Calculator.push(Default, 5)
    RpnServer.Calculator.push(Default, 1)
    RpnServer.Calculator.push(Default, :-)
    assert RpnServer.Calculator.pop(Default) == 4
  end

  test "multiplying" do
    RpnServer.Calculator.push(Default, 5)
    RpnServer.Calculator.push(Default, 2)
    RpnServer.Calculator.push(Default, :x)
    assert RpnServer.Calculator.pop(Default) == 10
  end

  test "wikipedia example" do
    RpnServer.Calculator.push(Default, 5)
    RpnServer.Calculator.push(Default, 1)
    RpnServer.Calculator.push(Default, 2)
    RpnServer.Calculator.push(Default, :+)
    RpnServer.Calculator.push(Default, 4)
    RpnServer.Calculator.push(Default, :x)
    RpnServer.Calculator.push(Default, :+)
    RpnServer.Calculator.push(Default, 3)
    RpnServer.Calculator.push(Default, :-)
    assert RpnServer.Calculator.pop(Default) == 14
  end
end
