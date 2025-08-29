package com.spring.libway.repository;

import com.spring.libway.model.Deposito;
import com.spring.libway.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DepositoRepository extends JpaRepository<Deposito, Long> {

    List<Deposito> findByUsuarioOrderByDataDepositoDesc(Usuario usuario);

}