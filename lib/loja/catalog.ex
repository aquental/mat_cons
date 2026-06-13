defmodule Loja.Catalog do
  use Ash.Domain

  resources do
    resource Loja.Catalog.Product
    resource Loja.Catalog.ProductVariant
    resource Loja.Catalog.Category
  end
end
