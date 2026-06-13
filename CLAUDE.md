# LOJA — E-commerce D2C de materiais de construção

Stack: Elixir 1.18+ / Phoenix 1.7+ / Ash 3.x / PostgreSQL 18.
Frontend: Phoenix LiveView + HEEx + Tailwind + DaisyUI. SEM SPA, SEM camada API.
v0.1 = single-tenant, guest checkout, admin único.

## Comandos

- Setup: `mix setup`
- Servidor: `mix phx.server`
- Testes: `mix test`
- Migrations (Ash, NUNCA à mão): `mix ash.codegen <nome>` → revisar diff → `mix ash.migrate`
- Format/lint: `mix format` + `mix credo --strict`

## Extensões Ash instaladas (e SÓ estas)

- AshPostgres, AshPhoenix, AshAdmin.
- NÃO instalar AshGraphQL nem AshJsonApi. v0.1 é LiveView puro, sem API externa.
  (O PRD seção 6.3 menciona GraphQL como vantagem genérica do Ash — não é decisão deste projeto. Ignorar.)

## Regras Ash inquebráveis

- Lógica de domínio em ACTIONS de resources, nunca Repo direto.
- NUNCA escrever migration à mão. Sempre `mix ash.codegen`.
- Dinheiro: tipo `:decimal`, coluna `numeric(15,2)`. NUNCA float.
- AshAdmin é a base do admin. Não escrever CRUD admin à mão — só páginas LiveView custom para métricas e CRUD de ObraRule.

## Autorização (v0.1 — NÃO replicar padrões do Psi)

- Catálogo, carrinho, pedido = ACESSO PÚBLICO. Guest checkout, sem login de cliente.
- Policies SOMENTE nos resources/ações de admin (admin único via Phoenix Auth simples).
- NÃO existe Kinde, NÃO existe multi-tenancy, NÃO existe clinic_id/tenant_id nesta versão.

## Regras de domínio críticas (o modelo NÃO deixa óbvias)

- `CartItem.unit_price` e `OrderItem.unit_price` são SNAPSHOTS no momento da adição.
  NUNCA ler preço do produto em tempo real ao exibir carrinho/pedido. Preço pode mudar; pedido não.
- Confirmação de pedido (pendente→confirmado) deve travar estoque com lock
  (`SELECT ... FOR UPDATE` dentro de transação Ash). Risco: vender estoque inexistente.
- Consultor IA SÓ pode sugerir produtos que existem no catálogo. Pós-processar saída do LLM
  contra o banco; produto inexistente = descartar, nunca exibir.

## Decisões em aberto — SINALIZAR antes de codificar, não resolver sozinho

- `Product.compatible_with` = array de UUIDs no PRD. Isso quebra integridade referencial.
  Alternativa Ash: relationship many-to-many. Confirmar com o autor antes de implementar.
- `metadata`/`attributes` dinâmicos: JSONB livre vs. embedded resource tipado. Indefinido no PRD.

## Trabalho

- Mudou resource → `mix ash.codegen` ANTES de assumir schema aplicado.
- Parar e pedir aprovação antes de: migration destrutiva, mudança de action existente, mudança de policy.
- Divergência entre prompt e PRD: sinalizar, nunca resolver em silêncio.

## Regras de uso das libs (gerado — mix usage_rules.sync)

<!-- preenchido por: mix usage_rules.sync CLAUDE.md --all -->
