package com.spring.libway.service;

import com.spring.libway.model.Usuario;
import com.spring.libway.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

public abstract class BaseService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    protected Usuario getUsuarioLogado() {
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