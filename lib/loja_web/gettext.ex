defmodule LojaWeb.Gettext do
  @moduledoc """
  A module providing Internationalization with a gettext-based API.
  """
  use Gettext.Backend, otp_app: :loja, locales: ~w(en pt_BR), default_locale: "pt_BR"
end
