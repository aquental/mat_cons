defmodule Loja.Catalog.Product do
  use Ash.Resource,
    domain: Loja.Catalog,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAdmin.Resource]

  postgres do
    table "products"
    repo Loja.Repo
  end

  # === Attributes ===

  attributes do
    uuid_primary_key :id

    attribute :name, :string, allow_nil?: false
    attribute :slug, :string, allow_nil?: false
    attribute :description, :string
    attribute :technical_description, :string
    attribute :sku, :string
    attribute :brand, :string
    attribute :unit, :string, default: "unidade"
    attribute :base_price, :decimal, allow_nil?: false
    attribute :images, {:array, :string}, default: []
    attribute :active, :boolean, default: true
    attribute :featured, :boolean, default: false
    attribute :tags, {:array, :string}, default: []
    attribute :compatible_ids, {:array, :uuid}, default: []
    attribute :metadata, :map, default: %{}

    timestamps()
  end

  # === Relationships ===

  relationships do
    belongs_to :category, Loja.Catalog.Category
    has_many :variants, Loja.Catalog.ProductVariant
  end

  # === Identity ===

  identities do
    identity :unique_sku, [:sku]
    identity :unique_slug, [:slug]
  end

  # === Authorisation (placeholder) ===

  actions do
    defaults [:read, :destroy]
    default_accept :*
  end
end
