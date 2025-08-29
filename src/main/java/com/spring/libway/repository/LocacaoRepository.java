package com.spring.libway.repository;

import com.spring.libway.model.Locacao;
import com.spring.libway.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface LocacaoRepository extends JpaRepository<Locacao, Long> {

    List<Locacao> findByClienteOrderByDataLocacaoDesc(Usuario cliente);

    @Query(value = "SELECT realizar_locacao(:p_cliente_id, :p_catalogo_id)", nativeQuery = true)
    String chamarFuncaoRealizarLocacao(@Param("p_cliente_id") Integer clienteId, @Param("p_catalogo_id") Integer catalogoId);

    Optional<Locacao> findByIdAndCliente(Long id, Usuario cliente);

    @Query(value = "SELECT devolver_locacao(:p_locacao_id)", nativeQuery = true)
    String chamarFuncaoDevolverLocacao(@Param("p_locacao_id") Integer locacaoId);

}