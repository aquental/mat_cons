defmodule Loja.Sales.OrderItem do
  use Ash.Resource,
    domain: Loja.Sales,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAdmin.Resource]

  postgres do
    table "order_items"
    repo Loja.Repo
  end

  attributes do
    uuid_primary_key :id
    attribute :quantity, :integer, allow_nil?: false
    attribute :unit_price, :decimal, allow_nil?: false
    timestamps()
  end

  relationships do
    belongs_to :order, Loja.Sales.Order
    belongs_to :product, Loja.Catalog.Product
    belongs_to :variant, Loja.Catalog.ProductVariant
  end

  actions do
    defaults [:read, :destroy]
    default_accept :*
  end
end
