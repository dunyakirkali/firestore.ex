defmodule Google.Firestore.V1.DocumentMask do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          field_paths: [String.t()]
        }
  defstruct [:field_paths]

  field :field_paths, 1, repeated: true, type: :string
end

defmodule Google.Firestore.V1.Precondition do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          condition_type: {atom, any}
        }
  defstruct [:condition_type]

  oneof :condition_type, 0
  field :exists, 1, type: :bool, oneof: 0
  field :update_time, 2, type: Google.Protobuf.Timestamp, oneof: 0
end

defmodule Google.Firestore.V1.TransactionOptions.ReadWrite do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          retry_transaction: binary
        }
  defstruct [:retry_transaction]

  field :retry_transaction, 1, type: :bytes
end

defmodule Google.Firestore.V1.TransactionOptions.ReadOnly do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          consistency_selector: {atom, any}
        }
  defstruct [:consistency_selector]

  oneof :consistency_selector, 0
  field :read_time, 2, type: Google.Protobuf.Timestamp, oneof: 0
end

defmodule Google.Firestore.V1.TransactionOptions do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          mode: {atom, any}
        }
  defstruct [:mode]

  oneof :mode, 0
  field :read_only, 2, type: Google.Firestore.V1.TransactionOptions.ReadOnly, oneof: 0
  field :read_write, 3, type: Google.Firestore.V1.TransactionOptions.ReadWrite, oneof: 0
end
