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
      interceptors: [GRPC.Logger.Client],
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
      page_size: 10,
      collection_id: last_collection
    )

    {:ok, reply} = channel |> Google.Firestore.V1.Firestore.Stub.list_documents(request, content_type: "application/grpc")

    Enum.map(reply.documents, fn document ->
      IO.inspect(document.fields)
    end)
  end
end
