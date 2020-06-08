defmodule FirestoreTest do
  use ExUnit.Case
  doctest Firestore

  test "greets the world" do
    assert Firestore.hello() == [%{"name" => %Google.Firestore.V1.Value{value_type: {:string_value, "Ferrari"}}}] 
  end
end
