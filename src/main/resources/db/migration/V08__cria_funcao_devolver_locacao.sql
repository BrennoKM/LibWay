-- V08__cria_funcao_devolver_locacao.sql

CREATE OR REPLACE FUNCTION devolver_locacao(
    p_locacao_id INT
)
RETURNS TEXT AS $$

DECLARE
    v_locacao RECORD;
    v_valor_restante NUMERIC;
    v_cliente_id INT;
    v_catalogo_id INT;
    v_saldo_atual NUMERIC;
BEGIN
    SELECT l.cliente_id, l.catalogo_id, l.valor_sinal, u.saldo
    INTO v_cliente_id, v_catalogo_id, v_valor_restante, v_saldo_atual
    FROM locacoes l
    JOIN usuarios u ON u.id = l.cliente_id
    WHERE l.id = p_locacao_id AND l.status = 'ATIVA';

    IF NOT FOUND THEN
        RETURN 'Erro: Locação não encontrada ou já finalizada.';
    END IF;

    IF v_saldo_atual < v_valor_restante THEN
        RETURN 'Erro: Saldo insuficiente para finalizar a locação.';
    END IF;

    UPDATE usuarios
    SET saldo = saldo - v_valor_restante
    WHERE id = v_cliente_id;

    IF NOT FOUND THEN
        RETURN 'Erro: Usuário não encontrado.';
    END IF;

    UPDATE catalogos_locador
    SET estoque = estoque + 1
    WHERE id = v_catalogo_id;

    IF NOT FOUND THEN
        RETURN 'Erro: Catálogo não encontrado.';
    END IF;

    UPDATE locacoes
    SET status = 'FINALIZADA',
        data_devolucao = NOW()
    WHERE id = p_locacao_id;

    IF NOT FOUND THEN
        RETURN 'Erro: Locação não encontrada para atualização.';
    END IF;

    RETURN 'Livro devolvido com sucesso!';
END;
$$ LANGUAGE plpgsql;