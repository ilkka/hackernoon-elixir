defmodule Schizo do
  @moduledoc """
  Silly module for silly things
  """

  @doc """
  Pass every other word of string through a function, returning the
  concatenated result. Note how the period works for calling the
  function through the reference.
  """
  def every_other_word(string, fun) do
    string
    |> String.split(" ")
    |> Enum.with_index
    |> Enum.map(fn({word, index}) ->
      if rem(index, 2) == 0 do
        word
      else
        fun.(word)
      end
    end)
    |> Enum.join(" ")
  end

  @doc """
  Uppercase every other word

  ## Examples

      iex> Schizo.uppercase "foo"
      "foo"

      iex> Schizo.uppercase "foo bar"
      "foo BAR"

      iex> Schizo.uppercase "foo bar baz quux"
      "foo BAR baz QUUX"

  """
  def uppercase(string) do
    string
    |> every_other_word(&String.upcase/1)
  end

  @doc """
  Remove vowels from every other word. Note how the ampersand operator
  together with &1 is used to choose where the parameter is injected.

  ## Examples

      iex> Schizo.unvowel "foo"
      "foo"

      iex> Schizo.unvowel "foo bar"
      "foo br"

      iex> Schizo.unvowel "foo bar baz quux"
      "foo br baz qx"

  """
  def unvowel(string) do
    string
    |> every_other_word(&Regex.replace(~r/[aeiouyäö]/i, &1, ""))
  end
end
