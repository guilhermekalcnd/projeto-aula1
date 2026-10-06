import mysql.connector

# Troque "sua_senha" pela senha do seu MySQL.
# Cuidado: não suba este arquivo pro GitHub com a senha real.
conexao = mysql.connector.connect(
    host="localhost",
    user="root",
    password="sua_senha",
    database="controle_gastos"
)

cursor = conexao.cursor()

cursor.execute("SELECT id, descricao, valor FROM transacoes")
linhas = cursor.fetchall()

for id, descricao, valor in linhas:
    print(f"{id} - {descricao}: R$ {valor}")

cursor.close()
conexao.close()
