defmodule Firestore do
  alias Firestore.Client

  def hello do
    {:ok, channel} = Client.create_channel()

    {:ok, reply} = Client.list_collection_ids(channel)
    IO.inspect(reply, label: "Collection IDs")

    # list_documents(channel, "vehicles")
    # |> Enum.into([])
    # |> IO.inspect
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
  end
end
