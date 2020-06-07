defmodule Google.Firestore.V1.StructuredQuery.Direction do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t :: integer | :DIRECTION_UNSPECIFIED | :ASCENDING | :DESCENDING

  field :DIRECTION_UNSPECIFIED, 0
  field :ASCENDING, 1
  field :DESCENDING, 2
end

defmodule Google.Firestore.V1.StructuredQuery.CompositeFilter.Operator do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t :: integer | :OPERATOR_UNSPECIFIED | :AND

  field :OPERATOR_UNSPECIFIED, 0
  field :AND, 1
end

defmodule Google.Firestore.V1.StructuredQuery.FieldFilter.Operator do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t ::
          integer
          | :OPERATOR_UNSPECIFIED
          | :LESS_THAN
          | :LESS_THAN_OR_EQUAL
          | :GREATER_THAN
          | :GREATER_THAN_OR_EQUAL
          | :EQUAL
          | :ARRAY_CONTAINS
          | :IN
          | :ARRAY_CONTAINS_ANY

  field :OPERATOR_UNSPECIFIED, 0
  field :LESS_THAN, 1
  field :LESS_THAN_OR_EQUAL, 2
  field :GREATER_THAN, 3
  field :GREATER_THAN_OR_EQUAL, 4
  field :EQUAL, 5
  field :ARRAY_CONTAINS, 7
  field :IN, 8
  field :ARRAY_CONTAINS_ANY, 9
end

defmodule Google.Firestore.V1.StructuredQuery.UnaryFilter.Operator do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t :: integer | :OPERATOR_UNSPECIFIED | :IS_NAN | :IS_NULL

  field :OPERATOR_UNSPECIFIED, 0
  field :IS_NAN, 2
  field :IS_NULL, 3
end

defmodule Google.Firestore.V1.StructuredQuery.CollectionSelector do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          collection_id: String.t(),
          all_descendants: boolean
        }
  defstruct [:collection_id, :all_descendants]

  field :collection_id, 2, type: :string
  field :all_descendants, 3, type: :bool
end

defmodule Google.Firestore.V1.StructuredQuery.Filter do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter_type: {atom, any}
        }
  defstruct [:filter_type]

  oneof :filter_type, 0
  field :composite_filter, 1, type: Google.Firestore.V1.StructuredQuery.CompositeFilter, oneof: 0
  field :field_filter, 2, type: Google.Firestore.V1.StructuredQuery.FieldFilter, oneof: 0
  field :unary_filter, 3, type: Google.Firestore.V1.StructuredQuery.UnaryFilter, oneof: 0
end

defmodule Google.Firestore.V1.StructuredQuery.CompositeFilter do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          op: Google.Firestore.V1.StructuredQuery.CompositeFilter.Operator.t(),
          filters: [Google.Firestore.V1.StructuredQuery.Filter.t()]
        }
  defstruct [:op, :filters]

  field :op, 1, type: Google.Firestore.V1.StructuredQuery.CompositeFilter.Operator, enum: true
  field :filters, 2, repeated: true, type: Google.Firestore.V1.StructuredQuery.Filter
end

defmodule Google.Firestore.V1.StructuredQuery.FieldFilter do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          field: Google.Firestore.V1.StructuredQuery.FieldReference.t() | nil,
          op: Google.Firestore.V1.StructuredQuery.FieldFilter.Operator.t(),
          value: Google.Firestore.V1.Value.t() | nil
        }
  defstruct [:field, :op, :value]

  field :field, 1, type: Google.Firestore.V1.StructuredQuery.FieldReference
  field :op, 2, type: Google.Firestore.V1.StructuredQuery.FieldFilter.Operator, enum: true
  field :value, 3, type: Google.Firestore.V1.Value
end

defmodule Google.Firestore.V1.StructuredQuery.Projection do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          fields: [Google.Firestore.V1.StructuredQuery.FieldReference.t()]
        }
  defstruct [:fields]

  field :fields, 2, repeated: true, type: Google.Firestore.V1.StructuredQuery.FieldReference
end

defmodule Google.Firestore.V1.StructuredQuery.UnaryFilter do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          operand_type: {atom, any},
          op: Google.Firestore.V1.StructuredQuery.UnaryFilter.Operator.t()
        }
  defstruct [:operand_type, :op]

  oneof :operand_type, 0
  field :op, 1, type: Google.Firestore.V1.StructuredQuery.UnaryFilter.Operator, enum: true
  field :field, 2, type: Google.Firestore.V1.StructuredQuery.FieldReference, oneof: 0
end

defmodule Google.Firestore.V1.StructuredQuery.FieldReference do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          field_path: String.t()
        }
  defstruct [:field_path]

  field :field_path, 2, type: :string
end

defmodule Google.Firestore.V1.StructuredQuery.Order do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          field: Google.Firestore.V1.StructuredQuery.FieldReference.t() | nil,
          direction: Google.Firestore.V1.StructuredQuery.Direction.t()
        }
  defstruct [:field, :direction]

  field :field, 1, type: Google.Firestore.V1.StructuredQuery.FieldReference
  field :direction, 2, type: Google.Firestore.V1.StructuredQuery.Direction, enum: true
end

defmodule Google.Firestore.V1.StructuredQuery do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          select: Google.Firestore.V1.StructuredQuery.Projection.t() | nil,
          from: [Google.Firestore.V1.StructuredQuery.CollectionSelector.t()],
          where: Google.Firestore.V1.StructuredQuery.Filter.t() | nil,
          order_by: [Google.Firestore.V1.StructuredQuery.Order.t()],
          start_at: Google.Firestore.V1.Cursor.t() | nil,
          end_at: Google.Firestore.V1.Cursor.t() | nil,
          offset: integer,
          limit: Google.Protobuf.Int32Value.t() | nil
        }
  defstruct [:select, :from, :where, :order_by, :start_at, :end_at, :offset, :limit]

  field :select, 1, type: Google.Firestore.V1.StructuredQuery.Projection
  field :from, 2, repeated: true, type: Google.Firestore.V1.StructuredQuery.CollectionSelector
  field :where, 3, type: Google.Firestore.V1.StructuredQuery.Filter
  field :order_by, 4, repeated: true, type: Google.Firestore.V1.StructuredQuery.Order
  field :start_at, 7, type: Google.Firestore.V1.Cursor
  field :end_at, 8, type: Google.Firestore.V1.Cursor
  field :offset, 6, type: :int32
  field :limit, 5, type: Google.Protobuf.Int32Value
end

defmodule Google.Firestore.V1.Cursor do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          values: [Google.Firestore.V1.Value.t()],
          before: boolean
        }
  defstruct [:values, :before]

  field :values, 1, repeated: true, type: Google.Firestore.V1.Value
  field :before, 2, type: :bool
end
