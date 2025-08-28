package com.spring.libway.repository;

import com.spring.libway.model.CatalogoLocador;
import com.spring.libway.model.Obra;
import com.spring.libway.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CatalogoLocadorRepository extends JpaRepository<CatalogoLocador, Long> {

    List<CatalogoLocador> findByLocador(Usuario locador);

    Optional<CatalogoLocador> findByLocadorAndObra(Usuario locador, Obra obra);

}