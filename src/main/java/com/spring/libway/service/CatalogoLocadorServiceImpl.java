package com.spring.libway.service;

import com.spring.libway.model.CatalogoLocador;
import com.spring.libway.model.Obra;
import com.spring.libway.model.Usuario;
import com.spring.libway.repository.CatalogoLocadorRepository;
import com.spring.libway.repository.ObraRepository;
import com.spring.libway.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
public class CatalogoLocadorServiceImpl implements CatalogoLocadorService {

    @Autowired
    private CatalogoLocadorRepository catalogoRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private ObraRepository obraRepository;

    @Override
    public CatalogoLocador adicionarObraAoCatalogo(Long obraId, Integer estoque, BigDecimal valorAluguel) {
        Usuario locador = getUsuarioLogado();

        Obra obra = obraRepository.findById(obraId)
                .orElseThrow(() -> new IllegalStateException("Obra com ID " + obraId + " não encontrada."));

        Optional<CatalogoLocador> itemExistente = catalogoRepository.findByLocadorAndObra(locador, obra);
        if (itemExistente.isPresent()) {
            throw new IllegalStateException("Esta obra já existe no seu catálogo.");
        }

        CatalogoLocador novoItem = new CatalogoLocador();
        novoItem.setLocador(locador);
        novoItem.setObra(obra);
        novoItem.setEstoque(estoque);
        novoItem.setValorAluguel(valorAluguel);

        return catalogoRepository.save(novoItem);
    }

    @Override
    public List<CatalogoLocador> listarCatalogoDoLocadorLogado() {
        Usuario locador = getUsuarioLogado();

        return catalogoRepository.findByLocador(locador);
    }

    private Usuario getUsuarioLogado() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String userEmail;

        if (principal instanceof UserDetails) {
            userEmail = ((UserDetails) principal).getUsername();
        } else {
            userEmail = principal.toString();
        }

        return usuarioRepository.findByEmail(userEmail)
                .orElseThrow(() -> new IllegalStateException("Usuário logado não encontrado no banco de dados."));
    }
}