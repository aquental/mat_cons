# LOJA — Plataforma D2C de Materiais de Construção

**Stack:** Elixir + Phoenix + Ash Framework + PostgreSQL  
**Diferencial:** Consultor de obras com IA integrado

> Repositório oficial do projeto LOJA — e-commerce direct-to-consumer para materiais
> de construção com consultoria técnica via inteligência artificial.

---

## Stack

| Camada       | Tecnologia                                   |
| ------------ | -------------------------------------------- |
| Backend      | Elixir 1.20+ / Phoenix 1.8+                  |
| Domain Layer | Ash Framework 3.x                            |
| Database     | PostgreSQL 18                                |
| Frontend     | Phoenix LiveView + HEEx + Tailwind + DaisyUI |
| IA           | API LLM (a definir: OpenAI / xAI Grok)       |
| Deploy       | Fly.io / Gigalixir                           |

## Quick Start

```bash
# Pré-requisitos: Erlang/OTP 27+, Elixir 1.18+, PostgreSQL 16+
git clone git@github.com:aquental/mat_cons.git
cd mat_cons
mix setup
mix phx.server
```

## Estrutura do Projeto

```
mat_cons/
├── lib/
│   ├── loja/           # Domain layer (Ash Resources)
│   │   ├── catalog/    # Produtos, Categorias, Variantes
│   │   ├── sales/      # Carrinho, Pedidos
│   │   ├── consultant/ # Consultor de Obras (IA + regras)
│   │   └── admin/      # Lógica do dashboard
│   ├── loja_web/       # LiveView pages
│   └── loja.ex         # Application module
├── docs/
│   └── PRD.md          # Product Requirements Document
├── config/
└── mix.exs
```

## Documentação

- **[PRD](docs/PRD.md)** — Product Requirements Document completo
- **Modelo de Dados** — Ver PRD Seção 7 para entidades e relacionamentos
- **Roadmap** — Ver PRD Seção 9 para marcos e cronograma

## Licença

MIT — veja [LICENSE](LICENSE)
