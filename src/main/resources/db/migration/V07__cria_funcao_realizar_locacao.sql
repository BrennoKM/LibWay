-- V07: Cria a função para processar o aluguel de um livro.

CREATE OR REPLACE FUNCTION realizar_locacao(
    p_cliente_id INT,
    p_catalogo_id INT
)
RETURNS VARCHAR AS $$

DECLARE
    v_estoque_atual INT;
    v_saldo_cliente NUMERIC(10, 2);
    v_valor_aluguel NUMERIC(10, 2);
    v_valor_sinal NUMERIC(10, 2);
    v_locador_id INT;
BEGIN
    LOCK TABLE catalogos_locador IN ROW EXCLUSIVE MODE;
    LOCK TABLE usuarios IN ROW EXCLUSIVE MODE;

    SELECT estoque, valor_aluguel, locador_id INTO v_estoque_atual, v_valor_aluguel, v_locador_id
    FROM catalogos_locador WHERE id = p_catalogo_id;

    SELECT saldo INTO v_saldo_cliente FROM usuarios WHERE id = p_cliente_id;

    IF v_estoque_atual <= 0 THEN
        RAISE EXCEPTION 'Estoque esgotado para este livro.';
    END IF;

    v_valor_sinal := v_valor_aluguel / 2;

    IF v_saldo_cliente < v_valor_sinal THEN
        RAISE EXCEPTION 'Saldo insuficiente para pagar o sinal de R$%', v_valor_sinal;
    END IF;

    UPDATE usuarios SET saldo = saldo - v_valor_sinal WHERE id = p_cliente_id;

    UPDATE usuarios SET saldo = saldo + v_valor_sinal WHERE id = v_locador_id;

    UPDATE catalogos_locador SET estoque = estoque - 1 WHERE id = p_catalogo_id;

    INSERT INTO locacoes (cliente_id, catalogo_id, status, valor_sinal)
    VALUES (p_cliente_id, p_catalogo_id, 'ATIVA', v_valor_sinal);

    RETURN 'Aluguel realizado com sucesso!';

EXCEPTION
    WHEN OTHERS THEN
        RETURN SQLERRM;
END;
$$ LANGUAGE plpgsql;