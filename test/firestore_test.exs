defmodule FirestoreTest do
  use ExUnit.Case
  doctest Firestore

  test "greets the world" do
    assert Firestore.hello() == :world
  end
end
