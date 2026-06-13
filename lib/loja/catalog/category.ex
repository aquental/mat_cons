defmodule Loja.Catalog.Category do
  use Ash.Resource,
    domain: Loja.Catalog,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAdmin.Resource]

  postgres do
    table "categories"
    repo Loja.Repo
  end

  attributes do
    uuid_primary_key :id
    attribute :name, :string, allow_nil?: false
    attribute :slug, :string, allow_nil?: false
    attribute :icon, :string
    attribute :position, :integer, default: 0
    attribute :active, :boolean, default: true
    timestamps()
  end

  relationships do
    belongs_to :parent, Loja.Catalog.Category, primary_key?: false
    has_many :products, Loja.Catalog.Product
  end

  identities do
    identity :unique_category_slug, [:slug]
  end

  actions do
    defaults [:read, :destroy]
    default_accept :*
  end
end
