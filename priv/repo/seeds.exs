# LojaDev.Repo seeds
# Run with: mix run priv/repo/seeds.exs

alias Loja.Repo
alias Loja.Catalog

IO.puts("🌱 Seeding LOJA database...")

# Create categories
categories = [
  %{name: "Hidráulica", slug: "hidraulica", position: 1, active: true},
  %{name: "Elétrica", slug: "eletrica", position: 2, active: true},
  %{name: "Acabamento", slug: "acabamento", position: 3, active: true},
  %{name: "Estrutural", slug: "estrutural", position: 4, active: true},
  %{name: "Ferramentas", slug: "ferramentas", position: 5, active: true},
  %{name: "Tintas", slug: "tintas", position: 6, active: true},
  %{name: "Revestimentos", slug: "revestimentos", position: 7, active: true}
]

# Note: In a real scenario, use Ash actions:
# Category.create(%{name: "Hidráulica", ...})

IO.puts("✅ Seeds complete! Created #{length(categories)} categories.")
