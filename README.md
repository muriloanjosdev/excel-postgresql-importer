# Importador Excel → PostgreSQL
 
Script Python que importa dados de um arquivo Excel para tabelas no PostgreSQL.
 
## Instalação
 
```bash
pip install pandas psycopg2-binary openpyxl sqlalchemy
```
 
## Configuração
 
Edite as variáveis no topo do `main.py`:
 
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
 
## Como rodar
 
```bash
python import.py
```
