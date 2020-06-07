defmodule Google.Firestore.V1.Document.FieldsEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: Google.Firestore.V1.Value.t() | nil
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: Google.Firestore.V1.Value
end

defmodule Google.Firestore.V1.Document do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          fields: %{String.t() => Google.Firestore.V1.Value.t() | nil},
          create_time: Google.Protobuf.Timestamp.t() | nil,
          update_time: Google.Protobuf.Timestamp.t() | nil
        }
  defstruct [:name, :fields, :create_time, :update_time]

  field :name, 1, type: :string
  field :fields, 2, repeated: true, type: Google.Firestore.V1.Document.FieldsEntry, map: true
  field :create_time, 3, type: Google.Protobuf.Timestamp
  field :update_time, 4, type: Google.Protobuf.Timestamp
end

defmodule Google.Firestore.V1.Value do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value_type: {atom, any}
        }
  defstruct [:value_type]

  oneof :value_type, 0
  field :null_value, 11, type: Google.Protobuf.NullValue, enum: true, oneof: 0
  field :boolean_value, 1, type: :bool, oneof: 0
  field :integer_value, 2, type: :int64, oneof: 0
  field :double_value, 3, type: :double, oneof: 0
  field :timestamp_value, 10, type: Google.Protobuf.Timestamp, oneof: 0
  field :string_value, 17, type: :string, oneof: 0
  field :bytes_value, 18, type: :bytes, oneof: 0
  field :reference_value, 5, type: :string, oneof: 0
  field :geo_point_value, 8, type: Google.Type.LatLng, oneof: 0
  field :array_value, 9, type: Google.Firestore.V1.ArrayValue, oneof: 0
  field :map_value, 6, type: Google.Firestore.V1.MapValue, oneof: 0
end

defmodule Google.Firestore.V1.ArrayValue do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          values: [Google.Firestore.V1.Value.t()]
        }
  defstruct [:values]

  field :values, 1, repeated: true, type: Google.Firestore.V1.Value
end

defmodule Google.Firestore.V1.MapValue.FieldsEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: Google.Firestore.V1.Value.t() | nil
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: Google.Firestore.V1.Value
end

defmodule Google.Firestore.V1.MapValue do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          fields: %{String.t() => Google.Firestore.V1.Value.t() | nil}
        }
  defstruct [:fields]

  field :fields, 1, repeated: true, type: Google.Firestore.V1.MapValue.FieldsEntry, map: true
end
