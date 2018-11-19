# Transformers

Elixir library for transforming keys and values in nested maps or list of maps.

## Installation

Package can be installed by adding `transformers` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:transformers, "~> 0.1.0"}
  ]
end
```

## Examples

Take a nested map or list of maps:

```elixir
iex> data = %{
  "nested_map" => [
    %{"some_map" => "One"},
    %{"another_map" => "Two"},
    ["Three"]
  ]
}
```

Camelize keys:

```elixir
iex> Transformers.transform_keys(data, &Macro.camelize/1)
%{
  "NestedMap" => [
    %{"SomeMap" => "One"},
    %{"AnotherMap" => "Two"},
    ["Three"]
  ]
}
```

Upcase values:

```elixir
iex> Transformers.transform_values(data, &String.upcase/1)
%{
  "nested_map" => [
    %{"some_map" => "ONE"},
    %{"another_map" => "TWO"},
    ["THREE"]
  ]
}
```

## Docs

Documentation can be found at [https://hexdocs.pm/transformers](https://hexdocs.pm/transformers).

## License

The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT)

Copyright (c) 2018 [Michał Szajbe](https://szajbe.pl)
