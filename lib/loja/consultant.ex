defmodule Loja.Consultant do
  use Ash.Domain

  resources do
    resource Loja.Consultant.ObraRule
  end
end
