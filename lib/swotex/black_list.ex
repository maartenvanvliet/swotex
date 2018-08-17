defmodule SwotEx.Blacklist do
  @moduledoc """
  List of blacklisted domains with .edu tld. They were registered when .edu was
  open for everyone
  """

  @blacklist ~w(
    si.edu
    america.edu
    californiacolleges.edu
    australia.edu
    cet.edu
    folger.edu
  )

  @compiled_blacklist @blacklist
                      |> Enum.map(fn b ->
                        ~r/(\A|\.)#{Regex.escape(b)}\z/
                      end)

  @doc """
  Returns list of regexes for blacklisted domains
  """
  @spec blacklist() :: [Regex.t(), ...]
  def blacklist, do: @compiled_blacklist
end
