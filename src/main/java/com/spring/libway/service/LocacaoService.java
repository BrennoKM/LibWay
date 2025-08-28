package com.spring.libway.service;

import com.spring.libway.model.Locacao;
import java.util.List;

public interface LocacaoService {

    List<Locacao> listarLocacoesDoClienteLogado();

}