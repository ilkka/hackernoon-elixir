defmodule Fridge do
  @moduledoc """
  A fridge.
  """
  use GenServer

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
