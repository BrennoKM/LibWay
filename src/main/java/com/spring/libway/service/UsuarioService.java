package com.spring.libway.service;

import com.spring.libway.model.Deposito;
import com.spring.libway.model.Usuario;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.math.BigDecimal;
import java.util.List;

public interface UsuarioService extends UserDetailsService {

    Usuario salvarUsuario(Usuario usuario);

    Usuario getUsuarioLogado();

    void adicionarSaldo(BigDecimal valor, String metodoPagamento);

    List<Deposito> listarDepositosDoClienteLogado();

}