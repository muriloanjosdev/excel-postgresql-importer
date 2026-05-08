import pandas as pd
from sqlalchemy import create_engine

# VARIÁVEIS

EXCEL_PATH = r"C:\Users\User\Desktop\SeuArquivoExcel.xlsx"

DB_CONFIG = {
    "host": "localhost",
    "port": 5432,
    "database": "nome_db",
    "user": "user_db",
    "password": "senha_db",
}

SHEETS = {
    "Aba1": "nome_tabela_noDB",
    "Aba2": "nome_tabela_noDB"
}

IF_EXISTS = "replace"

# FUNÇÕES

def get_engine(cfg):
    """
    Cria e retorna uma engine de conexão com o banco de dados PostgreSQL.

    Parâmetros

    cfg : dict
        Dicionário com as credenciais de conexão. Deve conter as chaves:
        - host (str): Endereço do servidor.
        - port (int): Porta do banco de dados.
        - database (str): Nome do banco de dados.
        - user (str): Usuário do banco de dados.
        - password (str): Senha do usuário.

    Retorna

    sqlalchemy.engine.Engine
        Engine configurada para conexão via psycopg2.
    """
    url = (
        f"postgresql+psycopg2://{cfg['user']}:{cfg['password']}"
        f"@{cfg['host']}:{cfg['port']}/{cfg['database']}"
    )
    return create_engine(url)

def import_sheets(excel_path, sheets, engine, if_exists):
    """
    Lê a(s) aba(s) do arquivo Excel e importa cada uma como tabela no banco de dados.

    Parâmetros
    
    excel_path : str
        Caminho para o arquivo Excel (.xlsx).
    sheets : dict
        Mapeamento do nome da(s) aba(s) no Excel e nome da tabela no banco.
        Exemplo: {"Aba1": "tabela1", "Aba2": "tabela2"}.
    engine : sqlalchemy.engine.Engine
        Engine de conexão com o banco de dados.
    if_exists : {"replace", "append", "fail"}
        Comportamento caso a tabela já exista no banco:
        - "replace": recria a tabela e substitui os dados.
        - "append": insere os dados sem apagar os existentes.
        - "fail": lança um erro se a tabela já existir.

    Retorna
    
    None
    """
    for sheet_name, table_name in sheets.items():
        df = pd.read_excel(excel_path, sheet_name=sheet_name)

        df.to_sql(
            name=table_name,
            con=engine,
            if_exists=if_exists,
            index=False,
            chunksize=1000,     # controla quantas linhas o pandas envia para o banco de uma vez
        )

if __name__ == "__main__":
    engine = get_engine(DB_CONFIG)
    import_sheets(EXCEL_PATH, SHEETS, engine, IF_EXISTS)
    print("Importação concluída!")