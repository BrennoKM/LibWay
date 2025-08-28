package com.spring.libway.repository;

import com.spring.libway.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.data.repository.query.Param;

import java.math.BigDecimal;
import java.util.Optional;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {

    Optional<Usuario> findByEmail(String email);

    @Query(value = "SELECT adicionar_saldo_usuario(:p_usuario_id, :p_valor_adicionar, :p_metodo_pagamento)", nativeQuery = true)
    String chamarFuncaoAdicionarSaldo(@Param("p_usuario_id") Integer usuarioId,
                                   @Param("p_valor_adicionar") BigDecimal valor,
                                   @Param("p_metodo_pagamento") String metodoPagamento);
}