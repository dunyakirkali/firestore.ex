defmodule Firestore do
  alias Firestore.Client

  def hello do
    {:ok, channel} = Client.connect()

    {:ok, reply} = Client.list_collection_ids(channel)
    IO.inspect(reply, label: "Collection IDs")

    Client.list_documents(channel, "countries")
    |> Stream.into([])
    # |> Enum.take(1)
    |> Enum.into([])
    # |> Enum.count

    # Enum.each(0..36000, fn index ->
    #   IO.puts("====> #{index}")
    #   uuid = UUID.uuid1()

    #   value = V1.Value.new(
    #     value_type: {:string_value, uuid}
    #   )

    #   document = V1.Document.new(
    #     fields: %{"name" => value}
    #   )

    #   create_document(channel, "vehicles", document)
    # end)

    # listen(channel)

    Client.disconnect(channel)
  end
end
