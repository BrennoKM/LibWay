-- V03: Cria a tabela que representa o catálogo pessoal de cada locador.

CREATE TABLE catalogos_locador (
    id SERIAL PRIMARY KEY,
    locador_id INT NOT NULL,
    CONSTRAINT fk_locador FOREIGN KEY (locador_id) REFERENCES usuarios(id),
    obra_id INT NOT NULL,
    CONSTRAINT fk_obra FOREIGN KEY (obra_id) REFERENCES obras(id),
    estoque INT NOT NULL CHECK (estoque >= 0),
    valor_aluguel NUMERIC(10, 2) NOT NULL,
    UNIQUE (locador_id, obra_id)
);