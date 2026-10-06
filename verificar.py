# Checagem rápida (pra você, antes da aula): conecta e conta as linhas de cada tabela.
import mysql.connector

try:
    conexao = mysql.connector.connect(
        host="localhost",
        user="root",
        password="sua_senha",
        database="controle_gastos"
    )
except mysql.connector.Error as erro:
    print(f"Não conectou: {erro}")
    raise SystemExit(1)

cursor = conexao.cursor()

for tabela in ("usuarios", "categorias", "transacoes"):
    cursor.execute(f"SELECT COUNT(*) FROM {tabela}")
    (total,) = cursor.fetchone()
    print(f"{tabela}: {total} linhas")

cursor.close()
conexao.close()
print("Tudo certo: conexão ok e tabelas com dados.")
