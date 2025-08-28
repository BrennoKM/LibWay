-- V1: Cria a tabela inicial para armazenar todos os usuários (Clientes e Locadores).

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    tipo_usuario VARCHAR(50) NOT NULL,
    saldo NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    cpf VARCHAR(11) UNIQUE,
    cnpj VARCHAR(14) UNIQUE
);