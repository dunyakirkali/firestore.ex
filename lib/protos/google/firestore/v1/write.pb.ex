defmodule Google.Firestore.V1.DocumentTransform.FieldTransform.ServerValue do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t :: integer | :SERVER_VALUE_UNSPECIFIED | :REQUEST_TIME

  field :SERVER_VALUE_UNSPECIFIED, 0
  field :REQUEST_TIME, 1
end

defmodule Google.Firestore.V1.Write do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          operation: {atom, any},
          update_mask: Google.Firestore.V1.DocumentMask.t() | nil,
          update_transforms: [Google.Firestore.V1.DocumentTransform.FieldTransform.t()],
          current_document: Google.Firestore.V1.Precondition.t() | nil
        }
  defstruct [:operation, :update_mask, :update_transforms, :current_document]

  oneof :operation, 0
  field :update, 1, type: Google.Firestore.V1.Document, oneof: 0
  field :delete, 2, type: :string, oneof: 0
  field :transform, 6, type: Google.Firestore.V1.DocumentTransform, oneof: 0
  field :update_mask, 3, type: Google.Firestore.V1.DocumentMask

  field :update_transforms, 7,
    repeated: true,
    type: Google.Firestore.V1.DocumentTransform.FieldTransform

  field :current_document, 4, type: Google.Firestore.V1.Precondition
end

defmodule Google.Firestore.V1.DocumentTransform.FieldTransform do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          transform_type: {atom, any},
          field_path: String.t()
        }
  defstruct [:transform_type, :field_path]

  oneof :transform_type, 0
  field :field_path, 1, type: :string

  field :set_to_server_value, 2,
    type: Google.Firestore.V1.DocumentTransform.FieldTransform.ServerValue,
    enum: true,
    oneof: 0

  field :increment, 3, type: Google.Firestore.V1.Value, oneof: 0
  field :maximum, 4, type: Google.Firestore.V1.Value, oneof: 0
  field :minimum, 5, type: Google.Firestore.V1.Value, oneof: 0
  field :append_missing_elements, 6, type: Google.Firestore.V1.ArrayValue, oneof: 0
  field :remove_all_from_array, 7, type: Google.Firestore.V1.ArrayValue, oneof: 0
end

defmodule Google.Firestore.V1.DocumentTransform do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          document: String.t(),
          field_transforms: [Google.Firestore.V1.DocumentTransform.FieldTransform.t()]
        }
  defstruct [:document, :field_transforms]

  field :document, 1, type: :string

  field :field_transforms, 2,
    repeated: true,
    type: Google.Firestore.V1.DocumentTransform.FieldTransform
end

defmodule Google.Firestore.V1.WriteResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          update_time: Google.Protobuf.Timestamp.t() | nil,
          transform_results: [Google.Firestore.V1.Value.t()]
        }
  defstruct [:update_time, :transform_results]

  field :update_time, 1, type: Google.Protobuf.Timestamp
  field :transform_results, 2, repeated: true, type: Google.Firestore.V1.Value
end

defmodule Google.Firestore.V1.DocumentChange do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          document: Google.Firestore.V1.Document.t() | nil,
          target_ids: [integer],
          removed_target_ids: [integer]
        }
  defstruct [:document, :target_ids, :removed_target_ids]

  field :document, 1, type: Google.Firestore.V1.Document
  field :target_ids, 5, repeated: true, type: :int32
  field :removed_target_ids, 6, repeated: true, type: :int32
end

defmodule Google.Firestore.V1.DocumentDelete do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          document: String.t(),
          removed_target_ids: [integer],
          read_time: Google.Protobuf.Timestamp.t() | nil
        }
  defstruct [:document, :removed_target_ids, :read_time]

  field :document, 1, type: :string
  field :removed_target_ids, 6, repeated: true, type: :int32
  field :read_time, 4, type: Google.Protobuf.Timestamp
end

defmodule Google.Firestore.V1.DocumentRemove do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          document: String.t(),
          removed_target_ids: [integer],
          read_time: Google.Protobuf.Timestamp.t() | nil
        }
  defstruct [:document, :removed_target_ids, :read_time]

  field :document, 1, type: :string
  field :removed_target_ids, 2, repeated: true, type: :int32
  field :read_time, 4, type: Google.Protobuf.Timestamp
end

defmodule Google.Firestore.V1.ExistenceFilter do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          target_id: integer,
          count: integer
        }
  defstruct [:target_id, :count]

  field :target_id, 1, type: :int32
  field :count, 2, type: :int32
end
