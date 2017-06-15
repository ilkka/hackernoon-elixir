defmodule RpnServer.Calculator do
  @moduledoc """
  The calculator worker module. Add to supervision tree, do work.
  """

  def start_link(name) do
    Agent.start_link(fn() -> [] end, [name: name])
  end

  def clear(pid) do
    Agent.update(pid, fn(_state) -> [] end)
  end

  def peek(pid) do
    Agent.get(pid, fn(state) -> state end)
  end

  def pop(pid) do
    Agent.get_and_update(pid, fn([first | rest]) -> {first, rest} end)
  end

  def push(pid, :+) do
    Agent.update(pid, fn(state) ->
      [second | [first | rest ]] = state
      [first + second | rest]
    end)
  end

  def push(pid, :-) do
    Agent.update(pid, fn(state) ->
      [second | [first | rest ]] = state
      [first - second | rest]
    end)
  end

  def push(pid, :x) do
    Agent.update(pid, fn(state) ->
      [second | [first | rest ]] = state
      [first * second | rest]
    end)
  end

  def push(pid, val) do
    Agent.update(pid, fn(state) -> [val | state] end)
  end
end
