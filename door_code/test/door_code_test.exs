defmodule DoorCodeTest do
  use ExUnit.Case
  doctest DoorCode

  @code [1, 2, 3]
  @open_time 100

  test "happy path" do
    # door args are code, remaining digits and how long to be unlocked
    {:ok, door} = Door.start_link({@code, @code, @open_time})
    # starts locked
    assert Door.get_state(door) == :locked
    # enter code digits, checking that door is locked until the end
    door |> Door.press(1)
    assert Door.get_state(door) == :locked
    door |> Door.press(2)
    assert Door.get_state(door) == :locked
    door |> Door.press(3)
    # that was the last digit, check that door is open for the specified time
    assert Door.get_state(door) == :open
    :timer.sleep(@open_time)
    assert Door.get_state(door) == :locked
  end
end
