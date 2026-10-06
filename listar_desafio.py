import mysql.connector

# Desafio da aula: mostrar só as transações com valor maior que 50.
conexao = mysql.connector.connect(
    host="localhost",
    user="root",
    password="sua_senha",
    database="controle_gastos"
)

cursor = conexao.cursor()

cursor.execute("SELECT id, descricao, valor FROM transacoes WHERE valor > 50")
linhas = cursor.fetchall()

for id, descricao, valor in linhas:
    print(f"{id} - {descricao}: R$ {valor}")

cursor.close()
conexao.close()
