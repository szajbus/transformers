defmodule Transformers do
  @moduledoc """
  Transforms nested maps and list of maps
  """

  @doc """
  Returns map (or list of maps) with keys deeply-transformed with the provided function.

  ## Examples

      Camelize keys:

      iex> data = %{"key_one" => 1, "key_two" => 2}
      iex> Transformers.transform_keys(data, &Macro.camelize/1)
      %{"KeyOne" => 1, "KeyTwo" => 2}

      Lists and nested maps are traversed and transformed as well:

      iex> data = %{"the_list" => [%{"map_one" => 1}, %{"map_two" => 2}]}
      iex> Transformers.transform_keys(data, &Macro.camelize/1)
      %{"TheList" => [%{"MapOne" => 1}, %{"MapTwo" => 2}]}

  """
  def transform_keys(map, func) when is_map(map) do
    try do
      for {key, val} <- map,
          into: %{},
          do: {func.(key), transform_keys(val, func)}
    rescue
      Protocol.UndefinedError -> map
    end
  end

  def transform_keys(list, func) when is_list(list) do
    list
    |> Enum.map(&transform_keys(&1, func))
  end

  def transform_keys(any, _), do: any

  @doc """
  Returns map (or list of maps) with values deeply-transformed with the provided function.

  ## Examples

      Upcase values:

      iex> data = %{"one" => "One", "two" => "Two"}
      iex> Transformers.transform_values(data, &String.upcase/1)
      %{"one" => "ONE", "two" => "TWO"}

      Lists and nested maps are traversed and transformed as well:

      iex> data = %{"list" => [%{"one" => "One"}, %{"two" => "Two"}]}
      iex> Transformers.transform_values(data, &String.upcase/1)
      %{"list" => [%{"one" => "ONE"}, %{"two" => "TWO"}]}

  """
  def transform_values(map, func) when is_map(map) do
    try do
      for {key, val} <- map,
          into: %{},
          do: {key, transform_values(val, func)}
    rescue
      Protocol.UndefinedError -> map
    end
  end

  def transform_values(list, func) when is_list(list) do
    list
    |> Enum.map(&transform_values(&1, func))
  end

  def transform_values(any, func) do
    func.(any)
  end
end
