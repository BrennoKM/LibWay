-- V05: Cria a tabela para o histórico de depósitos.

CREATE TABLE depositos (
    id SERIAL PRIMARY KEY,
    usuario_id INT NOT NULL,
    CONSTRAINT fk_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    valor NUMERIC(10, 2) NOT NULL,
    metodo_pagamento VARCHAR(50),
    data_deposito TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);