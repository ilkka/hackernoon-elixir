defmodule Fridge do
  @moduledoc """
  A fridge.
  """
  use GenServer

  ### Client API

  def start_link(options \\ []) do
    GenServer.start_link __MODULE__, [], options
  end

  def store(pid, item) do
    GenServer.call(pid, {:store, item})
  end

  def take(pid, item) do
    GenServer.call(pid, {:take, item})
  end

  ### Server API

  def init(_) do
    {:ok, []}
  end

  def handle_call({:store, item}, _from, state) do
    {:reply, :ok, [item | state]}
  end

  def handle_call({:take, item}, _from, state) do
    if Enum.member?(state, item) do
      {:reply, {:ok, item}, List.delete(state, item)}
    else
      {:reply, :not_found, state}
    end
  end
end
