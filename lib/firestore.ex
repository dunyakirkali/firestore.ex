defmodule Firestore do
  alias Goth.Token

  def hello do
    # Get a token
    {:ok, token} = Token.for_scope("https://www.googleapis.com/auth/cloud-platform https://www.googleapis.com/auth/datastore")
    |> IO.inspect

    # Read CA certificate for certificate pinning
    root = File.cwd!
    ca_path =
      "#{root}/priv/certs/edgecert-googleapis-com.pem"
      |> IO.inspect

    # Prepare options for the client
    opts = [
      #interceptors: [GRPC.Logger.Client],
      cred: GRPC.Credential.new(ssl: [cacertfile: ca_path]),
      headers: [
        "Authorization": "#{token.type} #{token.token}" 
      ]
    ]
    # Create the client
    {:ok, channel} = GRPC.Stub.connect("firestore.googleapis.com:443", opts)

    # Get Collection Ids
    request = Google.Firestore.V1.ListCollectionIdsRequest.new(
      parent: "projects/gele-b64ed/databases/(default)/documents",
      page_size: 10
    )

    {:ok, reply} = channel |> Google.Firestore.V1.Firestore.Stub.list_collection_ids(request, content_type: "application/grpc")

    # Get Documents from the first collection
    last_collection = List.last(reply.collection_ids)
    request = Google.Firestore.V1.ListDocumentsRequest.new(
      parent: "projects/gele-b64ed/databases/(default)/documents",
      page_size: 1000,
      collection_id: last_collection
    )

    {:ok, reply} = channel |> Google.Firestore.V1.Firestore.Stub.list_documents(request, content_type: "application/grpc")

    # Create documents
    Enum.each(0..10_000, fn _ ->
      uuid = UUID.uuid1()
      value = Google.Firestore.V1.Value.new(
        value_type: {:string_value, uuid}
      )
      document = Google.Firestore.V1.Document.new(
        fields: %{"name" => value} 
      )
      request = Google.Firestore.V1.CreateDocumentRequest.new(
        parent: "projects/gele-b64ed/databases/(default)/documents",
        collection_id: "vehicles",
        document: document
      )

      {:ok, reply} = channel |> Google.Firestore.V1.Firestore.Stub.create_document(request, content_type: "application/grpc")
    end)
  end
end
