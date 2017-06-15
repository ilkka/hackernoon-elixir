defmodule RpnServer.Calculator do
  use GenServer

  @moduledoc """
  The calculator worker module. Add to supervision tree, do work.
  """

  # client

  def start do
    GenServer.start(__MODULE__, [])
  end

  def peek(pid) do
    GenServer.call(pid, :peek)
  end

  def push(pid, val) do
    GenServer.cast(pid, {:push, val})
  end

  ### server

  def init() do
    {:ok, []}
  end

  def handle_call(:peek, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:push, :+}, _from, [second | [first | rest ]]) do
    {:noreply, [(first + second) | rest]}
  end

  def handle_cast({:push, :-}, _from, [second | [first | rest ]]) do
    {:noreply, [(first - second) | rest]}
  end

  def handle_cast({:push, :x}, _from, [second | [first | rest ]]) do
    {:noreply, [(first * second) | rest]}
  end

  def handle_cast({:push, val}, _from, state) do
    {:noreply, [val | state]}
  end
end
