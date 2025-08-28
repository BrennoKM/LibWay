package com.spring.libway.service;

import com.spring.libway.model.CatalogoLocador;
import java.math.BigDecimal;
import java.util.List;

public interface CatalogoLocadorService {

    CatalogoLocador adicionarObraAoCatalogo(Long obraId, Integer estoque, BigDecimal valorAluguel);

    List<CatalogoLocador> listarCatalogoDoLocadorLogado();

}