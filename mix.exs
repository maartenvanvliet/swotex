defmodule SwotEx.MixProject do
  use Mix.Project

  @version "1.0.2"

  def project do
    [
      app: :swotex,
      version: @version,
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "SwotEx",
      description:
        "Identify email addresses or domains names that belong to colleges or universities.",
      package: [
        maintainers: ["Maarten van Vliet"],
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/maartenvanvliet/swotex"},
        files: ~w(LICENSE README.md lib mix.exs domains)
      ],
      source_url: "https://github.com/maartenvanvliet/swotex",
      docs: [
        main: "readme",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:public_suffix, "~> 0.6.0"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:credo, "~> 1.2.0", only: [:dev, :test], runtime: false}
    ]
  end
end
