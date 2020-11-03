defmodule Firestore.Client do
  alias Goth.Token
  alias Google.Firestore.V1

  @database "projects/firestore-37c38/databases/(default)"
  @parent "#{@database}/documents"
  @scopes [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/datastore"
  ]
  @page_size 1000

  @doc """
    https://firebase.google.com/docs/firestore/reference/rpc/google.firestore.v1#google.firestore.v1.Firestore.ListCollectionIds
  """
  def list_collection_ids(channel) do
    request =
      V1.ListCollectionIdsRequest.new(
        parent: @parent,
        page_size: @page_size
      )

    V1.Firestore.Stub.list_collection_ids(channel, request, content_type: "application/grpc")
  end

  @doc """
    https://firebase.google.com/docs/firestore/reference/rpc/google.firestore.v1#google.firestore.v1.Firestore.ListDocuments
  """
  def list_documents(channel, collection) do
    start = fn ->
      {[], nil}
    end

    pop_item = fn {[head | tail], next} ->
      new_state = {tail, next}
      {[head], new_state}
    end

    fetch_next_page = fn state = {[], next_page} ->
      case do_list_documents(channel, collection, next_page) do
        {:ok, %{documents: items, next_page_token: page_token}} ->
          pop_item.({items, page_token})

        result ->
          IO.inspect(result)
          {:halt, state}
      end
    end

    next_item = fn
      state = {[], ""} -> {:halt, state}
      state = {[], next} -> fetch_next_page.(state)
      state -> pop_item.(state)
    end

    stop = fn state ->
      elem(state, 0)
    end

    Stream.resource(start, next_item, stop)
  end

  defp do_list_documents(channel, collection, next_page_token \\ nil) do
    request =
      V1.ListDocumentsRequest.new(
        parent: @parent,
        page_size: @page_size,
        collection_id: collection,
        page_token: next_page_token
      )

    V1.Firestore.Stub.list_documents(channel, request, content_type: "application/grpc")
  end

  @doc """
  https://firebase.google.com/docs/firestore/reference/rpc/google.firestore.v1#google.firestore.v1.Firestore.CreateDocument
  """
  def create_document(channel, collection, document) do
    request =
      V1.CreateDocumentRequest.new(
        parent: @parent,
        collection_id: collection,
        document: document
      )

    V1.Firestore.Stub.create_document(channel, request, content_type: "application/grpc")
  end

  @doc """
  https://firebase.google.com/docs/firestore/reference/rpc/google.firestore.v1#google.firestore.v1.Firestore.Listen
  """
  def listen(channel) do
    document_target =
      V1.Target.DocumentsTarget.new(
        documents: [
          "projects/gele-b64ed/databases/(default)/documents/vehicles/4225Ii69RoVYF0ddSKvw"
        ]
      )

    target = V1.Target.new(target_type: {:documents, document_target})

    request =
      V1.ListenRequest.new(
        database: @database,
        target_change: {:add_target, target},
        labels: %{"type" => "string"}
      )
      |> IO.inspect()

    stream = V1.Firestore.Stub.listen(channel)
    GRPC.Stub.send_request(stream, request, end_stream: false)
    do_listen(stream)
  end

  defp do_listen(stream) do
    {:ok, reply_enum} = GRPC.Stub.recv(stream)

    replies =
      Enum.map(reply_enum, fn {:ok, reply} -> reply end)
      |> IO.inspect()

    do_listen(stream)
  end

  defp get_token do
    @scopes
    |> Enum.join(" ")
    |> Token.for_scope()
  end

  def connect do
    {:ok, token} = get_token()

    # Read CA certificate for certificate pinning
    root = File.cwd!()
    ca_path = "#{root}/priv/certs/edgecert-googleapis-com.pem"

    # Prepare options for the client
    opts = [
      interceptors: [],
      # interceptors: [GRPC.Logger.Client],
      cred: GRPC.Credential.new(ssl: [cacertfile: ca_path]),
      headers: [
        Authorization: "#{token.type} #{token.token}"
      ]
    ]

    # Create the client
    GRPC.Stub.connect("firestore.googleapis.com:443", opts)
  end
end
