defmodule Loja.Sales.Cart do
  use Ash.Resource,
    domain: Loja.Sales,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAdmin.Resource]

  postgres do
    table "carts"
    repo Loja.Repo
  end

  attributes do
    uuid_primary_key :id
    attribute :token, :uuid, allow_nil?: false
    attribute :status, :atom, constraints: [one_of: [:active, :converted, :abandoned]], default: :active
    attribute :expires_at, :utc_datetime_usec
    timestamps()
  end

  relationships do
    has_many :items, Loja.Sales.CartItem
  end

  actions do
    defaults [:read, :destroy]
    default_accept :*
  end
end
