-- V04: Cria a tabela para registrar as locações ativas e finalizadas.

CREATE TABLE locacoes (
    id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    CONSTRAINT fk_cliente FOREIGN KEY (cliente_id) REFERENCES usuarios(id),
    catalogo_id INT NOT NULL,
    CONSTRAINT fk_catalogo FOREIGN KEY (catalogo_id) REFERENCES catalogos_locador(id),
    data_locacao TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    data_devolucao TIMESTAMP WITH TIME ZONE,
    status VARCHAR(50) NOT NULL,
    valor_sinal NUMERIC(10, 2) NOT NULL,
    valor_final NUMERIC(10, 2)
);