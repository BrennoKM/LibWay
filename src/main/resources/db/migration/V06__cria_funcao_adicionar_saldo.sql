-- V06: Atualiza a função para adicionar saldo e registrar o depósito.

CREATE OR REPLACE FUNCTION adicionar_saldo_usuario(
    p_usuario_id INT,
    p_valor_adicionar NUMERIC,
    p_metodo_pagamento VARCHAR
)
RETURNS VARCHAR AS $$

BEGIN
    IF p_valor_adicionar <= 0 THEN
        RAISE EXCEPTION 'O valor depositado deve ser maior que zero.';
    END IF;

    UPDATE usuarios
    SET saldo = saldo + p_valor_adicionar
    WHERE id = p_usuario_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Usuário com ID % não existe.', p_usuario_id;
    END IF;

    INSERT INTO depositos (usuario_id, valor, metodo_pagamento)
    VALUES (p_usuario_id, p_valor_adicionar, p_metodo_pagamento);

    RETURN 'Saldo adicionado com sucesso!';

END;
$$ LANGUAGE plpgsql;