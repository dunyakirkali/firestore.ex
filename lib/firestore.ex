defmodule Firestore do
  alias Goth.Token
  alias Google.Firestore.V1

  defp get_token do
    Token.for_scope("https://www.googleapis.com/auth/cloud-platform https://www.googleapis.com/auth/datastore")
  end

  defp create_channel do
    {:ok, token} = get_token()

    # Read CA certificate for certificate pinning
    root = File.cwd!
    ca_path = "#{root}/priv/certs/edgecert-googleapis-com.pem"

    # Prepare options for the client
    opts = [
      interceptors: [GRPC.Logger.Client],
      cred: GRPC.Credential.new(ssl: [cacertfile: ca_path]),
      headers: [
        "Authorization": "#{token.type} #{token.token}" 
      ]
    ]
    # Create the client
    GRPC.Stub.connect("firestore.googleapis.com:443", opts)
  end

  def list_collection_ids(channel) do
    request = V1.ListCollectionIdsRequest.new(
      parent: "projects/gele-b64ed/databases/(default)/documents",
      page_size: 10
    )

    channel
    |> V1.Firestore.Stub.list_collection_ids(request, content_type: "application/grpc")
  end

  def hello do
    {:ok, channel} = create_channel()
    {:ok, reply} = list_collection_ids(channel)

    # Get Documents from the first collection
    last_collection = List.last(reply.collection_ids)
    request = V1.ListDocumentsRequest.new(
      parent: "projects/gele-b64ed/databases/(default)/documents",
      page_size: 10_000,
      collection_id: last_collection
    )

    {:ok, reply} = channel |> V1.Firestore.Stub.list_documents(request, content_type: "application/grpc")
                   |> IO.inspect

    # Create documents
    # Enum.each(0..10_000, fn _ ->
    #   uuid = UUID.uuid1()
    #   value = V1.Value.new(
    #     value_type: {:string_value, uuid}
    #   )
    #   document = V1.Document.new(
    #     fields: %{"name" => value} 
    #   )
    #   request = V1.CreateDocumentRequest.new(
    #     parent: "projects/gele-b64ed/databases/(default)/documents",
    #     collection_id: "vehicles",
    #     document: document
    #   )

    #   {:ok, reply} = channel |> V1.Firestore.Stub.create_document(request, content_type: "application/grpc")
    # end)
    Enum.count(reply.documents)
  end
end
