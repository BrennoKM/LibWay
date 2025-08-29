package com.spring.libway.service;

import com.spring.libway.model.Locacao;
import com.spring.libway.model.Usuario;

import java.util.List;
import java.util.Optional;

public interface LocacaoService {

    List<Locacao> listarLocacoesAtivasDoClienteLogado();

    List<Locacao> listarLocacoesFinalizadasDoClienteLogado();

    List<Locacao> listarLocacoesAtivasDoLocadorLogado();

    List<Locacao> listarLocacoesFinalizadasDoLocadorLogado();

    void realizarLocacao(Long catalogoId);

    Locacao buscarPorIdDoClienteLogado(Long id);

    void devolverLivro(Long locacaoId);

}