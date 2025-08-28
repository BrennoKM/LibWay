package com.spring.libway.controller;

import com.spring.libway.model.Locacao;
import com.spring.libway.model.Usuario;
import com.spring.libway.service.LocacaoService;
import com.spring.libway.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import java.util.List;

@Controller
@RequestMapping("/cliente")
public class ClienteController {

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private LocacaoService locacaoService;

    @GetMapping("/home")
    public String mostrarHomeCliente(Model model) {
        Usuario cliente = usuarioService.getUsuarioLogado();
        List<Locacao> locacoes = locacaoService.listarLocacoesDoClienteLogado();
        model.addAttribute("cliente", cliente);
        model.addAttribute("locacoes", locacoes);

        return "cliente/home";
    }

}