defmodule FirestoreTest do
  use ExUnit.Case
  doctest Firestore

  test "greets the world" do
    assert Firestore.hello() == 300
  end
end
