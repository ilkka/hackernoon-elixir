defmodule RpnServer.Calculator do
  use GenServer
  alias RpnServer.TapePrinter

  @moduledoc """
  The calculator worker module. Add to supervision tree, do work.
  """

  # client

  def start_link(options \\ []) do
    GenServer.start_link(__MODULE__, [], options)
  end

  def peek(pid) do
    GenServer.call(pid, :peek)
  end

  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  def push(pid, val) do
    GenServer.cast(pid, {:push, val})
  end

  def clear(pid) do
    GenServer.cast(pid, {:clear})
  end

  ### server

  def init() do
    {:ok, []}
  end

  def handle_call(:peek, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:pop, _from, [head | rest]) do
    {:reply, head, rest}
  end
  
  def handle_cast({:push, :+}, [second | [first | rest ]]) do
    val = first + second
    TapePrinter.print(val)
    {:noreply, [val | rest]}
  end

  def handle_cast({:push, :-}, [second | [first | rest ]]) do
    val = first - second
    TapePrinter.print(val)
    {:noreply, [val | rest]}
  end

  def handle_cast({:push, :x}, [second | [first | rest ]]) do
    val = first * second
    TapePrinter.print(val)
    {:noreply, [val | rest]}
  end

  def handle_cast({:push, val}, state) do
    {:noreply, [val | state]}
  end

  def handle_cast({:clear}, _state) do
    {:noreply, []}
  end
  
end
