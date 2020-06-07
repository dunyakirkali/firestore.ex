defmodule Firestore do
  alias Goth.Token

  def hello do
    {:ok, token} = Token.for_scope("https://www.googleapis.com/auth/pubsub")
  end
end
