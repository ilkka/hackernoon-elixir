defmodule RpnServerTest do
  use ExUnit.Case
  doctest RpnServer

  test "pushing onto the stack" do
    RpnServer.Calculator.push(Rpn, 5)
    assert RpnServer.Calculator.peek(Rpn) == [5]
    RpnServer.Calculator.push(Rpn, 1)
    assert RpnServer.Calculator.peek(Rpn) == [1, 5]
  end

  test "is empty after clearing" do
    RpnServer.Calculator.clear(Rpn)
    assert RpnServer.Calculator.peek(Rpn) == []
  end

  test "adding" do
    RpnServer.Calculator.push(Rpn, 5)
    RpnServer.Calculator.push(Rpn, 1)
    RpnServer.Calculator.push(Rpn, :+)
    assert RpnServer.Calculator.pop(Rpn) == 6
  end

  test "subtracting" do
    RpnServer.Calculator.push(Rpn, 5)
    RpnServer.Calculator.push(Rpn, 1)
    RpnServer.Calculator.push(Rpn, :-)
    assert RpnServer.Calculator.pop(Rpn) == 4
  end

  test "multiplying" do
    RpnServer.Calculator.push(Rpn, 5)
    RpnServer.Calculator.push(Rpn, 2)
    RpnServer.Calculator.push(Rpn, :x)
    assert RpnServer.Calculator.pop(Rpn) == 10
  end

  test "wikipedia example" do
    RpnServer.Calculator.push(Rpn, 5)
    RpnServer.Calculator.push(Rpn, 1)
    RpnServer.Calculator.push(Rpn, 2)
    RpnServer.Calculator.push(Rpn, :+)
    RpnServer.Calculator.push(Rpn, 4)
    RpnServer.Calculator.push(Rpn, :x)
    RpnServer.Calculator.push(Rpn, :+)
    RpnServer.Calculator.push(Rpn, 3)
    RpnServer.Calculator.push(Rpn, :-)
    assert RpnServer.Calculator.pop(Rpn) == 14
  end
end
