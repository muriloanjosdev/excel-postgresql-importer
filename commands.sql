-- DASHBOARD --------------------------------------------------------------------------------

-- scritp
WITH

base AS (
  SELECT
        v.id_pedido,
        v.data_venda,
        v.quantidade_p,
        p.produto,
        p.preco_unitario,
        p.categoria,
        v.quantidade_p * p.preco_unitario AS valor_item
    FROM vendas v
    INNER JOIN produtos p ON v.id_produto = p.id_produto
),

kpis AS (
    SELECT
        ROUND(SUM(quantidade_p * preco_unitario::NUMERIC), 2) AS faturamento_total,
        COUNT(DISTINCT id_pedido) AS total_pedidos,
        SUM(quantidade_p) AS total_unidades_vendidas,
        ROUND(SUM(valor_item::NUMERIC) / NULLIF(COUNT(DISTINCT id_pedido), 0), 2) AS ticket_medio
    FROM base
),

faturamento_mensal AS (
    SELECT
        DATE_TRUNC('month', data_venda) AS mes,
        ROUND(SUM(valor_item::NUMERIC), 2) AS faturamento_mensal
    FROM base
    GROUP BY DATE_TRUNC('month', data_venda)
),

ranking_produtos AS (
    SELECT
        produto,
        ROUND(SUM(valor_item::NUMERIC), 2) AS faturamento_produto,
        SUM(quantidade_p) AS unidades_produto,
        RANK() OVER (ORDER BY SUM(valor_item) DESC) AS ranking_geral
    FROM base
	GROUP BY produto
)

-- KPIs gerais
SELECT * FROM kpis;

-- Faturamento por mês
-- SELECT * FROM faturamento_mensal ORDER BY mes;

-- Ranking de produtos
-- SELECT * FROM ranking_produtos ORDER BY ranking_geral;