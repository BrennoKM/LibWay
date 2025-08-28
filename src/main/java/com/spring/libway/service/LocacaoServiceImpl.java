package com.spring.libway.service;

import com.spring.libway.model.Locacao;
import com.spring.libway.model.Usuario;
import com.spring.libway.repository.LocacaoRepository;
import com.spring.libway.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LocacaoServiceImpl extends BaseService implements LocacaoService {

    @Autowired
    private LocacaoRepository locacaoRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Override
    public List<Locacao> listarLocacoesDoClienteLogado() {
        Usuario cliente = getUsuarioLogado();

        return locacaoRepository.findByClienteOrderByDataLocacaoDesc(cliente);
    }

}