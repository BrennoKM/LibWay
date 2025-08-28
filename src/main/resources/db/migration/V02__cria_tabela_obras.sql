-- V02: Cria a tabela global de obras (livros).
-- Esta tabela serve como um repositório central de informações de livros.
-- Quando um locador cadastra um novo ISBN, ele é adicionado aqui.

CREATE TABLE obras (
    id SERIAL PRIMARY KEY,
    isbn VARCHAR(13) NOT NULL UNIQUE,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(255),
    editora VARCHAR(255),
    resumo_completo TEXT NOT NULL,
    sumario TEXT,
    texto_completo TEXT
);