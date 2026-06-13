defmodule Loja.Sales do
  use Ash.Domain

  resources do
    resource Loja.Sales.Cart
    resource Loja.Sales.CartItem
    resource Loja.Sales.Order
    resource Loja.Sales.OrderItem
  end
end
