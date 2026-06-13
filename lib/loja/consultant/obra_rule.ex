defmodule Loja.Consultant.ObraRule do
  use Ash.Resource,
    domain: Loja.Consultant,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAdmin.Resource]

  postgres do
    table "obra_rules"
    repo Loja.Repo
  end

  attributes do
    uuid_primary_key :id
    attribute :obra_type, :string, allow_nil?: false
    attribute :name, :string, allow_nil?: false
    attribute :description, :string
    attribute :prompt_template, :string
    attribute :materials, {:array, :map}, default: []
    attribute :compatibility_rules, {:array, :string}, default: []
    attribute :active, :boolean, default: true
    timestamps()
  end

  actions do
    defaults [:read, :destroy]
    default_accept :*
  end
end
