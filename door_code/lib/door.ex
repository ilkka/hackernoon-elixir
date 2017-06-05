defmodule Door do
  use GenStateMachine

  ## Client API

  def start_link({code, remaining, unlock_time}) do
    GenStateMachine.start_link(Door, {:locked, {code, remaining, unlock_time}})
  end

  def get_state(pid) do
    {state, _data} = :sys.get_state(pid)
    state
  end

  def press(pid, digit) do
    GenStateMachine.cast(pid, {:press, digit})
  end

  ## Server API

  @doc """
  Handle a get state call.

  It is a call because it expects a reply.
  """
  def handle_event({:call, from}, :get_state, state, data) do
    {:next_state, state, data, [{:reply, from, state}]}
  end

  @doc """
  Handle a digit press cast.

  It is a cast because it does *not* get a reply.
  """
  def handle_event(:cast, {:press, digit}, :locked, {code, remaining, unlock_time}) do
    case remaining do
      [^digit] ->
        IO.puts "[#{digit}] Correct code. Unlocked."
        # the last thing returned here is a timeout and causes a :timeout event
        {:next_state, :open, {code, code, unlock_time}, unlock_time}
      [^digit|rest] ->
        IO.puts "[#{digit}]"
        # same here
        {:next_state, :locked, {code, rest, unlock_time}, unlock_time}
      _ ->
        IO.puts "[#{digit}]"
        {:next_state, :locked, {code, code, unlock_time}}
    end
  end

  def handle_event(:timeout, _, _state, data) do
    IO.puts "Timeout, locking"
    {:next_state, :locked, data}
  end
end
