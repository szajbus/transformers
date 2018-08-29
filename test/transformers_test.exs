defmodule TransformersTest do
  use ExUnit.Case
  doctest Transformers

  test "transform keys in map" do
    func = &Macro.camelize/1

    map = %{
      "key_one" => "One",
      "key_two" => "Two"
    }

    expected = %{
      "KeyOne" => "One",
      "KeyTwo" => "Two"
    }

    assert Transformers.transform_keys(map, func) == expected
  end

  test "transform keys in list of maps" do
    func = &Macro.camelize/1

    list = [
      %{"key_one" => "One"},
      %{"key_two" => "Two"}
    ]

    expected = [
      %{"KeyOne" => "One"},
      %{"KeyTwo" => "Two"}
    ]

    assert Transformers.transform_keys(list, func) == expected
  end

  test "transform keys in nested map" do
    func = &Macro.camelize/1

    map = %{
      "top_one" => [
        %{"nested_one" => %{"double_nested_one" => "One"}},
        %{"nested_two" => %{"double_nested_two" => "Two"}}
      ],
      "top_two" => %{
        "nested_one" => %{"double_nested_one" => "One"},
        "nested_two" => %{"double_nested_two" => "Two"}
      }
    }

    expected = %{
      "TopOne" => [
        %{"NestedOne" => %{"DoubleNestedOne" => "One"}},
        %{"NestedTwo" => %{"DoubleNestedTwo" => "Two"}}
      ],
      "TopTwo" => %{
        "NestedOne" => %{"DoubleNestedOne" => "One"},
        "NestedTwo" => %{"DoubleNestedTwo" => "Two"}
      }
    }

    assert Transformers.transform_keys(map, func) == expected
  end

  test "does not transform non-enumerables" do
    func = &Macro.camelize/1

    list = [1, :two, "three"]

    assert Transformers.transform_keys(list, func) == list
  end

  test "transform values in map" do
    func = &String.upcase/1

    map = %{
      "key_one" => "One",
      "key_two" => "Two"
    }

    expected = %{
      "key_one" => "ONE",
      "key_two" => "TWO"
    }

    assert Transformers.transform_values(map, func) == expected
  end

  test "transform values in list" do
    func = &String.upcase/1

    list = [
      %{"key_one" => "One"},
      %{"key_two" => "Two"},
      "Three"
    ]

    expected = [
      %{"key_one" => "ONE"},
      %{"key_two" => "TWO"},
      "THREE"
    ]

    assert Transformers.transform_values(list, func) == expected
  end

  test "transform values in nested map" do
    func = &String.upcase/1

    map = %{
      "top_one" => [
        %{"nested_one" => %{"double_nested_one" => "One"}},
        %{"nested_two" => %{"double_nested_two" => "Two"}},
        ["Three", "Four"]
      ],
      "top_two" => %{
        "nested_one" => %{"double_nested_one" => "One"},
        "nested_two" => %{"double_nested_two" => "Two"}
      }
    }

    expected = %{
      "top_one" => [
        %{"nested_one" => %{"double_nested_one" => "ONE"}},
        %{"nested_two" => %{"double_nested_two" => "TWO"}},
        ["THREE", "FOUR"]
      ],
      "top_two" => %{
        "nested_one" => %{"double_nested_one" => "ONE"},
        "nested_two" => %{"double_nested_two" => "TWO"}
      }
    }

    assert Transformers.transform_values(map, func) == expected
  end
end
