# PRD — LOJA: Plataforma D2C de Materiais de Construção

> **Produto:** LOJA — E-commerce direct-to-consumer para materiais de construção
> **Versão:** v0.1 (PRD Inicial)
> **Autor:** Antonio Quental / Hermes Agent
> **Data:** 2026-06-13

---

## Sumário

1. [Executive Summary](#1-executive-summary)
2. [Contexto & Oportunidade](#2-contexto--oportunidade)
3. [Personas](#3-personas)
4. [Épicos & User Stories](#4-épicos--user-stories)
5. [Requisitos Funcionais](#5-requisitos-funcionais)
6. [Arquitetura Técnica (High-Level)](#6-arquitetura-técnica-high-level)
7. [Modelo de Dados (Entidades Core)](#7-modelo-de-dados-entidades-core)
8. [UX & Design](#8-ux--design)
9. [Roadmap & Marcos](#9-roadmap--marcos)
10. [Métricas de Sucesso](#10-métricas-de-sucesso)
11. [Fora do Escopo (v0.1)](#11-fora-do-escopo-v01)
12. [Riscos & Mitigações](#12-riscos--mitigações)

---

## 1. Executive Summary

A LOJA é uma plataforma **D2C (Direct-to-Consumer)** para venda de materiais de construção com curadoria técnica. O diferencial competitivo é um **consultor de obras com IA** que ajuda o cliente leigo a escolher os produtos certos para cada etapa da obra — eliminando o maior ponto de dor do setor: a assimetria de informação entre o vendedor e o comprador.

**Stack:** Elixir + Phoenix + Ash Framework + PostgreSQL  
**Público:** Consumidores finais (não CNPJ) que estão reformando ou construindo  
**Modelo:** Loja própria (single-tenant, D2C) — marketplace multi-vendedor fica para v2

**Por que Elixir/Phoenix/Ash?**  
- Concorrência massiva (BEAM) para suportar sessões simultâneas do chat IA  
- Ash Framework entrega um **domain layer declarativo** que mapeia 1:1 com regras de negócio de construção civil (categorias, composições, substituições de materiais)  
- Phoenix LiveView elimina a complexidade de SPA + API REST para um catálogo que não precisa de offline-first

---

## 2. Contexto & Oportunidade

### 2.1 O Problema

O mercado de materiais de construção para o consumidor final (não profissional) é fragmentado e de baixa confiança:

- **Assimetria de informação:** Cliente não sabe se precisa de cimento CP-II ou CP-IV, se argamassa AC-I ou AC-II, qual bloco cerâmico usar para parede interna vs externa
- **Auto-serviço falho:** Lojas físicas têm vendedores genéricos; e-commerces genéricos (Mercado Livre, Shopee) não têm curadoria técnica
- **Devoluções por erro de compra:** Cliente compra o produto errado por falta de orientação → frustração + custo logístico
- **Abandono de carrinho alto:** Sem confiança na escolha, o cliente hesita e abandona

### 2.2 A Oportunidade

Um e-commerce especializado com **IA consultiva** que:

1. Guia o cliente como um engenheiro ou mestre de obras experiente
2. Sugere produtos compatíveis entre si (argamassa + bloco + rejunte)
3. Calcula quantidades com base na metragem da obra
4. Previne erros comuns (comprar cimento errado, dimensionar errado)

**Tamanho de mercado:** O setor de materiais de construção no Brasil movimenta ~R$ 250B/ano. O D2C digital é menos de 5% — crescimento acelerado pós-pandemia.

### 2.3 Concorrência Indireta

| Concorrente | Força | Fragilidade |
|-------------|-------|-------------|
| Leroy Merlin (online) | Marca forte, estoque gigante | Catálogo genérico, sem curadoria técnica |
| Telhanorte / Tumelero | Entrega rápida em SP | Sem IA consultiva, foco em volume |
| Mercado Livre / Shopee | Tráfego massivo | Zero confiança técnica, produtos misturados |
| Lojas físicas de bairro | Atendimento pessoal | Estoque limitado, sem digital |

**Posicionamento da LOJA:** Curadoria técnica com IA — não somos o maior estoque, somos o que garante que você comprou o material **certo** para sua obra.

---

## 3. Personas

### 3.1 Pedro — "O Reformador de Apartamento"

- **Idade:** 32
- **Perfil:** Profissional CLT, comprou um apto de 65m², quer reformar
- **Conhecimento técnico:** Baixo — não sabe diferença entre massa corrida e fundo preparador
- **Dores:** Medo de comprar errado, vergonha de perguntar em loja, já devolveu produto
- **Comportamento:** Pesquisa no YouTube antes, desiste se ficar confuso
- **Job-to-be-done:** "Quero reformar meu banheiro sem errar na compra dos materiais"

### 3.2 Carla — "A Arquitetra Freelancer"

- **Idade:** 41
- **Perfil:** Arquiteta que especifica materiais para clientes residenciais
- **Conhecimento técnico:** Alto — sabe exatamente o que precisa
- **Dores:** Perde tempo cotando em várias lojas, precisa de lista de materiais organizada por cômodo
- **Comportamento:** Compra em volume para 2-3 obras simultâneas
- **Job-to-be-done:** "Quero um fornecedor confiável que me entregue tudo que especifiquei sem sustos"

### 3.3 Seu Jorge — "O Mestre de Obras"

- **Idade:** 55
- **Perfil:** Profissional autônomo, indica materiais para os clientes dele
- **Conhecimento técnico:** Experiência prática, mas não lê especificações técnicas
- **Dores:** Precisa de rapidez, compra pelo WhatsApp hoje, sem organização
- **Comportamento:** Manda áudio com lista, recebe orçamento, confirma no olho
- **Job-to-be-done:** "Quero pedir rápido sem burocracia e saber se vai ter estoque"

---

## 4. Épicos & User Stories

### EP-01: Catálogo e Navegação

| ID | User Story | Prioridade |
|----|-----------|-----------|
| US-01 | Como cliente, quero navegar por categorias (Hidráulica, Elétrica, Acabamento, Estrutural) para encontrar produtos rapidamente | P0 |
| US-02 | Como cliente, quero buscar produtos por nome, código ou aplicação (ex: "argamassa para piscina") | P0 |
| US-03 | Como cliente, quero ver fotos, descrição técnica, preço e estoque de cada produto | P0 |
| US-04 | Como cliente, quero filtrar por marca, faixa de preço, unidade (kg, metro, peça) | P1 |
| US-05 | Como cliente, quero ver produtos relacionados e compatíveis (ex: "quem comprou este bloco também levou esta argamassa") | P1 |

### EP-02: Carrinho e Checkout

| ID | User Story | Prioridade |
|----|-----------|-----------|
| US-06 | Como cliente, quero adicionar produtos ao carrinho com quantidade e ver subtotal | P0 |
| US-07 | Como cliente, quero revisar o carrinho antes de finalizar | P0 |
| US-08 | Como cliente, quero informar CEP para cálculo de frete | P0 |
| US-09 | Como cliente, quero escolher forma de entrega (retirada, transportadora) | P0 |
| US-10 | Como cliente, quero finalizar pedido com dados de contato (sem cadastro obrigatório — guest checkout) | P0 |
| US-11 | Como cliente, quero receber confirmação do pedido por e-mail/WhatsApp | P1 |

### EP-03: Consultor de Obras com IA

| ID | User Story | Prioridade |
|----|-----------|-----------|
| US-12 | Como cliente, quero descrever minha obra em linguagem natural ("vou rebocar uma parede de 15m²") e receber a lista de materiais necessários | P0 |
| US-13 | Como cliente, quero que o consultor calcule quantidades com base em medidas que eu informar | P0 |
| US-14 | Como cliente, quero que o consultor explique **por que** cada material é necessário (educativo, não só vendedor) | P0 |
| US-15 | Como cliente, quero adicionar todos os materiais sugeridos ao carrinho com um clique | P0 |
| US-16 | Como cliente, quero fazer perguntas de follow-up ("precisa de impermeabilizante também?") | P1 |
| US-17 | Como cliente, quero que o consultor sugira alternativas (marca X ou Y, qualidade similar, preço diferente) | P1 |

### EP-04: Admin Dashboard

| ID | User Story | Prioridade |
|----|-----------|-----------|
| US-18 | Como admin, quero gerenciar o catálogo (CRUD de produtos, categorias, marcas, variações) | P0 |
| US-19 | Como admin, quero ver pedidos recebidos com status (novo, confirmado, em separação, enviado, entregue) | P0 |
| US-20 | Como admin, quero atualizar o status do pedido manualmente | P0 |
| US-21 | Como admin, quero ver dashboard com métricas (pedidos/dia, receita, tickets médio, estoque baixo) | P1 |
| US-22 | Como admin, quero gerenciar o conteúdo do consultor de IA (produtos associados a cada tipo de obra, regras de substituição) | P1 |
| US-23 | Como admin, quero exportar pedidos para CSV | P2 |

---

## 5. Requisitos Funcionais

### RF-01: Catálogo (P0)

- Cada produto tem: nome, descrição curta, descrição técnica completa, SKU, marca, categoria (árvore de até 3 níveis), unidade de medida, preço, fotos (múltiplas), estoque, dimensões/peso, atributos dinâmicos por categoria (ex: cor para tintas, bitola para fios)
- Variações de produto: cor, tamanho, embalagem (saco 20kg / saco 50kg)
- Visibilidade: ativo/inativo, destaque (vitrine)
- Tags de aplicação: "uso externo", "uso interno", "resistente a fogo", "impermeável" — usadas pelo consultor de IA para matching

### RF-02: Busca e Filtros (P0)

- Busca full-text com tolerância a typos (ex: "cimento" → "cimemto" ainda encontra)
- Autocomplete com sugestões de produtos e categorias
- Filtros: faixa de preço, marca, categoria, disponibilidade
- Ordenação: relevância, menor preço, maior preço, nome A-Z

### RF-03: Carrinho (P0)

- Carrinho persistido em banco (session-based ou token-based, sem login obrigatório)
- Atualização de quantidade com validação de estoque
- Cálculo de subtotal por item e total geral
- Cupom de desconto (valor fixo ou percentual) — P1, mas preparar campo no modelo

### RF-04: Checkout (P0)

- Fluxo: Revisão do carrinho → CEP + Frete → Dados de contato → Confirmação
- **Sem gateway de pagamento na v0.1** — pedido é registrado como "PENDENTE" e o admin confirma por WhatsApp para acertar pagamento (PIX/transferência). *Sim, é manual — o MVP testa demanda antes de integrar stripe/asaas.*
- Cálculo de frete via tabela fixa por CEP (faixas) — transportadora externa depois
- Confirmação por e-mail

### RF-05: Consultor de Obras com IA (P0)

- **Interface:** Chat-style na página inicial ou overlay modal
- **Input:** Cliente descreve a obra em texto livre (ex: "vou assentar porcelanato 60x60 na sala de 25m²")
- **Processamento:** O sistema identifica:
  1. Tipo de obra (assentamento, reboco, pintura, hidráulica, elétrica)
  2. Materiais necessários (regras de domínio codificadas + IA para casos ambíguos)
  3. Quantidades (cálculo com base nas medidas informadas)
  4. Produtos compatíveis e alternativas
- **Output:** Lista estruturada de materiais com:
  - Nome do produto + link para página do produto
  - Quantidade calculada
  - Preço unitário e total por item
  - Breve explicação do porquê de cada item
  - Botão "Adicionar tudo ao carrinho"
- **Knowledge base:** Regras de compatibilidade e substituição gerenciáveis pelo admin (ex: "Para assentar porcelanato 60x60, use argamassa AC-III, não AC-I")
- **Modelo:** API de LLM (OpenAI / Anthropic / xAI Grok — decidir na implementação) com **system prompt curado** que só sugere produtos do catálogo real

### RF-06: Admin Dashboard (P0)

- Acesso protegido por login simples (admin único na v0.1 — email + senha com Phoenix Auth)
- **Módulos:**
  1. **Produtos:** CRUD completo com upload de imagens, variações, atributos, preço, estoque
  2. **Categorias:** Gerenciar árvore de categorias
  3. **Pedidos:** Lista de pedidos com filtro por status, ação de atualizar status, ver detalhes
  4. **Consultor:** Gerenciar regras de obra → materiais, sinônimos, compatibilidades
  5. **Dashboard:** Cards com métricas (pedidos hoje, receita do mês, produtos com estoque baixo)

---

## 6. Arquitetura Técnica (High-Level)

### 6.1 Stack Decidida

| Camada | Tecnologia | Justificativa |
|--------|-----------|---------------|
| Backend | Elixir 1.18+ / Phoenix 1.7+ | Concorrência BEAM para chat IA, maduro para web |
| Domain Layer | Ash Framework 3.x | Declarativo, gera API GraphQL/REST, migrações, autorização |
| Database | PostgreSQL 16 | Relacional maduro, JSONB para attributes flexíveis |
| Frontend | Phoenix LiveView + HEEx | Sem SPA — catálogo não precisa de offline, elimina camada REST |
| CSS | Tailwind CSS + DaisyUI | Prototipação rápida, componentes acessíveis |
| IA | API LLM (provider a definir) | System prompt + RAG sobre catálogo local |
| Deploy | Fly.io / Gigalixir / Hetzner + Docker | BEAM-native hosting |

### 6.2 Arquitetura de Alto Nível

```
┌─────────────────────────────────────────────────────────┐
│                    Navegador (Cliente)                    │
│  Phoenix LiveView (HEEx + Tailwind + DaisyUI)           │
└────────────────────────┬────────────────────────────────┘
                         │  WebSocket (LiveView)
                         ▼
┌─────────────────────────────────────────────────────────┐
│               Phoenix Application (BEAM)                 │
│                                                         │
│  ┌─────────┐  ┌──────────┐  ┌────────────────────┐    │
│  │  Live   │  │   Ash    │  │  Consultor IA       │    │
│  │  Views  │──│  Domain  │──│  (GenServer + HTTP  │    │
│  │         │  │  Layer   │  │   client para LLM)  │    │
│  └─────────┘  └────┬─────┘  └────────────────────┘    │
│                     │                                    │
│              ┌──────┴──────┐                             │
│              │ Ash.Resource│                             │
│              │ (PostgreSQL)│                             │
│              └─────────────┘                             │
└─────────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────┐
│                   PostgreSQL 16                          │
│  products | categories | orders | obra_rules | carts    │
└─────────────────────────────────────────────────────────┘
```

### 6.3 Por que Ash Framework?

- **Declarativo:** Recursos (Resource) são módulos Elixir com DSL — `attribute :name, :string`, `relationship :belongs_to, :category` — o framework gera migrações, validações, queries e mutations automaticamente
- **GraphQL nativo:** AshGraphQL gera schema GraphQL completo do domínio sem código extra
- **Autorização declarativa:** Políticas por recurso/ação — prepara o terreno para Kinde no futuro
- **Extensível:** AshJsonApi, AshPostgres, AshAdmin (dashboard admin pronto!) — AshAdmin é um dashboard automático gerado a partir dos recursos, editável e filtrável
- **Maturidade:** Ash 3.x estável, usado em produção

### 6.4 AshAdmin

O **AshAdmin** é uma gem (biblioteca) do ecossistema Ash que gera automaticamente um dashboard admin completo a partir dos Resources declarados. Isso significa:

- Admin funcional com CRUD de produtos, pedidos, regras **sem escrever uma linha de UI admin**
- Interface com filtros, paginação, relacionamentos, edição inline
- Pode ser estendido com páginas customizadas (dashboard de métricas) via LiveView

**Decisão:** Usar AshAdmin como base do admin e complementar com páginas LiveView custom para métricas e consultor.

### 6.5 Consultor de IA

```
┌──────────────┐     ┌─────────────────────────────────┐
│  LiveView    │────▶│  ConsultorObra                   │
│  (chat UI)   │     │  - GenServer (stateful session)  │
└──────────────┘     │  - System prompt curado          │
                     │  - RAG: produtos do catálogo     │
                     │  - Calculadora de quantidades    │
                     └────────┬────────────────────────┘
                              │ HTTP (Req)
                              ▼
                    ┌──────────────────┐
                    │  LLM API         │
                    │ (OpenAI/Grok/etc)│
                    └──────────────────┘
```

- **System prompt:** Contém regras de construção civil, tabela de compatibilidade de materiais, formato de saída estruturada
- **RAG simplificado:** Embeddings dos produtos + descrições → busca semântica para sugerir produtos do catálogo real
- **Calculadora:** Lógica determinística em Elixir para converter metros² em quantidade de material (ex: 1 saco de argamassa AC-III rende ~4m² para porcelanato 60x60)
- **Fallback:** Se LLM estiver offline, sugerir materiais por regras estáticas (admin configurou no dashboard)

---

## 7. Modelo de Dados (Entidades Core)

### Diagrama de Entidades (ASCII)

```
┌──────────────┐       ┌────────────────┐       ┌────────────────┐
│   Category    │       │    Product      │       │ ProductVariant │
│──────────────│       │────────────────│       │────────────────│
│ id           │──┐    │ id             │──┐    │ id             │
│ name         │  │    │ name           │  │    │ sku            │
│ slug         │  │    │ description    │  │    │ price          │
│ parent_id ───│──┤    │ technical_desc │  │    │ stock          │
│ icon         │  │    │ sku            │  │    │ unit           │
│ position     │  │    │ brand          │  │    │ weight         │
└──────────────┘  │    │ category_id ───│──┼────│ product_id ────│──┘
                   │    │ unit           │  │    │ attributes(JSONB)│
                   │    │ base_price     │  │    └────────────────┘
                   │    │ images(JSONB)  │  │
                   │    │ active(bool)   │  │
                   │    │ tags(JSONB)    │  │
                   │    │ metadata(JSONB)│  │
                   │    └────────────────┘  │
                   │                        │
┌──────────────┐   │    ┌────────────────┐  │
│  ObraRule     │   │    │     Cart        │  │
│──────────────│   │    │────────────────│  │
│ id           │   │    │ id             │  │
│ obra_type    │   │    │ token          │  │
│ description  │   │    │ status         │  │
│ materials[]  │   │    │ expires_at     │  │
│ formula_json │   │    └────────────────┘  │
└──────────────┘   │         │               │
                    │    ┌────────────────┐  │
                    │    │  CartItem       │  │
                    │    │────────────────│  │
                    │    │ id             │  │
                    │    │ cart_id        │  │
                    │    │ product_id ────│──┘
                    │    │ variant_id ────│───┘
                    │    │ quantity       │
                    │    │ unit_price     │
                    │    └────────────────┘
                    │
┌──────────────┐   │    ┌────────────────┐
│    Order      │    │    │  OrderItem     │
│──────────────│   │    │────────────────│
│ id           │   │    │ id             │
│ contact_name │   │    │ order_id       │
│ contact_phone│   │    │ product_id     │
│ contact_email│   │    │ variant_id     │
│ cep          │   │    │ quantity       │
│ shipping_addr│   │    │ unit_price     │
│ status       │   │    └────────────────┘
│ total        │   │
│ notes        │   │
│ status_log[] │   │
│ delivered_at │   │
└──────────────┘   │
```

### 7.1 Entidades Detalhadas

**Product**
- `id`: UUID (Ash default)
- `name`: string (ex: "Argamassa AC-III 20kg")
- `slug`: string (unique, gerado do name)
- `description`: text (curta, para vitrine)
- `technical_description`: text (longa, para página do produto)
- `sku`: string (unique, código do fornecedor)
- `brand`: string
- `category_id`: UUID (belongs_to Category)
- `unit`: enum (unidade, kg, metro, litro, peça, saco)
- `base_price`: decimal (preço da variante padrão)
- `images`: array de strings (URLs)
- `active`: boolean (controla visibilidade)
- `featured`: boolean (aparece na vitrine)
- `tags`: array de strings (["uso-externo", "impermeavel", "resistente-fogo"])
- `compatible_with`: array de UUIDs (produtos compatíveis)
- `metadata`: map (atributos dinâmicos por categoria — ex: cor, bitola, rendimento)
- `timestamps`: created_at, updated_at

**ProductVariant**
- `id`: UUID
- `product_id`: UUID (belongs_to Product)
- `sku`: string (unique)
- `price`: decimal
- `stock`: integer
- `unit`: enum (pode diferir do produto base — ex: produto em "kg", variante em "saco 20kg" / "saco 50kg")
- `weight_kg`: decimal (para frete)
- `attributes`: map (ex: {"embalagem": "20kg"}, {"cor": "branco"})
- `active`: boolean

**Category**
- `id`: UUID
- `name`: string ("Hidráulica")
- `slug`: string
- `parent_id`: UUID (nilável — self-reference para árvore)
- `icon`: string (nome do ícone Heroicons)
- `position`: integer (ordenação)
- `active`: boolean

**Cart**
- `id`: UUID
- `token`: string (uuid v4, enviado via cookie ou query param)
- `status`: enum (ativo, convertido, abandonado)
- `expires_at`: datetime (TTL de 7 dias para cleanup)
- `items`: has_many CartItem

**CartItem**
- `id`: UUID
- `cart_id`: UUID
- `product_id`: UUID
- `variant_id`: UUID (nilável — se não tiver variante, usa product.base_price)
- `quantity`: integer (> 0)
- `unit_price`: decimal (snapshot no momento da adição)

**Order**
- `id`: UUID
- `cart_id`: UUID (referência ao carrinho convertido)
- `contact_name`: string
- `contact_phone`: string
- `contact_email`: string
- `cep`: string
- `shipping_address`: text
- `shipping_method`: enum (retirada, transportadora)
- `shipping_cost`: decimal
- `subtotal`: decimal
- `total`: decimal
- `status`: enum (pendente, confirmado, separacao, enviado, entregue, cancelado)
- `status_log`: array de maps (timestamp + status + observação)
- `notes`: text (observações do cliente)
- `delivered_at`: datetime (nilável)
- `timestamps`

**ObraRule**
- `id`: UUID
- `obra_type`: string (ex: "assentar-porcelanato", "reboco-interno", "pintura-parede")
- `name`: string (ex: "Assentar Porcelanato 60x60")
- `description`: text (descrição para o admin)
- `prompt_template`: text (template do system prompt para o LLM)
- `materials`: array de maps — cada item: {product_id, quantity_formula, explanation, optional: boolean}
- `compatibility_rules`: array de strings (regras de domínio adicionais)
- `active`: boolean

---

## 8. UX & Design

### 8.1 Princípios

1. **Simplicidade acima de tudo** — catálogo de construção civil, não de moda. Cliente quer encontrar, entender e comprar. Zero firula.
2. **Mobile-first** — maior parte dos acessos será de celular (obra, transporte público)
3. **Acessibilidade** — contraste alto, fonte legível, botões grandes (mãos sujas de obra)
4. **Confiança visual** — cores "sóbrias" (laranja queimado + azul escuro + cinza), fotos reais dos produtos, sem stock photos genéricas

### 8.2 Páginas (v0.1)

| Página | Componentes Principais |
|--------|----------------------|
| **Home** | Banner + Consultor IA (CTA principal) + Categorias em grid + Produtos em destaque |
| **Catálogo** | Sidebar de categorias + Grid de produtos + Busca + Filtros |
| **Produto** | Fotos (galeria) + Nome + Preço + Variações + Descrição técnica + Compatíveis + Botão Add to Cart |
| **Carrinho** | Lista de itens + Quantidades + Subtotal + CEP/Frete + Botão Finalizar |
| **Checkout** | Formulário de contato + Resumo do pedido + Confirmação |
| **Confirmação** | Número do pedido + Instruções de pagamento + Resumo |
| **Admin/Produtos** | AshAdmin + CRUD + Upload de imagens |
| **Admin/Pedidos** | AshAdmin + Página custom de métricas |
| **Admin/Consultor** | CRUD ObraRules (LiveView custom) |

### 8.3 Fluxo Principal (User Journey)

```
Home → "Quero reformar meu banheiro"
  → Consultor IA pergunta medidas
  → Consultor sugere: argamassa AC-III, rejunte, porcelanato, impermeabilizante
  → Cliente vê explicação de cada item
  → "Adicionar tudo ao carrinho"
  → Carrinho → CEP → Frete → Dados → Confirmar
  → Tela de confirmação com número do pedido
```

---

## 9. Roadmap & Marcos

### Fase 1 — MVP (v0.1) — 6-8 semanas

| Marco | Entregas | Esforço |
|-------|----------|---------|
| **M1 — Setup do Projeto** | Phoenix + Ash + PostgreSQL + Tailwind + AshAdmin rodando | 1 semana |
| **M2 — Catálogo** | Resources Product, Category, ProductVariant + Admin CRUD + Seed de produtos de teste + Páginas P0 (home, catálogo, produto) | 2 semanas |
| **M3 — Carrinho + Checkout** | Resources Cart, CartItem, Order + Fluxo de checkout (sem pagamento) + Confirmação por e-mail | 1.5 semanas |
| **M4 — Consultor IA** | Resource ObraRule + GenServer de sessão + Integração LLM + Chat UI + Calculadora de quantidades + "Adicionar ao carrinho" | 2 semanas |
| **M5 — Admin Dashboard** | AshAdmin tuning + Página de métricas + CRUD ObraRules + Tuning de busca | 1 semana |
| **M6 — QA + Deploy** | Testes de fluxo completo, correções, deploy em produção | 1 semana |

### Fase 2 — v0.2 (pós-MVP)

- Gateway de pagamento (Stripe/Asaas)
- Autenticação (Kinde)
- Histórico de pedidos por cliente
- Nota Fiscal (integração com Nf-e)
- Busca com elasticsearch (se necessário)
- Avaliações de produtos

### Fase 3 — v1.0

- Multi-tenancy (marketplace multi-vendedor)
- App mobile (LiveView no celular via Phoenix LiveView, ou wrapper PWA)
- Integração com transportadoras (Jadlog, Correios)
- Programa de fidelidade
- Pix como forma de pagamento direta (se não estiver na v0.2)

---

## 10. Métricas de Sucesso

### 10.1 Métricas de Produto (v0.1)

| Métrica | Definição | Alvo (3 meses) |
|---------|-----------|----------------|
| Taxa de conversão | Pedidos finalizados / Visitantes únicos | > 3% |
| Ticket médio | Receita total / Pedidos | > R$ 350 |
| Uso do consultor IA | Sessões de consulta / Visitantes únicos | > 25% |
| Add-to-cart via consultor | Itens no carrinho originados do consultor / Total de itens | > 40% |
| Taxa de abandono de carrinho | Carrinhos criados que não viraram pedido | < 60% |
| Precisão do consultor | Produtos sugeridos que foram mantidos no pedido final | > 80% |

### 10.2 Métricas Técnicas

| Métrica | Alvo |
|---------|------|
| Tempo de carregamento (LCP) | < 2.5s (mobile) |
| Tempo de resposta do consultor IA | < 5s |
| Uptime | 99.5% |

---

## 11. Fora do Escopo (v0.1)

Estes itens estão **explicitamente excluídos** do MVP e serão tratados em versões futuras:

- ❌ **Pagamento online** — Pedidos são confirmados manualmente via WhatsApp (teste de demanda)
- ❌ **Cadastro/login de cliente** — Guest checkout com dados de contato apenas
- ❌ **Autenticação Kinde** — Admin único com Phoenix Auth simples; Kinde será adicionado quando houver multi-cliente
- ❌ **Nota Fiscal eletrônica** — Futuro (v0.2+)
- ❌ **Marketplace multi-vendedor** — Futuro (v1.0)
- ❌ **Aplicativo mobile nativo** — PWA na v0.1, app nativo na v1.0
- ❌ **Recomendação personalizada por perfil** (sem login, não há perfil)
- ❌ **Cupons/descontos automáticos** — Preparar modelo, sem lógica de aplicação
- ❌ **Integração com ERP/SIAG** — Futuro
- ❌ **Boleto/Pix como forma de pagamento automática** — Futuro
- ❌ **Logística reversa automatizada** — Manual por enquanto

---

## 12. Riscos & Mitigações

| Risco | Impacto | Probabilidade | Mitigação |
|-------|---------|---------------|-----------|
| **LLM alucina produto que não existe no catálogo** | Crítico — cliente tenta comprar o que não temos | Média | System prompt com validação rígida + pós-processamento que só permite produtos do banco + fallback para regras estáticas |
| **Ash Framework curva de aprendizado** | Médio — atraso no M1 | Alta | Usar AshIgniter (gerador de projetos), começar com Resources simples, evoluir gradualmente |
| **Cliente informa medidas erradas para o consultor** | Médio — sugestão de quantidade errada | Alta | Consultor deve deixar explícito "calculei com base em X metros que você informou" e permitir ajuste manual da quantidade |
| **Estoque negativo (race condition no checkout)** | Alto — vender o que não tem | Baixa | Usar row-level locking no PostgreSQL (SELECT ... FOR UPDATE) na confirmação do pedido |
| **Abandono por checkout manual (sem pagamento online)** | Alto — baixa conversão | Média | É uma decisão consciente do MVP. Se a taxa de abandono for > 70%, priorizar gateway de pagamento na v0.2 |
| **Deploy BEAM em PaaS desconhecido** | Médio — debugging de release | Média | Usar Docker + Docker Compose local, depois migrar para Fly.io que tem suporte nativo a Elixir |

---

## Apêndice A — Glossário

| Termo | Definição |
|-------|-----------|
| **D2C** | Direct-to-Consumer — venda direta ao consumidor final, sem intermediários |
| **Ash Framework** | Framework Elixir para domínios declarativos — Resources, APIs, autorização |
| **AshAdmin** | Dashboard admin automático gerado a partir dos Resources do Ash |
| **BEAM** | Máquina virtual do Erlang/Elixir — concorrência leve, tolerante a falhas |
| **LiveView** | Biblioteca Phoenix para interfaces dinâmicas via WebSocket, sem JavaScript |
| **ObraRule** | Regra de domínio que mapeia um tipo de obra aos materiais necessários |
| **Guest Checkout** | Checkout sem criação de conta — apenas nome, telefone, e-mail e endereço |
| **RAG** | Retrieval-Augmented Generation — busca semântica + LLM para respostas contextualizadas |
| **HEEx** | HTML + Elixir (templating engine do Phoenix) |

---

## Apêndice B — Decisões Técnicas Registradas

| # | Decisão | Alternativa Rejeitada | Motivo |
|---|---------|----------------------|--------|
| 01 | Phoenix LiveView (não SPA) | Next.js + REST API | Catálogo não precisa de offline; LiveView elimina camada API + estado duplicado |
| 02 | Ash Framework (não Ecto puro) | Ecto + Absinthe + Custom | Ash unifica Resource → GraphQL → Admin → Autorização em um ecossistema |
| 03 | PostgreSQL (não SQLite) | SQLite para protótipo | Já é a stack do PSI, reuso de conhecimento; AshPostgres maduro |
| 04 | Tailwind + DaisyUI (não componente lib) | Material UI, Chakra | DaisyUI é component-based sobre Tailwind, prototipação rápida, tema fácil |
| 05 | Guest checkout (não auth obrigatória) | Kinde/Clerk desde o início | Reduz atrito de entrada; auth adicionada depois sem quebrar fluxo |
| 06 | Pedido pendente + confirmação manual (não pagamento automático) | Stripe, Asaas | Testar demanda antes de investir em integração de pagamento |
| 07 | GenServer stateful para consultor (não HTTP stateless) | Lambda/serverless | Sessão do chat precisa de contexto entre mensagens; GenServer é nativo no BEAM |
