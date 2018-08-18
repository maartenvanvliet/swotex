defmodule SwotEx do
  alias SwotEx.{AcademicTlds, Blacklist}

  @moduledoc """
  Identify email addresses or domains names that belong to colleges or universities.

  """

  @domains_path "domains"

  @doc """
  Returns whether the given email address or domain name is used by an academic institution or not

  ## Examples

      iex> SwotEx.is_academic?("stanford.edu")
      true

      iex> SwotEx.is_academic?("lreilly@fadi.at")
      true
  """
  @spec is_academic?(String.t() | nil) :: boolean()
  def is_academic?(domain) when is_binary(domain) do
    domain
    |> extract_host()
    |> do_is_academic?
  end

  def is_academic?(_), do: false

  @doc """
  Returns name of institution belonging to the email address or domain name given, nil if the
  institution was not found

  ## Examples

      iex> SwotEx.institution_name("stanford.edu")
      "Stanford University"

      iex> SwotEx.institution_name("lreilly@fadi.at")
      "BRG Fadingerstraße Linz, Austria"
  """
  @spec institution_name(String.t() | nil) :: nil | String.t()
  def institution_name(domain) when is_binary(domain) do
    domain
    |> extract_host
    |> registrable_domain
    |> build_file_path
    |> File.read()
    |> case do
      {:error, _} -> nil
      {:ok, name} -> String.trim(name)
    end
  end

  defp extract_host(domain) do
    %URI{host: host} =
      domain
      |> extract_domain_from_email()
      |> String.trim()
      |> String.downcase()
      |> build_uri

    host
  end

  defp do_is_academic?(nil), do: false

  defp do_is_academic?(domain) do
    cond do
      blacklisted?(domain) -> false
      valid_suffix?(domain) -> true
      valid_domain?(domain) -> true
      true -> false
    end
  end

  defp blacklisted?(domain) do
    Blacklist.blacklist()
    |> Enum.any?(fn b ->
      Regex.match?(b, domain)
    end)
  end

  defp valid_suffix?(domain) do
    PublicSuffix.public_suffix(domain) in AcademicTlds.academic_tlds()
  end

  defp valid_domain?(domain) do
    case registrable_domain(domain) do
      nil ->
        false

      domain ->
        domain
        |> build_file_path
        |> File.exists?()
    end
  end

  defp registrable_domain(domain) do
    domain
    |> PublicSuffix.registrable_domain()
  end

  defp extract_domain_from_email(domain) do
    [domain | _] = domain |> String.split("@") |> Enum.reverse()

    domain
  end

  defp build_uri(domain) do
    case domain do
      "http://" <> _ -> URI.parse(domain)
      "https://" <> _ -> URI.parse(domain)
      "//" <> _ -> URI.parse(domain)
      _ -> build_uri("http://" <> domain)
    end
  end

  defp build_file_path(domain) do
    Path.join([@domains_path | domain |> String.split(".") |> Enum.reverse()]) <> ".txt"
  end
end
