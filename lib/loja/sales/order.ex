defmodule Loja.Sales.Order do
  use Ash.Resource,
    domain: Loja.Sales,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAdmin.Resource]

  postgres do
    table "orders"
    repo Loja.Repo
  end

  attributes do
    uuid_primary_key :id
    attribute :contact_name, :string
    attribute :contact_phone, :string
    attribute :contact_email, :string
    attribute :cep, :string
    attribute :shipping_address, :string
    attribute :shipping_method, :atom, constraints: [one_of: [:retirada, :transportadora]]
    attribute :shipping_cost, :decimal, default: Decimal.new("0")
    attribute :subtotal, :decimal, allow_nil?: false
    attribute :total, :decimal, allow_nil?: false
    attribute :status, :atom, constraints: [one_of: [:pendente, :confirmado, :separacao, :enviado, :entregue, :cancelado]], default: :pendente
    attribute :status_log, :map, default: %{}
    attribute :notes, :string
    attribute :delivered_at, :utc_datetime_usec
    timestamps()
  end

  relationships do
    belongs_to :cart, Loja.Sales.Cart
    has_many :items, Loja.Sales.OrderItem
  end

  actions do
    defaults [:read, :destroy]
    default_accept :*
  end
end
