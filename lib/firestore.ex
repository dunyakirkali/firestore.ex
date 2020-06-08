defmodule Firestore do
  alias Goth.Token

  def hello do
    # Get a token
    {:ok, token} = Token.for_scope("https://www.googleapis.com/auth/cloud-platform https://www.googleapis.com/auth/datastore")
    |> IO.inspect

    # Make a call
    root = File.cwd!
    ca_path =
      "#{root}/priv/certs/edgecert-googleapis-com.pem"
      |> IO.inspect

    opts = [
      interceptors: [GRPC.Logger.Client],
      cred: GRPC.Credential.new(ssl: [cacertfile: ca_path]),
      headers: [
        "Authorization": "#{token.type} #{token.token}" 
      ]
    ]
    {:ok, channel} = GRPC.Stub.connect("firestore.googleapis.com:443", opts)

    request = Google.Firestore.V1.ListDocumentsRequest.new(
      parent: "projects/gele-b64ed/databases/(default)/documents",
      page_size: 10
    )

    {:ok, reply} = channel |> Google.Firestore.V1.Firestore.Stub.list_documents(request, content_type: "application/grpc")

    reply
  end
end
