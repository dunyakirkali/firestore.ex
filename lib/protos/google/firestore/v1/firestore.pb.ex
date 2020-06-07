defmodule Google.Firestore.V1.TargetChange.TargetChangeType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t :: integer | :NO_CHANGE | :ADD | :REMOVE | :CURRENT | :RESET

  field :NO_CHANGE, 0
  field :ADD, 1
  field :REMOVE, 2
  field :CURRENT, 3
  field :RESET, 4
end

defmodule Google.Firestore.V1.GetDocumentRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          consistency_selector: {atom, any},
          name: String.t(),
          mask: Google.Firestore.V1.DocumentMask.t() | nil
        }
  defstruct [:consistency_selector, :name, :mask]

  oneof :consistency_selector, 0
  field :name, 1, type: :string
  field :mask, 2, type: Google.Firestore.V1.DocumentMask
  field :transaction, 3, type: :bytes, oneof: 0
  field :read_time, 5, type: Google.Protobuf.Timestamp, oneof: 0
end

defmodule Google.Firestore.V1.ListDocumentsRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          consistency_selector: {atom, any},
          parent: String.t(),
          collection_id: String.t(),
          page_size: integer,
          page_token: String.t(),
          order_by: String.t(),
          mask: Google.Firestore.V1.DocumentMask.t() | nil,
          show_missing: boolean
        }
  defstruct [
    :consistency_selector,
    :parent,
    :collection_id,
    :page_size,
    :page_token,
    :order_by,
    :mask,
    :show_missing
  ]

  oneof :consistency_selector, 0
  field :parent, 1, type: :string
  field :collection_id, 2, type: :string
  field :page_size, 3, type: :int32
  field :page_token, 4, type: :string
  field :order_by, 6, type: :string
  field :mask, 7, type: Google.Firestore.V1.DocumentMask
  field :transaction, 8, type: :bytes, oneof: 0
  field :read_time, 10, type: Google.Protobuf.Timestamp, oneof: 0
  field :show_missing, 12, type: :bool
end

defmodule Google.Firestore.V1.ListDocumentsResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          documents: [Google.Firestore.V1.Document.t()],
          next_page_token: String.t()
        }
  defstruct [:documents, :next_page_token]

  field :documents, 1, repeated: true, type: Google.Firestore.V1.Document
  field :next_page_token, 2, type: :string
end

defmodule Google.Firestore.V1.CreateDocumentRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          parent: String.t(),
          collection_id: String.t(),
          document_id: String.t(),
          document: Google.Firestore.V1.Document.t() | nil,
          mask: Google.Firestore.V1.DocumentMask.t() | nil
        }
  defstruct [:parent, :collection_id, :document_id, :document, :mask]

  field :parent, 1, type: :string
  field :collection_id, 2, type: :string
  field :document_id, 3, type: :string
  field :document, 4, type: Google.Firestore.V1.Document
  field :mask, 5, type: Google.Firestore.V1.DocumentMask
end

defmodule Google.Firestore.V1.UpdateDocumentRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          document: Google.Firestore.V1.Document.t() | nil,
          update_mask: Google.Firestore.V1.DocumentMask.t() | nil,
          mask: Google.Firestore.V1.DocumentMask.t() | nil,
          current_document: Google.Firestore.V1.Precondition.t() | nil
        }
  defstruct [:document, :update_mask, :mask, :current_document]

  field :document, 1, type: Google.Firestore.V1.Document
  field :update_mask, 2, type: Google.Firestore.V1.DocumentMask
  field :mask, 3, type: Google.Firestore.V1.DocumentMask
  field :current_document, 4, type: Google.Firestore.V1.Precondition
end

defmodule Google.Firestore.V1.DeleteDocumentRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          current_document: Google.Firestore.V1.Precondition.t() | nil
        }
  defstruct [:name, :current_document]

  field :name, 1, type: :string
  field :current_document, 2, type: Google.Firestore.V1.Precondition
end

defmodule Google.Firestore.V1.BatchGetDocumentsRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          consistency_selector: {atom, any},
          database: String.t(),
          documents: [String.t()],
          mask: Google.Firestore.V1.DocumentMask.t() | nil
        }
  defstruct [:consistency_selector, :database, :documents, :mask]

  oneof :consistency_selector, 0
  field :database, 1, type: :string
  field :documents, 2, repeated: true, type: :string
  field :mask, 3, type: Google.Firestore.V1.DocumentMask
  field :transaction, 4, type: :bytes, oneof: 0
  field :new_transaction, 5, type: Google.Firestore.V1.TransactionOptions, oneof: 0
  field :read_time, 7, type: Google.Protobuf.Timestamp, oneof: 0
end

defmodule Google.Firestore.V1.BatchGetDocumentsResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          result: {atom, any},
          transaction: binary,
          read_time: Google.Protobuf.Timestamp.t() | nil
        }
  defstruct [:result, :transaction, :read_time]

  oneof :result, 0
  field :found, 1, type: Google.Firestore.V1.Document, oneof: 0
  field :missing, 2, type: :string, oneof: 0
  field :transaction, 3, type: :bytes
  field :read_time, 4, type: Google.Protobuf.Timestamp
end

defmodule Google.Firestore.V1.BeginTransactionRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          database: String.t(),
          options: Google.Firestore.V1.TransactionOptions.t() | nil
        }
  defstruct [:database, :options]

  field :database, 1, type: :string
  field :options, 2, type: Google.Firestore.V1.TransactionOptions
end

defmodule Google.Firestore.V1.BeginTransactionResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          transaction: binary
        }
  defstruct [:transaction]

  field :transaction, 1, type: :bytes
end

defmodule Google.Firestore.V1.CommitRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          database: String.t(),
          writes: [Google.Firestore.V1.Write.t()],
          transaction: binary
        }
  defstruct [:database, :writes, :transaction]

  field :database, 1, type: :string
  field :writes, 2, repeated: true, type: Google.Firestore.V1.Write
  field :transaction, 3, type: :bytes
end

defmodule Google.Firestore.V1.CommitResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          write_results: [Google.Firestore.V1.WriteResult.t()],
          commit_time: Google.Protobuf.Timestamp.t() | nil
        }
  defstruct [:write_results, :commit_time]

  field :write_results, 1, repeated: true, type: Google.Firestore.V1.WriteResult
  field :commit_time, 2, type: Google.Protobuf.Timestamp
end

defmodule Google.Firestore.V1.RollbackRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          database: String.t(),
          transaction: binary
        }
  defstruct [:database, :transaction]

  field :database, 1, type: :string
  field :transaction, 2, type: :bytes
end

defmodule Google.Firestore.V1.RunQueryRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          query_type: {atom, any},
          consistency_selector: {atom, any},
          parent: String.t()
        }
  defstruct [:query_type, :consistency_selector, :parent]

  oneof :query_type, 0
  oneof :consistency_selector, 1
  field :parent, 1, type: :string
  field :structured_query, 2, type: Google.Firestore.V1.StructuredQuery, oneof: 0
  field :transaction, 5, type: :bytes, oneof: 1
  field :new_transaction, 6, type: Google.Firestore.V1.TransactionOptions, oneof: 1
  field :read_time, 7, type: Google.Protobuf.Timestamp, oneof: 1
end

defmodule Google.Firestore.V1.RunQueryResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          transaction: binary,
          document: Google.Firestore.V1.Document.t() | nil,
          read_time: Google.Protobuf.Timestamp.t() | nil,
          skipped_results: integer
        }
  defstruct [:transaction, :document, :read_time, :skipped_results]

  field :transaction, 2, type: :bytes
  field :document, 1, type: Google.Firestore.V1.Document
  field :read_time, 3, type: Google.Protobuf.Timestamp
  field :skipped_results, 4, type: :int32
end

defmodule Google.Firestore.V1.WriteRequest.LabelsEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Google.Firestore.V1.WriteRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          database: String.t(),
          stream_id: String.t(),
          writes: [Google.Firestore.V1.Write.t()],
          stream_token: binary,
          labels: %{String.t() => String.t()}
        }
  defstruct [:database, :stream_id, :writes, :stream_token, :labels]

  field :database, 1, type: :string
  field :stream_id, 2, type: :string
  field :writes, 3, repeated: true, type: Google.Firestore.V1.Write
  field :stream_token, 4, type: :bytes
  field :labels, 5, repeated: true, type: Google.Firestore.V1.WriteRequest.LabelsEntry, map: true
end

defmodule Google.Firestore.V1.WriteResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          stream_id: String.t(),
          stream_token: binary,
          write_results: [Google.Firestore.V1.WriteResult.t()],
          commit_time: Google.Protobuf.Timestamp.t() | nil
        }
  defstruct [:stream_id, :stream_token, :write_results, :commit_time]

  field :stream_id, 1, type: :string
  field :stream_token, 2, type: :bytes
  field :write_results, 3, repeated: true, type: Google.Firestore.V1.WriteResult
  field :commit_time, 4, type: Google.Protobuf.Timestamp
end

defmodule Google.Firestore.V1.ListenRequest.LabelsEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Google.Firestore.V1.ListenRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          target_change: {atom, any},
          database: String.t(),
          labels: %{String.t() => String.t()}
        }
  defstruct [:target_change, :database, :labels]

  oneof :target_change, 0
  field :database, 1, type: :string
  field :add_target, 2, type: Google.Firestore.V1.Target, oneof: 0
  field :remove_target, 3, type: :int32, oneof: 0
  field :labels, 4, repeated: true, type: Google.Firestore.V1.ListenRequest.LabelsEntry, map: true
end

defmodule Google.Firestore.V1.ListenResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          response_type: {atom, any}
        }
  defstruct [:response_type]

  oneof :response_type, 0
  field :target_change, 2, type: Google.Firestore.V1.TargetChange, oneof: 0
  field :document_change, 3, type: Google.Firestore.V1.DocumentChange, oneof: 0
  field :document_delete, 4, type: Google.Firestore.V1.DocumentDelete, oneof: 0
  field :document_remove, 6, type: Google.Firestore.V1.DocumentRemove, oneof: 0
  field :filter, 5, type: Google.Firestore.V1.ExistenceFilter, oneof: 0
end

defmodule Google.Firestore.V1.Target.DocumentsTarget do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          documents: [String.t()]
        }
  defstruct [:documents]

  field :documents, 2, repeated: true, type: :string
end

defmodule Google.Firestore.V1.Target.QueryTarget do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          query_type: {atom, any},
          parent: String.t()
        }
  defstruct [:query_type, :parent]

  oneof :query_type, 0
  field :parent, 1, type: :string
  field :structured_query, 2, type: Google.Firestore.V1.StructuredQuery, oneof: 0
end

defmodule Google.Firestore.V1.Target do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          target_type: {atom, any},
          resume_type: {atom, any},
          target_id: integer,
          once: boolean
        }
  defstruct [:target_type, :resume_type, :target_id, :once]

  oneof :target_type, 0
  oneof :resume_type, 1
  field :query, 2, type: Google.Firestore.V1.Target.QueryTarget, oneof: 0
  field :documents, 3, type: Google.Firestore.V1.Target.DocumentsTarget, oneof: 0
  field :resume_token, 4, type: :bytes, oneof: 1
  field :read_time, 11, type: Google.Protobuf.Timestamp, oneof: 1
  field :target_id, 5, type: :int32
  field :once, 6, type: :bool
end

defmodule Google.Firestore.V1.TargetChange do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          target_change_type: Google.Firestore.V1.TargetChange.TargetChangeType.t(),
          target_ids: [integer],
          cause: Google.Rpc.Status.t() | nil,
          resume_token: binary,
          read_time: Google.Protobuf.Timestamp.t() | nil
        }
  defstruct [:target_change_type, :target_ids, :cause, :resume_token, :read_time]

  field :target_change_type, 1,
    type: Google.Firestore.V1.TargetChange.TargetChangeType,
    enum: true

  field :target_ids, 2, repeated: true, type: :int32
  field :cause, 3, type: Google.Rpc.Status
  field :resume_token, 4, type: :bytes
  field :read_time, 6, type: Google.Protobuf.Timestamp
end

defmodule Google.Firestore.V1.ListCollectionIdsRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          parent: String.t(),
          page_size: integer,
          page_token: String.t()
        }
  defstruct [:parent, :page_size, :page_token]

  field :parent, 1, type: :string
  field :page_size, 2, type: :int32
  field :page_token, 3, type: :string
end

defmodule Google.Firestore.V1.ListCollectionIdsResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          collection_ids: [String.t()],
          next_page_token: String.t()
        }
  defstruct [:collection_ids, :next_page_token]

  field :collection_ids, 1, repeated: true, type: :string
  field :next_page_token, 2, type: :string
end

defmodule Google.Firestore.V1.Firestore.Service do
  @moduledoc false
  use GRPC.Service, name: "google.firestore.v1.Firestore"

  rpc :GetDocument, Google.Firestore.V1.GetDocumentRequest, Google.Firestore.V1.Document

  rpc :ListDocuments,
      Google.Firestore.V1.ListDocumentsRequest,
      Google.Firestore.V1.ListDocumentsResponse

  rpc :UpdateDocument, Google.Firestore.V1.UpdateDocumentRequest, Google.Firestore.V1.Document
  rpc :DeleteDocument, Google.Firestore.V1.DeleteDocumentRequest, Google.Protobuf.Empty

  rpc :BatchGetDocuments,
      Google.Firestore.V1.BatchGetDocumentsRequest,
      stream(Google.Firestore.V1.BatchGetDocumentsResponse)

  rpc :BeginTransaction,
      Google.Firestore.V1.BeginTransactionRequest,
      Google.Firestore.V1.BeginTransactionResponse

  rpc :Commit, Google.Firestore.V1.CommitRequest, Google.Firestore.V1.CommitResponse
  rpc :Rollback, Google.Firestore.V1.RollbackRequest, Google.Protobuf.Empty
  rpc :RunQuery, Google.Firestore.V1.RunQueryRequest, stream(Google.Firestore.V1.RunQueryResponse)
  rpc :Write, stream(Google.Firestore.V1.WriteRequest), stream(Google.Firestore.V1.WriteResponse)

  rpc :Listen,
      stream(Google.Firestore.V1.ListenRequest),
      stream(Google.Firestore.V1.ListenResponse)

  rpc :ListCollectionIds,
      Google.Firestore.V1.ListCollectionIdsRequest,
      Google.Firestore.V1.ListCollectionIdsResponse

  rpc :CreateDocument, Google.Firestore.V1.CreateDocumentRequest, Google.Firestore.V1.Document
end

defmodule Google.Firestore.V1.Firestore.Stub do
  @moduledoc false
  use GRPC.Stub, service: Google.Firestore.V1.Firestore.Service
end
