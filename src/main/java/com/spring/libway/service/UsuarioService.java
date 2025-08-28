package com.spring.libway.service;

import com.spring.libway.model.Usuario;
import org.springframework.security.core.userdetails.UserDetailsService;

public interface UsuarioService extends UserDetailsService {

    Usuario salvarUsuario(Usuario usuario);

    Usuario getUsuarioLogado();

}