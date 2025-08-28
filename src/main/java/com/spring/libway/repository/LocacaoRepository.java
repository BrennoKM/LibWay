package com.spring.libway.repository;

import com.spring.libway.model.Locacao;
import com.spring.libway.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LocacaoRepository extends JpaRepository<Locacao, Long> {

    List<Locacao> findByClienteOrderByDataLocacaoDesc(Usuario cliente);

}