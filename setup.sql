-- setup.sql — Controle de Gastos (4º bimestre, Aula 1)
-- Garante que o banco, as tabelas e uma carga mínima de dados existem.
-- Pode rodar quantas vezes quiser: não apaga nada e não duplica dados.
-- Cada tabela só recebe os dados de exemplo se estiver vazia.

CREATE DATABASE IF NOT EXISTS controle_gastos;
USE controle_gastos;

CREATE TABLE IF NOT EXISTS usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE
);

CREATE TABLE IF NOT EXISTS categorias (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS transacoes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  descricao VARCHAR(100),
  valor DECIMAL(10,2),
  data DATE,
  usuario_id INT,
  categoria_id INT,
  FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
  FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- Usuários (só se a tabela estiver vazia)
INSERT INTO usuarios (nome, email)
SELECT nome, email
FROM (
  SELECT 'Ana' AS nome, 'ana@email.com' AS email
  UNION ALL SELECT 'Beto', 'beto@email.com'
) AS novos_usuarios
WHERE NOT EXISTS (SELECT 1 FROM usuarios);

-- Categorias (só se a tabela estiver vazia)
INSERT INTO categorias (nome)
SELECT nome
FROM (
  SELECT 'Transporte' AS nome
  UNION ALL SELECT 'Alimentacao'
  UNION ALL SELECT 'Lazer'
  UNION ALL SELECT 'Moradia'
  UNION ALL SELECT 'Saude'
) AS novas_categorias
WHERE NOT EXISTS (SELECT 1 FROM categorias);

-- Transações (só se a tabela estiver vazia)
-- usuario_id e categoria_id são buscados pelo nome/e-mail, então não dependem dos ids gerados.
INSERT INTO transacoes (descricao, valor, data, usuario_id, categoria_id)
SELECT descricao, valor, data, usuario_id, categoria_id
FROM (
  SELECT 'Uber' AS descricao, 32.00 AS valor, '2026-10-01' AS data,
         (SELECT id FROM usuarios WHERE email = 'ana@email.com') AS usuario_id,
         (SELECT id FROM categorias WHERE nome = 'Transporte') AS categoria_id
  UNION ALL SELECT 'iFood', 58.50, '2026-10-02',
         (SELECT id FROM usuarios WHERE email = 'ana@email.com'),
         (SELECT id FROM categorias WHERE nome = 'Alimentacao')
  UNION ALL SELECT 'Mercado', 145.30, '2026-10-03',
         (SELECT id FROM usuarios WHERE email = 'ana@email.com'),
         (SELECT id FROM categorias WHERE nome = 'Alimentacao')
  UNION ALL SELECT 'Cinema', 45.00, '2026-10-04',
         (SELECT id FROM usuarios WHERE email = 'beto@email.com'),
         (SELECT id FROM categorias WHERE nome = 'Lazer')
  UNION ALL SELECT 'Padaria', 12.00, '2026-10-05',
         (SELECT id FROM usuarios WHERE email = 'beto@email.com'),
         (SELECT id FROM categorias WHERE nome = 'Alimentacao')
  UNION ALL SELECT 'Aluguel', 900.00, '2026-10-05',
         (SELECT id FROM usuarios WHERE email = 'ana@email.com'),
         (SELECT id FROM categorias WHERE nome = 'Moradia')
  UNION ALL SELECT 'Gasolina', 180.00, '2026-10-06',
         (SELECT id FROM usuarios WHERE email = 'beto@email.com'),
         (SELECT id FROM categorias WHERE nome = 'Transporte')
  UNION ALL SELECT 'Farmacia', 67.50, '2026-10-06',
         (SELECT id FROM usuarios WHERE email = 'ana@email.com'),
         (SELECT id FROM categorias WHERE nome = 'Saude')
  UNION ALL SELECT 'Streaming', 39.90, '2026-10-07',
         (SELECT id FROM usuarios WHERE email = 'beto@email.com'),
         (SELECT id FROM categorias WHERE nome = 'Lazer')
) AS novas_transacoes
WHERE NOT EXISTS (SELECT 1 FROM transacoes);

-- Conferência rápida
SELECT 'usuarios' AS tabela, COUNT(*) AS linhas FROM usuarios
UNION ALL SELECT 'categorias', COUNT(*) FROM categorias
UNION ALL SELECT 'transacoes', COUNT(*) FROM transacoes;
