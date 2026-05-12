# Importador Excel para PostgreSQL
 
Script Python que importa abas de um arquivo Excel para tabelas no PostgreSQL.
 
## Instalação
 
```bash
pip install pandas psycopg2-binary openpyxl sqlalchemy
```
 
## Configuração
 
Edite as variáveis no topo do `script.py`:
 
| Variável | O que é |
|---|---|
| `EXCEL_PATH` | Caminho do arquivo Excel |
| `DB_CONFIG` | Credenciais do banco de dados |
| `SHEETS` | Mapeamento de aba → tabela |
| `IF_EXISTS` | `replace`, `append` ou `fail` |
 
### Opções do `IF_EXISTS`
 
| Valor | Comportamento |
|---|---|
| `replace` | Apaga a tabela e recria com os novos dados |
| `append` | Mantém os dados existentes e adiciona as novas linhas |
| `fail` | Retorna erro se a tabela já existir |
 
---
 
## Como rodar
 
Siga os três passos abaixo na ordem indicada.
 
### Passo 1 — Rodar o script de insert
 
Execute o script para importar os dados do Excel para o PostgreSQL:
 
```bash
python script.py
```
 
---
 
### Passo 2 — Tratar os nomes das colunas
 
Após a importação, renomeie as colunas para os nomes padronizados executando os comandos abaixo no seu banco de dados:
 
```sql
-- Tabela: vendas
ALTER TABLE vendas RENAME COLUMN "Data"               TO data_venda;
ALTER TABLE vendas RENAME COLUMN "ID. Pedido"         TO id_pedido;
ALTER TABLE vendas RENAME COLUMN "ID. Produto"        TO id_produto;
ALTER TABLE vendas RENAME COLUMN "Quantidade"         TO quantidade_p;
ALTER TABLE vendas RENAME COLUMN "Forma de Pagamento" TO forma_pagamento;
ALTER TABLE vendas RENAME COLUMN "Canal de Vendas"    TO canal_vendas;
 
-- Tabela: produtos
ALTER TABLE produtos RENAME COLUMN "ID"                   TO id;
ALTER TABLE produtos RENAME COLUMN "ID. Produto"          TO id_produto;
ALTER TABLE produtos RENAME COLUMN "Produto"              TO produto;
ALTER TABLE produtos RENAME COLUMN "Categoria"            TO categoria;
ALTER TABLE produtos RENAME COLUMN "Preço Unitário (R$)"  TO preco_unitario;
```
 
---
 
### Passo 3 — Rodar os comandos SQL
 
Com as colunas já renomeadas, rode diretamente no seu cliente SQL (pgAdmin) os comandos contidos em `commands.sql`.