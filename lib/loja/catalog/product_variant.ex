defmodule Loja.Catalog.ProductVariant do
  use Ash.Resource,
    domain: Loja.Catalog,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAdmin.Resource]

  postgres do
    table "product_variants"
    repo Loja.Repo
  end

  attributes do
    uuid_primary_key :id
    attribute :sku, :string, allow_nil?: false
    attribute :price, :decimal, allow_nil?: false
    attribute :stock, :integer, default: 0
    attribute :unit, :string, default: "unidade"
    attribute :weight_kg, :decimal
    attribute :attributes, :map, default: %{}
    attribute :active, :boolean, default: true
    timestamps()
  end

  relationships do
    belongs_to :product, Loja.Catalog.Product
  end

  identities do
    identity :unique_variant_sku, [:sku]
  end

  actions do
    defaults [:read, :destroy]
    default_accept :*
  end
end
