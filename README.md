# SwotEx

[![Build Status](https://travis-ci.com/maartenvanvliet/swotex.svg?branch=master)](https://travis-ci.com/maartenvanvliet/swotex) [![Hex pm](http://img.shields.io/hexpm/v/swotex.svg?style=flat)](https://hex.pm/packages/swotex) [![Hex Docs](https://img.shields.io/badge/hex-docs-9768d1.svg)](https://hexdocs.pm/swotex) [![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)


Identify email addresses or domains names that belong to colleges or universities. Help automate the process of approving or rejecting academic discounts.


This is a port of [Swot](https://github.com/leereilly/swot) See there for more information.

The list of valid domains is far from complete. If any are missing, please file a PR. 

## Installation

The package can be installed by adding `swotex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:swotex, "~> 1.0.0"}
  ]
end
```

## Usage

```elixir

iex> SwotEx.is_academic?("stanford.edu")
true

iex> SwotEx.is_academic?("lreilly@fadi.at")
true

iex> SwotEx.institution_name("stanford.edu")
"Stanford University"

iex> SwotEx.institution_name("lreilly@fadi.at")
"BRG Fadingerstraße Linz, Austria"
```

## Documentation

The docs can be found at [https://hexdocs.pm/swotex](https://hexdocs.pm/swotex).


## License

See [LICENSE](./LICENSE).