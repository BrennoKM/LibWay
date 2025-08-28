package com.spring.libway.service;

import com.spring.libway.model.Obra;
import java.util.List;
import java.util.Optional;

public interface ObraService {

    Obra salvarObra(Obra obra);

    List<Obra> listarTodas();

    Optional<Obra> buscarPorId(Long id);

    Optional<Obra> buscarPorIsbn(String isbn);
}