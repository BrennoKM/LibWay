package com.spring.libway.service;

import com.spring.libway.model.Locacao;
import com.spring.libway.model.Usuario;
import com.spring.libway.repository.LocacaoRepository;
import com.spring.libway.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

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

    @Override
    public void realizarLocacao(Long catalogoId) {
        Usuario cliente = getUsuarioLogado();

        String resultado = locacaoRepository.chamarFuncaoRealizarLocacao(cliente.getId().intValue(), catalogoId.intValue());

        if (!"Aluguel realizado com sucesso!".equals(resultado)) {
            throw new IllegalStateException(resultado);
        }
    }

    @Override
    public Locacao buscarPorIdDoClienteLogado(Long id) {
        Usuario cliente = getUsuarioLogado();
        Optional<Locacao> locacao = locacaoRepository.findByIdAndCliente(id, cliente);

        return locacao.orElse(null);
    }
}