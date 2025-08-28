package com.spring.libway.service;

import com.spring.libway.enums.TipoUsuario;
import com.spring.libway.model.Usuario;
import com.spring.libway.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.Optional;

@Service
public class UsuarioServiceImpl extends BaseService implements UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public Usuario getUsuarioLogado() {
        return super.getUsuarioLogado();
    }

    @Override
    public Usuario salvarUsuario(Usuario usuario) {
        Optional<Usuario> usuarioExistente = usuarioRepository.findByEmail(usuario.getEmail());

        if (usuarioExistente.isPresent()) {
            throw new IllegalStateException("Email " + usuario.getEmail() + " já está cadastrado.");
        }

        String senhaCriptografada = passwordEncoder.encode(usuario.getSenha());
        usuario.setSenha(senhaCriptografada);

        return usuarioRepository.save(usuario);
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Usuario usuario = usuarioRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("Usuário não encontrado com o email: " + email));

        return new User(
                usuario.getEmail(),
                usuario.getSenha(),
                Collections.singletonList(() -> "ROLE_" + usuario.getTipoUsuario().name())
        );
    }

    @Override
    public void adicionarSaldo(BigDecimal valor, String metodoPagamento) {
        Usuario usuarioLogado = getUsuarioLogado();

        if (usuarioLogado.getTipoUsuario() != TipoUsuario.CLIENTE) {
            throw new IllegalStateException("Apenas clientes podem adicionar saldo.");
        }

        String resultado = usuarioRepository.chamarFuncaoAdicionarSaldo(usuarioLogado.getId().intValue(), valor, metodoPagamento);

        if (!"Saldo adicionado com sucesso!".equals(resultado)) {
            throw new IllegalStateException(resultado);
        }
    }

}